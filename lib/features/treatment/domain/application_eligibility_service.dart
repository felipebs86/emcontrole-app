import 'application_record.dart';
import 'medication.dart';
import 'medication_schedule_service.dart';

enum ApplicationEligibilityStatus {
  eligible,
  early,
  late,
  duplicate,
  tooSoon,
  scheduleAdjustment,
  notApplicable,
}

class ApplicationEligibilityResult {
  const ApplicationEligibilityResult({
    required this.status,
    required this.canRegister,
    required this.message,
  });

  final ApplicationEligibilityStatus status;
  final bool canRegister;
  final String message;
}

class ApplicationEligibilityService {
  const ApplicationEligibilityService([
    this._scheduleService = const MedicationScheduleService(),
  ]);

  final MedicationScheduleService _scheduleService;

  ApplicationEligibilityResult evaluate({
    required Medication medication,
    required DateTime scheduledAt,
    required List<ApplicationRecord> existingRecords,
    required DateTime now,
  }) {
    if (_scheduleService.hasRegistrationForSlot(
      medication: medication,
      scheduledAt: scheduledAt,
      records: existingRecords,
    )) {
      return const ApplicationEligibilityResult(
        status: ApplicationEligibilityStatus.duplicate,
        canRegister: false,
        message: 'Esta aplicação já foi registrada para o período atual.',
      );
    }

    if (_hasMinimumIntervalViolation(
      medication: medication,
      existingRecords: existingRecords,
      now: now,
    )) {
      return const ApplicationEligibilityResult(
        status: ApplicationEligibilityStatus.tooSoon,
        canRegister: false,
        message:
            'Registro indisponível: intervalo mínimo entre doses ainda não foi atingido.',
      );
    }

    if (_hasSameDayDuplicate(
      medication: medication,
      scheduledAt: scheduledAt,
      existingRecords: existingRecords,
      now: now,
    )) {
      return const ApplicationEligibilityResult(
        status: ApplicationEligibilityStatus.duplicate,
        canRegister: false,
        message: 'Esta aplicação já foi registrada hoje.',
      );
    }

    if (!_scheduleService.supportsAutomaticSchedule(medication)) {
      return const ApplicationEligibilityResult(
        status: ApplicationEligibilityStatus.notApplicable,
        canRegister: true,
        message:
            'Próxima data deve ser acompanhada conforme orientação médica.',
      );
    }

    if (medication.scheduleType == MedicationScheduleType.weekly) {
      final dayDifference = _dateOnly(
        now,
      ).difference(_dateOnly(scheduledAt)).inDays;
      if (dayDifference.abs() == 1) {
        return const ApplicationEligibilityResult(
          status: ApplicationEligibilityStatus.scheduleAdjustment,
          canRegister: true,
          message:
              'Este registro altera o dia previsto da aplicação. Confirme apenas se isso estiver de acordo com sua orientação médica.',
        );
      }
    }

    final earlyBoundary = scheduledAt.subtract(
      _scheduleService.earlyToleranceFor(medication),
    );
    final lateBoundary = scheduledAt.add(
      _scheduleService.lateToleranceFor(medication),
    );

    if (now.isBefore(earlyBoundary)) {
      return const ApplicationEligibilityResult(
        status: ApplicationEligibilityStatus.early,
        canRegister: true,
        message: 'Este registro está antes do horário previsto.',
      );
    }

    if (now.isAfter(lateBoundary)) {
      return const ApplicationEligibilityResult(
        status: ApplicationEligibilityStatus.late,
        canRegister: true,
        message: 'Este registro está fora da janela prevista.',
      );
    }

    return const ApplicationEligibilityResult(
      status: ApplicationEligibilityStatus.eligible,
      canRegister: true,
      message: 'Siga sempre a prescrição e orientação da sua equipe de saúde.',
    );
  }

  DateTime? calculateNextScheduledAt({
    required Medication medication,
    required DateTime treatmentStartAt,
    required DateTime scheduledAt,
    required DateTime registeredAt,
  }) {
    return _scheduleService.getNextExpectedAfterRegistration(
      medication: medication,
      treatmentStartAt: treatmentStartAt,
      scheduledAt: scheduledAt,
      registeredAt: registeredAt,
    );
  }

  ApplicationRegistrationStatus registrationStatusFor(
    ApplicationEligibilityStatus status,
  ) {
    return switch (status) {
      ApplicationEligibilityStatus.early => ApplicationRegistrationStatus.early,
      ApplicationEligibilityStatus.late => ApplicationRegistrationStatus.late,
      ApplicationEligibilityStatus.scheduleAdjustment =>
        ApplicationRegistrationStatus.scheduleAdjustment,
      ApplicationEligibilityStatus.eligible ||
      ApplicationEligibilityStatus.tooSoon ||
      ApplicationEligibilityStatus.notApplicable ||
      ApplicationEligibilityStatus.duplicate =>
        ApplicationRegistrationStatus.onTime,
    };
  }

  bool _hasMinimumIntervalViolation({
    required Medication medication,
    required List<ApplicationRecord> existingRecords,
    required DateTime now,
  }) {
    final minimumIntervalHours = medication.minimumIntervalHours;
    if (minimumIntervalHours == null) {
      return false;
    }

    final latestRecord = existingRecords
        .where((record) => record.medicationId == medication.id)
        .fold<ApplicationRecord?>(null, (latest, record) {
          if (latest == null) {
            return record;
          }

          return record.registeredAt.isAfter(latest.registeredAt)
              ? record
              : latest;
        });
    if (latestRecord == null) {
      return false;
    }

    final elapsed = now.difference(latestRecord.registeredAt);
    return elapsed < Duration(hours: minimumIntervalHours);
  }

  bool _hasSameDayDuplicate({
    required Medication medication,
    required DateTime scheduledAt,
    required List<ApplicationRecord> existingRecords,
    required DateTime now,
  }) {
    final recordsToday = existingRecords.where(
      (record) =>
          record.medicationId == medication.id &&
          _sameLocalDate(record.registeredAt, now),
    );

    if (medication.scheduleType != MedicationScheduleType.twiceDaily) {
      return recordsToday.isNotEmpty;
    }

    final doseLimit = medication.dailyDoseCount ?? 2;
    if (recordsToday.length >= doseLimit) {
      return true;
    }

    return recordsToday.any(
      (record) => _sameSlot(record.scheduledAt, scheduledAt),
    );
  }

  bool _sameLocalDate(DateTime first, DateTime second) {
    return first.year == second.year &&
        first.month == second.month &&
        first.day == second.day;
  }

  bool _sameSlot(DateTime first, DateTime second) {
    return first.year == second.year &&
        first.month == second.month &&
        first.day == second.day &&
        first.hour == second.hour &&
        first.minute == second.minute;
  }

  DateTime _dateOnly(DateTime value) {
    return DateTime(value.year, value.month, value.day);
  }
}
