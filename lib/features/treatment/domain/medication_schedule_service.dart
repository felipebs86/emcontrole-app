import 'application_record.dart';
import 'medication.dart';

class MedicationScheduleService {
  const MedicationScheduleService();

  DateTime? getCurrentExpectedDateTime({
    required Medication medication,
    required DateTime treatmentStartAt,
    required List<ApplicationRecord> applicationRecords,
    required DateTime now,
  }) {
    return getNextExpectedDateTime(
      medication: medication,
      treatmentStartAt: treatmentStartAt,
      applicationRecords: applicationRecords,
      now: now,
    );
  }

  DateTime? getNextExpectedDateTime({
    required Medication medication,
    required DateTime treatmentStartAt,
    required List<ApplicationRecord> applicationRecords,
    required DateTime now,
  }) {
    if (applicationRecords.isEmpty) {
      return treatmentStartAt;
    }

    final lastRecord = applicationRecords.last;
    return getNextExpectedAfterRegistration(
      medication: medication,
      treatmentStartAt: treatmentStartAt,
      scheduledAt: lastRecord.scheduledAt,
      registeredAt: lastRecord.registeredAt,
    );
  }

  DateTime? getNextExpectedAfterRegistration({
    required Medication medication,
    required DateTime treatmentStartAt,
    required DateTime scheduledAt,
    required DateTime registeredAt,
  }) {
    return switch (medication.scheduleType) {
      MedicationScheduleType.onceDaily => _addDaysAtConfiguredTime(
        registeredAt,
        treatmentStartAt,
        medication.intervalDays ?? 1,
      ),
      MedicationScheduleType.twiceDaily => _nextTwiceDailySlot(
        scheduledAt: scheduledAt,
        treatmentStartAt: treatmentStartAt,
        intervalHours: medication.intervalHours ?? 12,
      ),
      MedicationScheduleType.weekly => _addDaysAtConfiguredTime(
        registeredAt,
        treatmentStartAt,
        medication.intervalDays ?? 7,
      ),
      MedicationScheduleType.everyOtherDay => _addDaysAtConfiguredTime(
        registeredAt,
        treatmentStartAt,
        medication.intervalDays ?? 2,
      ),
      MedicationScheduleType.threeTimesPerWeek => _nextThreeTimesPerWeekSlot(
        scheduledAt: scheduledAt,
        registeredAt: registeredAt,
        treatmentStartAt: treatmentStartAt,
        minimumIntervalHours: medication.minimumIntervalHours ?? 48,
      ),
      MedicationScheduleType.every14Days => _addDaysAtConfiguredTime(
        registeredAt,
        treatmentStartAt,
        medication.intervalDays ?? 14,
      ),
      MedicationScheduleType.monthly => DateTime(
        registeredAt.year,
        registeredAt.month + 1,
        registeredAt.day,
        treatmentStartAt.hour,
        treatmentStartAt.minute,
      ),
      MedicationScheduleType.manual ||
      MedicationScheduleType.cycleBased => null,
    };
  }

  bool hasRegistrationForSlot({
    required Medication medication,
    required DateTime scheduledAt,
    required List<ApplicationRecord> records,
  }) {
    return records.any(
      (record) =>
          record.medicationId == medication.id &&
          _sameSlot(record.scheduledAt, scheduledAt),
    );
  }

  Duration earlyToleranceFor(Medication medication) {
    return switch (medication.scheduleType) {
      MedicationScheduleType.onceDaily ||
      MedicationScheduleType.twiceDaily => const Duration(hours: 2),
      MedicationScheduleType.weekly ||
      MedicationScheduleType.everyOtherDay ||
      MedicationScheduleType.threeTimesPerWeek => const Duration(hours: 12),
      MedicationScheduleType.every14Days => const Duration(days: 1),
      MedicationScheduleType.monthly => const Duration(days: 2),
      MedicationScheduleType.manual ||
      MedicationScheduleType.cycleBased => Duration.zero,
    };
  }

  Duration lateToleranceFor(Medication medication) {
    return switch (medication.scheduleType) {
      MedicationScheduleType.onceDaily ||
      MedicationScheduleType.twiceDaily => const Duration(hours: 6),
      MedicationScheduleType.weekly ||
      MedicationScheduleType.everyOtherDay ||
      MedicationScheduleType.threeTimesPerWeek => const Duration(hours: 12),
      MedicationScheduleType.every14Days => const Duration(days: 1),
      MedicationScheduleType.monthly => const Duration(days: 2),
      MedicationScheduleType.manual ||
      MedicationScheduleType.cycleBased => Duration.zero,
    };
  }

  bool supportsAutomaticSchedule(Medication medication) {
    return medication.scheduleType != MedicationScheduleType.manual &&
        medication.scheduleType != MedicationScheduleType.cycleBased;
  }

  DateTime _nextTwiceDailySlot({
    required DateTime scheduledAt,
    required DateTime treatmentStartAt,
    required int intervalHours,
  }) {
    final firstDose = DateTime(
      scheduledAt.year,
      scheduledAt.month,
      scheduledAt.day,
      treatmentStartAt.hour,
      treatmentStartAt.minute,
    );
    final secondDose = firstDose.add(Duration(hours: intervalHours));

    if (_sameSlot(scheduledAt, firstDose)) {
      return secondDose;
    }

    return DateTime(
      scheduledAt.year,
      scheduledAt.month,
      scheduledAt.day + 1,
      treatmentStartAt.hour,
      treatmentStartAt.minute,
    );
  }

  DateTime _nextThreeTimesPerWeekSlot({
    required DateTime scheduledAt,
    required DateTime registeredAt,
    required DateTime treatmentStartAt,
    required int minimumIntervalHours,
  }) {
    final anchor = _dateAtConfiguredTime(treatmentStartAt, treatmentStartAt);
    final scheduled = _dateAtConfiguredTime(scheduledAt, treatmentStartAt);
    final daysSinceStart = _dateOnly(
      scheduled,
    ).difference(_dateOnly(anchor)).inDays;
    final weekOffset = daysSinceStart >= 0 ? daysSinceStart % 7 : 0;
    final daysToAdd = switch (weekOffset) {
      0 => 2,
      2 => 2,
      4 => 3,
      _ => 2,
    };
    final next = DateTime(
      scheduled.year,
      scheduled.month,
      scheduled.day + daysToAdd,
      treatmentStartAt.hour,
      treatmentStartAt.minute,
    );
    final minimumNext = registeredAt.add(Duration(hours: minimumIntervalHours));

    if (next.isBefore(minimumNext)) {
      return minimumNext;
    }

    return next;
  }

  DateTime _addDaysAtConfiguredTime(
    DateTime registeredAt,
    DateTime treatmentStartAt,
    int days,
  ) {
    return DateTime(
      registeredAt.year,
      registeredAt.month,
      registeredAt.day + days,
      treatmentStartAt.hour,
      treatmentStartAt.minute,
    );
  }

  DateTime _dateAtConfiguredTime(DateTime date, DateTime treatmentStartAt) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      treatmentStartAt.hour,
      treatmentStartAt.minute,
    );
  }

  DateTime _dateOnly(DateTime value) {
    return DateTime(value.year, value.month, value.day);
  }

  bool _sameSlot(DateTime first, DateTime second) {
    return first.year == second.year &&
        first.month == second.month &&
        first.day == second.day &&
        first.hour == second.hour &&
        first.minute == second.minute;
  }
}
