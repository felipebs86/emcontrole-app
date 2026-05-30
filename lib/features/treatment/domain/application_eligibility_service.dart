import 'application_record.dart';
import 'medication.dart';

enum ApplicationEligibilityStatus {
  eligible,
  early,
  late,
  duplicate,
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
  const ApplicationEligibilityService();

  ApplicationEligibilityResult evaluate({
    required Medication medication,
    required DateTime scheduledAt,
    required List<ApplicationRecord> existingRecords,
    required DateTime now,
  }) {
    if (_hasSameDayRegistration(medication, existingRecords, now)) {
      return const ApplicationEligibilityResult(
        status: ApplicationEligibilityStatus.duplicate,
        canRegister: false,
        message: 'Esta aplicação já foi registrada para o período atual.',
      );
    }

    if (_hasDuplicateForScheduledPeriod(
      medication,
      scheduledAt,
      existingRecords,
    )) {
      return const ApplicationEligibilityResult(
        status: ApplicationEligibilityStatus.duplicate,
        canRegister: false,
        message: 'Esta aplicação já foi registrada para o período atual.',
      );
    }

    final frequency = _frequencyFor(medication);
    if (frequency == _Frequency.none) {
      return const ApplicationEligibilityResult(
        status: ApplicationEligibilityStatus.notApplicable,
        canRegister: true,
        message: 'Siga sempre a orientação da sua equipe de saúde.',
      );
    }

    if (frequency == _Frequency.weekly) {
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

    final earlyBoundary = scheduledAt.subtract(_earlyToleranceFor(frequency));
    final lateBoundary = scheduledAt.add(_lateToleranceFor(frequency));

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
      message: 'Siga sempre a orientação da sua equipe de saúde.',
    );
  }

  DateTime calculateNextScheduledAt({
    required Medication medication,
    required DateTime registeredAt,
  }) {
    return switch (_frequencyFor(medication)) {
      _Frequency.daily => registeredAt.add(const Duration(days: 1)),
      _Frequency.weekly => registeredAt.add(const Duration(days: 7)),
      _Frequency.everyOtherDay => registeredAt.add(const Duration(days: 2)),
      _Frequency.threeTimesPerWeek => registeredAt.add(const Duration(days: 2)),
      _Frequency.every14Days => registeredAt.add(const Duration(days: 14)),
      _Frequency.monthly => DateTime(
        registeredAt.year,
        registeredAt.month + 1,
        registeredAt.day,
        registeredAt.hour,
        registeredAt.minute,
      ),
      _Frequency.none => registeredAt,
    };
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
      ApplicationEligibilityStatus.notApplicable ||
      ApplicationEligibilityStatus.duplicate =>
        ApplicationRegistrationStatus.onTime,
    };
  }

  bool _hasDuplicateForScheduledPeriod(
    Medication medication,
    DateTime scheduledAt,
    List<ApplicationRecord> records,
  ) {
    return records.any(
      (record) =>
          record.medicationId == medication.id &&
          _sameLocalDate(record.scheduledAt, scheduledAt),
    );
  }

  bool _hasSameDayRegistration(
    Medication medication,
    List<ApplicationRecord> records,
    DateTime now,
  ) {
    return records.any(
      (record) =>
          record.medicationId == medication.id &&
          _sameLocalDate(record.registeredAt, now),
    );
  }

  Duration _earlyToleranceFor(_Frequency frequency) {
    return switch (frequency) {
      _Frequency.daily => const Duration(hours: 2),
      _Frequency.weekly => const Duration(hours: 12),
      _Frequency.everyOtherDay => const Duration(hours: 12),
      _Frequency.threeTimesPerWeek => const Duration(hours: 12),
      _Frequency.every14Days => const Duration(days: 1),
      _Frequency.monthly => const Duration(days: 2),
      _Frequency.none => Duration.zero,
    };
  }

  Duration _lateToleranceFor(_Frequency frequency) {
    return switch (frequency) {
      _Frequency.daily => const Duration(hours: 6),
      _Frequency.weekly => const Duration(hours: 12),
      _Frequency.everyOtherDay => const Duration(hours: 12),
      _Frequency.threeTimesPerWeek => const Duration(hours: 12),
      _Frequency.every14Days => const Duration(days: 1),
      _Frequency.monthly => const Duration(days: 2),
      _Frequency.none => Duration.zero,
    };
  }

  _Frequency _frequencyFor(Medication medication) {
    return switch (medication.id) {
      'copaxone' => _Frequency.daily,
      'tecfidera' => _Frequency.daily,
      'aubagio' => _Frequency.daily,
      'gilenya' => _Frequency.daily,
      'avonex' => _Frequency.weekly,
      'betaferon' => _Frequency.everyOtherDay,
      'rebif' => _Frequency.threeTimesPerWeek,
      'plegridy' => _Frequency.every14Days,
      'kesimpta' => _Frequency.monthly,
      'mavenclad' => _Frequency.monthly,
      'tysabri' => _Frequency.monthly,
      _ => _Frequency.none,
    };
  }

  bool _sameLocalDate(DateTime first, DateTime second) {
    return first.year == second.year &&
        first.month == second.month &&
        first.day == second.day;
  }

  DateTime _dateOnly(DateTime value) {
    return DateTime(value.year, value.month, value.day);
  }
}

enum _Frequency {
  none,
  daily,
  weekly,
  everyOtherDay,
  threeTimesPerWeek,
  every14Days,
  monthly,
}
