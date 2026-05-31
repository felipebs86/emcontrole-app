import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../core/database/app_database.dart';
import '../../../core/notifications/local_notification_service.dart';
import '../data/application_record_repository.dart';
import '../data/medication_catalog_data_source.dart';
import '../data/treatment_repository.dart';
import '../../timeline/data/treatment_change_repository.dart';
import '../../timeline/domain/treatment_change_record.dart';
import 'application_eligibility_service.dart';
import 'application_record.dart';
import 'application_rotation_service.dart';
import 'medication.dart';
import 'medication_schedule_service.dart';
import 'treatment_snapshot.dart';

final treatmentSessionStore = TreatmentSessionStore.persistent();

class TreatmentSessionStore extends ChangeNotifier {
  TreatmentSessionStore([
    this._rotationService = const ApplicationRotationService(),
    this._eligibilityService = const ApplicationEligibilityService(),
    this._scheduleService = const MedicationScheduleService(),
    this._notificationService = localNotificationService,
    this._treatmentRepository,
    this._applicationRecordRepository,
    this._treatmentChangeRepository,
  ]);

  TreatmentSessionStore.persistent()
    : this(
        const ApplicationRotationService(),
        const ApplicationEligibilityService(),
        const MedicationScheduleService(),
        localNotificationService,
        TreatmentRepository(appDatabase),
        ApplicationRecordRepository(appDatabase),
        TreatmentChangeRepository(appDatabase),
      );

  final ApplicationRotationService _rotationService;
  final ApplicationEligibilityService _eligibilityService;
  final MedicationScheduleService _scheduleService;
  final LocalNotificationService _notificationService;
  final TreatmentRepository? _treatmentRepository;
  final ApplicationRecordRepository? _applicationRecordRepository;
  final TreatmentChangeDataSource? _treatmentChangeRepository;
  final List<ApplicationRecord> _records = [];

  Medication? _medication;
  String? _userName;
  bool _remindersEnabled = false;
  String? _currentApplicationPointId;
  DateTime? _currentScheduledAt;
  DateTime? _configuredScheduledAt;

  Medication? get medication => _medication;

  String? get userName => _userName;

  bool get remindersEnabled => _remindersEnabled;

  String? get currentApplicationPointId => _currentApplicationPointId;

  DateTime? get currentScheduledAt => _currentScheduledAt;

  DateTime? get configuredScheduledAt => _configuredScheduledAt;

  List<ApplicationRecord> get records => List.unmodifiable(_records);

  ApplicationPoint? get currentApplicationPoint {
    final medication = _medication;
    if (medication == null) {
      return null;
    }

    return _rotationService.getPointById(
      medication,
      _currentApplicationPointId,
    );
  }

  ApplicationPoint? get nextApplicationPoint {
    final medication = _medication;
    if (medication == null) {
      return null;
    }

    return _rotationService.getNextPoint(
      medication,
      _currentApplicationPointId,
    );
  }

  Future<void> load() async {
    final treatmentRepository = _treatmentRepository;
    final recordRepository = _applicationRecordRepository;
    if (treatmentRepository == null || recordRepository == null) {
      return;
    }

    final snapshot = await treatmentRepository.loadActiveTreatment();
    if (snapshot == null) {
      return;
    }

    final medication = const MedicationCatalogDataSource()
        .loadMedications()
        .where((medication) => medication.id == snapshot.medicationId)
        .firstOrNull;
    if (medication == null) {
      return;
    }

    _medication = medication;
    _userName = snapshot.userName;
    _remindersEnabled = snapshot.remindersEnabled;
    _currentApplicationPointId = snapshot.selectedApplicationPointId;
    _configuredScheduledAt = snapshot.scheduledAt;
    _records
      ..clear()
      ..addAll(
        (await recordRepository.loadRecords(
          snapshot.id,
        )).where((record) => record.medicationId == medication.id),
      );
    _currentScheduledAt = _scheduleService.getCurrentExpectedDateTime(
      medication: medication,
      treatmentStartAt: snapshot.scheduledAt,
      applicationRecords: _records,
      now: DateTime.now(),
    );
    notifyListeners();
    if (_remindersEnabled) {
      unawaited(_syncMedicationReminder());
    }
  }

  Future<void> configureTreatment({
    required String userName,
    required Medication medication,
    required String? initialApplicationPointId,
    required DateTime scheduledAt,
    required bool remindersEnabled,
  }) async {
    final previousMedicationId = _medication?.id;
    final previousMedicationName = _medication?.name;
    final treatmentRepository = _treatmentRepository;
    final medicationChanged =
        previousMedicationId != null && previousMedicationId != medication.id;

    _medication = medication;
    _userName = userName;
    _remindersEnabled = remindersEnabled;
    _currentApplicationPointId =
        initialApplicationPointId ??
        _rotationService.getInitialPoint(medication)?.id;
    _currentScheduledAt = scheduledAt;
    _configuredScheduledAt = scheduledAt;
    _records.clear();
    notifyListeners();

    final now = DateTime.now();
    final snapshot = TreatmentSnapshot(
      id: TreatmentRepository.activeTreatmentId,
      userName: userName,
      medicationId: medication.id,
      medicationName: medication.name,
      selectedApplicationPointId: _currentApplicationPointId,
      selectedApplicationPointLabel: currentApplicationPoint?.label,
      applicationTime: _formatApplicationTime(scheduledAt),
      treatmentStartDate: DateTime(
        scheduledAt.year,
        scheduledAt.month,
        scheduledAt.day,
      ),
      remindersEnabled: remindersEnabled,
      createdAt: now,
      updatedAt: now,
    );
    final treatmentChangeRecord = medicationChanged
        ? TreatmentChangeRecord(
            id: 'treatment_change_${now.microsecondsSinceEpoch}',
            previousMedicationId: previousMedicationId,
            previousMedicationName:
                previousMedicationName ?? 'Tratamento anterior',
            newMedicationId: medication.id,
            newMedicationName: medication.name,
            changedAt: now,
          )
        : null;

    await Future.wait([
      if (treatmentRepository != null)
        treatmentRepository.saveActiveTreatment(snapshot),
      if (_treatmentChangeRepository != null && treatmentChangeRecord != null)
        _treatmentChangeRepository.saveRecord(treatmentChangeRecord),
    ]);
    await _syncMedicationReminder();
  }

  ApplicationEligibilityResult evaluateEligibility({DateTime? now}) {
    final medication = _medication;
    final scheduledAt = _currentScheduledAt;
    if (medication == null || scheduledAt == null) {
      return const ApplicationEligibilityResult(
        status: ApplicationEligibilityStatus.notApplicable,
        canRegister: false,
        message: 'Configure um tratamento antes de registrar.',
      );
    }

    return _eligibilityService.evaluate(
      medication: medication,
      scheduledAt: scheduledAt,
      existingRecords: _records,
      now: now ?? DateTime.now(),
    );
  }

  Future<ApplicationRecord> registerApplication({
    String? notes,
    DateTime? registeredAt,
  }) async {
    final medication = _medication;
    final scheduledAt = _currentScheduledAt;
    if (medication == null) {
      throw StateError('No active treatment configured.');
    }
    if (scheduledAt == null) {
      throw StateError('No scheduled application configured.');
    }

    final appliedAt = registeredAt ?? DateTime.now();
    final eligibility = evaluateEligibility(now: appliedAt);
    if (!eligibility.canRegister) {
      throw StateError(eligibility.message);
    }

    final usedPoint = currentApplicationPoint;
    final record = ApplicationRecord(
      id: 'application_${appliedAt.microsecondsSinceEpoch}',
      medicationId: medication.id,
      medicationName: medication.name,
      applicationPointId: usedPoint?.id,
      applicationPointLabel: usedPoint?.label,
      applicationRegionId: usedPoint?.regionId,
      applicationRegionLabel: usedPoint?.parentSiteLabel,
      applicationSubRegionId: usedPoint?.subRegionId,
      applicationSubRegionLabel: usedPoint?.side,
      scheduledAt: scheduledAt,
      registeredAt: appliedAt,
      registrationStatus: _eligibilityService.registrationStatusFor(
        eligibility.status,
      ),
      adjustedSchedule:
          eligibility.status == ApplicationEligibilityStatus.scheduleAdjustment,
      appliedAt: appliedAt,
      notes: notes,
    );

    _records.add(record);

    final nextPoint = _rotationService.getNextPoint(
      medication,
      _currentApplicationPointId,
    );
    _currentApplicationPointId = nextPoint?.id;
    _currentScheduledAt = _eligibilityService.calculateNextScheduledAt(
      medication: medication,
      treatmentStartAt: _configuredScheduledAt ?? scheduledAt,
      scheduledAt: scheduledAt,
      registeredAt: appliedAt,
    );

    notifyListeners();

    unawaited(
      Future.wait([
        if (_applicationRecordRepository != null)
          _applicationRecordRepository.saveRecord(
            treatmentId: TreatmentRepository.activeTreatmentId,
            record: record,
          ),
        if (_treatmentRepository != null)
          _treatmentRepository.updateCurrentApplicationPoint(
            pointId: _currentApplicationPointId,
            pointLabel: currentApplicationPoint?.label,
            updatedAt: appliedAt,
          ),
      ]),
    );
    unawaited(_syncMedicationReminder());

    return record;
  }

  Future<void> _syncMedicationReminder() async {
    final medication = _medication;
    final scheduledAt = _currentScheduledAt;
    if (!_remindersEnabled || medication == null || scheduledAt == null) {
      await _notificationService.cancelMedicationReminder();
      return;
    }

    await _notificationService.scheduleMedicationReminder(
      medication: medication,
      applicationPoint: currentApplicationPoint,
      scheduledAt: scheduledAt,
    );
  }

  String _formatApplicationTime(DateTime value) {
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
