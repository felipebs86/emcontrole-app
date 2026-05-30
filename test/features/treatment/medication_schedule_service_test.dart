import 'package:flutter_test/flutter_test.dart';

import 'package:emcontrole/features/treatment/data/medication_catalog_data_source.dart';
import 'package:emcontrole/features/treatment/domain/application_eligibility_service.dart';
import 'package:emcontrole/features/treatment/domain/application_record.dart';
import 'package:emcontrole/features/treatment/domain/medication.dart';
import 'package:emcontrole/features/treatment/domain/medication_schedule_service.dart';

void main() {
  final medications = const MedicationCatalogDataSource().loadMedications();
  const scheduleService = MedicationScheduleService();
  const eligibilityService = ApplicationEligibilityService();

  Medication medicationById(String id) {
    return medications.singleWhere((medication) => medication.id == id);
  }

  ApplicationRecord record({
    required Medication medication,
    required DateTime scheduledAt,
    required DateTime registeredAt,
  }) {
    return ApplicationRecord(
      id: 'record_${registeredAt.microsecondsSinceEpoch}',
      medicationId: medication.id,
      medicationName: medication.name,
      applicationPointId: null,
      applicationPointLabel: null,
      scheduledAt: scheduledAt,
      registeredAt: registeredAt,
      registrationStatus: ApplicationRegistrationStatus.onTime,
      adjustedSchedule: false,
      appliedAt: registeredAt,
    );
  }

  group('MedicationScheduleService', () {
    test('Tecfidera with no record expects first configured daily dose', () {
      final tecfidera = medicationById('tecfidera');
      final treatmentStartAt = DateTime(2026, 1, 2, 8);

      final expected = scheduleService.getCurrentExpectedDateTime(
        medication: tecfidera,
        treatmentStartAt: treatmentStartAt,
        applicationRecords: const [],
        now: DateTime(2026, 1, 2, 7),
      );

      expect(expected, DateTime(2026, 1, 2, 8));
    });

    test('Tecfidera after morning record expects evening dose', () {
      final tecfidera = medicationById('tecfidera');
      final treatmentStartAt = DateTime(2026, 1, 2, 8);
      final morning = record(
        medication: tecfidera,
        scheduledAt: treatmentStartAt,
        registeredAt: DateTime(2026, 1, 2, 8, 10),
      );

      final expected = scheduleService.getCurrentExpectedDateTime(
        medication: tecfidera,
        treatmentStartAt: treatmentStartAt,
        applicationRecords: [morning],
        now: DateTime(2026, 1, 2, 12),
      );

      expect(expected, DateTime(2026, 1, 2, 20));
    });

    test('Tecfidera after evening record expects next morning', () {
      final tecfidera = medicationById('tecfidera');
      final treatmentStartAt = DateTime(2026, 1, 2, 8);
      final eveningSlot = DateTime(2026, 1, 2, 20);
      final evening = record(
        medication: tecfidera,
        scheduledAt: eveningSlot,
        registeredAt: DateTime(2026, 1, 2, 20, 10),
      );

      final expected = scheduleService.getCurrentExpectedDateTime(
        medication: tecfidera,
        treatmentStartAt: treatmentStartAt,
        applicationRecords: [evening],
        now: DateTime(2026, 1, 2, 21),
      );

      expect(expected, DateTime(2026, 1, 3, 8));
    });

    test('Tecfidera duplicate detection blocks the same morning slot', () {
      final tecfidera = medicationById('tecfidera');
      final morningSlot = DateTime(2026, 1, 2, 8);
      final morning = record(
        medication: tecfidera,
        scheduledAt: morningSlot,
        registeredAt: DateTime(2026, 1, 2, 8, 10),
      );

      final result = eligibilityService.evaluate(
        medication: tecfidera,
        scheduledAt: morningSlot,
        existingRecords: [morning],
        now: DateTime(2026, 1, 2, 8, 15),
      );

      expect(result.status, ApplicationEligibilityStatus.duplicate);
      expect(result.canRegister, isFalse);
    });

    test('Tecfidera allows evening slot after morning dose', () {
      final tecfidera = medicationById('tecfidera');
      final morningSlot = DateTime(2026, 1, 2, 8);
      final eveningSlot = DateTime(2026, 1, 2, 20);
      final morning = record(
        medication: tecfidera,
        scheduledAt: morningSlot,
        registeredAt: DateTime(2026, 1, 2, 8, 10),
      );

      final result = eligibilityService.evaluate(
        medication: tecfidera,
        scheduledAt: eveningSlot,
        existingRecords: [morning],
        now: DateTime(2026, 1, 2, 20),
      );

      expect(result.status, ApplicationEligibilityStatus.eligible);
      expect(result.canRegister, isTrue);
    });

    test('Tecfidera duplicate detection blocks the same evening slot', () {
      final tecfidera = medicationById('tecfidera');
      final eveningSlot = DateTime(2026, 1, 2, 20);
      final evening = record(
        medication: tecfidera,
        scheduledAt: eveningSlot,
        registeredAt: DateTime(2026, 1, 2, 20, 10),
      );

      final result = eligibilityService.evaluate(
        medication: tecfidera,
        scheduledAt: eveningSlot,
        existingRecords: [evening],
        now: DateTime(2026, 1, 2, 20, 15),
      );

      expect(result.status, ApplicationEligibilityStatus.duplicate);
      expect(result.canRegister, isFalse);
    });

    test('once daily after registration expects next day', () {
      final aubagio = medicationById('aubagio');
      final treatmentStartAt = DateTime(2026, 1, 2, 8);

      final expected = scheduleService.getNextExpectedAfterRegistration(
        medication: aubagio,
        treatmentStartAt: treatmentStartAt,
        scheduledAt: treatmentStartAt,
        registeredAt: DateTime(2026, 1, 2, 8, 10),
      );

      expect(expected, DateTime(2026, 1, 3, 8));
    });

    test('Copaxone 20 mg after registration expects next day', () {
      final copaxone20 = medicationById('copaxone_20mg');
      final treatmentStartAt = DateTime(2026, 1, 2, 8);

      final expected = scheduleService.getNextExpectedAfterRegistration(
        medication: copaxone20,
        treatmentStartAt: treatmentStartAt,
        scheduledAt: treatmentStartAt,
        registeredAt: DateTime(2026, 1, 2, 8, 10),
      );

      expect(expected, DateTime(2026, 1, 3, 8));
    });

    test('Copaxone 40 mg start Monday expects next Wednesday', () {
      final copaxone40 = medicationById('copaxone_40mg');
      final monday = DateTime(2026, 1, 5, 8);

      final expected = scheduleService.getNextExpectedAfterRegistration(
        medication: copaxone40,
        treatmentStartAt: monday,
        scheduledAt: monday,
        registeredAt: monday,
      );

      expect(expected, DateTime(2026, 1, 7, 8));
    });

    test('Copaxone 40 mg start Wednesday expects next Friday', () {
      final copaxone40 = medicationById('copaxone_40mg');
      final wednesday = DateTime(2026, 1, 7, 8);

      final expected = scheduleService.getNextExpectedAfterRegistration(
        medication: copaxone40,
        treatmentStartAt: wednesday,
        scheduledAt: wednesday,
        registeredAt: wednesday,
      );

      expect(expected, DateTime(2026, 1, 9, 8));
    });

    test('Copaxone 40 mg third weekly dose expects next week first dose', () {
      final copaxone40 = medicationById('copaxone_40mg');
      final monday = DateTime(2026, 1, 5, 8);
      final friday = DateTime(2026, 1, 9, 8);

      final expected = scheduleService.getNextExpectedAfterRegistration(
        medication: copaxone40,
        treatmentStartAt: monday,
        scheduledAt: friday,
        registeredAt: friday,
      );

      expect(expected, DateTime(2026, 1, 12, 8));
    });

    test('Copaxone 40 mg minimum interval is not below 48 hours', () {
      final copaxone40 = medicationById('copaxone_40mg');
      final monday = DateTime(2026, 1, 5, 8);
      final registeredAt = DateTime(2026, 1, 5, 8, 10);
      final expected = scheduleService.getNextExpectedAfterRegistration(
        medication: copaxone40,
        treatmentStartAt: monday,
        scheduledAt: monday,
        registeredAt: registeredAt,
      );

      expect(
        expected!.difference(registeredAt).inMinutes,
        greaterThanOrEqualTo(48 * 60),
      );
    });

    test('weekly after registration expects seven days later', () {
      final avonex = medicationById('avonex');
      final treatmentStartAt = DateTime(2026, 1, 2, 8);

      final expected = scheduleService.getNextExpectedAfterRegistration(
        medication: avonex,
        treatmentStartAt: treatmentStartAt,
        scheduledAt: treatmentStartAt,
        registeredAt: DateTime(2026, 1, 2, 8, 10),
      );

      expect(expected, DateTime(2026, 1, 9, 8));
    });

    test('every other day after registration expects two days later', () {
      final betaferon = medicationById('betaferon');
      final treatmentStartAt = DateTime(2026, 1, 2, 8);

      final expected = scheduleService.getNextExpectedAfterRegistration(
        medication: betaferon,
        treatmentStartAt: treatmentStartAt,
        scheduledAt: treatmentStartAt,
        registeredAt: DateTime(2026, 1, 2, 8, 10),
      );

      expect(expected, DateTime(2026, 1, 4, 8));
    });

    test('every 14 days after registration expects fourteen days later', () {
      final plegridy = medicationById('plegridy');
      final treatmentStartAt = DateTime(2026, 1, 2, 8);

      final expected = scheduleService.getNextExpectedAfterRegistration(
        medication: plegridy,
        treatmentStartAt: treatmentStartAt,
        scheduledAt: treatmentStartAt,
        registeredAt: DateTime(2026, 1, 2, 8, 10),
      );

      expect(expected, DateTime(2026, 1, 16, 8));
    });
  });
}
