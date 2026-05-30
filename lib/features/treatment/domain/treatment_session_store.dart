import 'package:flutter/foundation.dart';

import 'application_eligibility_service.dart';
import 'application_record.dart';
import 'application_rotation_service.dart';
import 'medication.dart';

final treatmentSessionStore = TreatmentSessionStore();

class TreatmentSessionStore extends ChangeNotifier {
  TreatmentSessionStore([
    this._rotationService = const ApplicationRotationService(),
    this._eligibilityService = const ApplicationEligibilityService(),
  ]);

  final ApplicationRotationService _rotationService;
  final ApplicationEligibilityService _eligibilityService;
  final List<ApplicationRecord> _records = [];

  Medication? _medication;
  String? _currentApplicationPointId;
  DateTime? _currentScheduledAt;

  Medication? get medication => _medication;

  String? get currentApplicationPointId => _currentApplicationPointId;

  DateTime? get currentScheduledAt => _currentScheduledAt;

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

  void configureTreatment({
    required Medication medication,
    required String? initialApplicationPointId,
    required DateTime scheduledAt,
  }) {
    _medication = medication;
    _currentApplicationPointId =
        initialApplicationPointId ??
        _rotationService.getInitialPoint(medication)?.id;
    _currentScheduledAt = scheduledAt;
    _records.clear();
    notifyListeners();
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

  ApplicationRecord registerApplication({
    String? notes,
    DateTime? registeredAt,
  }) {
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
      registeredAt: appliedAt,
    );

    notifyListeners();
    return record;
  }
}
