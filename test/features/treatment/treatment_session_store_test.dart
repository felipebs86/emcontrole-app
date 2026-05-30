import 'package:flutter_test/flutter_test.dart';

import 'package:emcontrole/features/treatment/data/medication_catalog_data_source.dart';
import 'package:emcontrole/features/treatment/domain/medication.dart';
import 'package:emcontrole/features/treatment/domain/treatment_session_store.dart';

void main() {
  final medications = const MedicationCatalogDataSource().loadMedications();

  Medication medicationById(String id) {
    return medications.singleWhere((medication) => medication.id == id);
  }

  group('TreatmentSessionStore', () {
    test('registers injectable application and advances current point', () {
      final store = TreatmentSessionStore();
      final copaxone = medicationById('copaxone');
      final scheduledAt = DateTime(2026, 1, 2, 8);

      store.configureTreatment(
        medication: copaxone,
        initialApplicationPointId: 'copaxone_abdomen_01',
        scheduledAt: scheduledAt,
      );

      final record = store.registerApplication(registeredAt: scheduledAt);

      expect(record.medicationId, 'copaxone');
      expect(record.medicationName, 'Copaxone');
      expect(record.applicationPointId, 'copaxone_abdomen_01');
      expect(record.applicationPointLabel, 'Local 1');
      expect(record.scheduledAt, scheduledAt);
      expect(record.registeredAt, scheduledAt);
      expect(store.records, hasLength(1));
      expect(store.currentApplicationPoint?.id, 'copaxone_abdomen_02');
      expect(store.currentScheduledAt, DateTime(2026, 1, 3, 8));
    });

    test(
      'Avonex alternates between Local 1 and Local 2 after confirmations',
      () {
        final store = TreatmentSessionStore();
        final avonex = medicationById('avonex');
        final friday = DateTime(2026, 1, 2, 8);
        final nextFriday = DateTime(2026, 1, 9, 8);

        store.configureTreatment(
          medication: avonex,
          initialApplicationPointId: 'avonex_thigh_right_01',
          scheduledAt: friday,
        );

        final firstRecord = store.registerApplication(registeredAt: friday);
        final secondRecord = store.registerApplication(
          registeredAt: nextFriday,
        );

        expect(firstRecord.applicationPointId, 'avonex_thigh_right_01');
        expect(secondRecord.applicationPointId, 'avonex_thigh_left_02');
        expect(store.currentApplicationPoint?.id, 'avonex_thigh_right_01');
      },
    );

    test('oral medication creates record without application point', () {
      final store = TreatmentSessionStore();
      final tecfidera = medicationById('tecfidera');
      final scheduledAt = DateTime(2026, 1, 2, 8);

      store.configureTreatment(
        medication: tecfidera,
        initialApplicationPointId: null,
        scheduledAt: scheduledAt,
      );

      final record = store.registerApplication(registeredAt: scheduledAt);

      expect(record.medicationId, 'tecfidera');
      expect(record.applicationPointId, isNull);
      expect(record.applicationPointLabel, isNull);
      expect(store.currentApplicationPoint, isNull);
      expect(store.records, hasLength(1));
    });

    test('infusion medication creates record without application point', () {
      final store = TreatmentSessionStore();
      final tysabri = medicationById('tysabri');
      final scheduledAt = DateTime(2026, 1, 2, 8);

      store.configureTreatment(
        medication: tysabri,
        initialApplicationPointId: null,
        scheduledAt: scheduledAt,
      );

      final record = store.registerApplication(registeredAt: scheduledAt);

      expect(record.medicationId, 'tysabri');
      expect(record.applicationPointId, isNull);
      expect(record.applicationPointLabel, isNull);
      expect(store.currentApplicationPoint, isNull);
      expect(store.records, hasLength(1));
    });

    test('blocks duplicate daily registration for the same day', () {
      final store = TreatmentSessionStore();
      final tecfidera = medicationById('tecfidera');
      final scheduledAt = DateTime(2026, 1, 2, 8);

      store.configureTreatment(
        medication: tecfidera,
        initialApplicationPointId: null,
        scheduledAt: scheduledAt,
      );

      store.registerApplication(registeredAt: scheduledAt);

      final duplicateEligibility = store.evaluateEligibility(
        now: DateTime(2026, 1, 2, 12),
      );

      expect(duplicateEligibility.canRegister, isFalse);
      expect(
        duplicateEligibility.message,
        'Esta aplicação já foi registrada para o período atual.',
      );
      expect(
        () => store.registerApplication(registeredAt: DateTime(2026, 1, 2, 12)),
        throwsStateError,
      );
      expect(store.records, hasLength(1));
    });

    test('allows weekly one-day-late schedule adjustment from actual date', () {
      final store = TreatmentSessionStore();
      final avonex = medicationById('avonex');
      final friday = DateTime(2026, 1, 2, 8);
      final saturday = DateTime(2026, 1, 3, 8);
      final nextSunday = DateTime(2026, 1, 11, 8);

      store.configureTreatment(
        medication: avonex,
        initialApplicationPointId: 'avonex_thigh_right_01',
        scheduledAt: friday,
      );

      final saturdayEligibility = store.evaluateEligibility(now: saturday);
      expect(saturdayEligibility.canRegister, isTrue);
      expect(saturdayEligibility.status.name, 'scheduleAdjustment');

      final firstRecord = store.registerApplication(registeredAt: saturday);
      expect(firstRecord.adjustedSchedule, isTrue);
      expect(store.currentScheduledAt, DateTime(2026, 1, 10, 8));

      final sundayEligibility = store.evaluateEligibility(now: nextSunday);
      expect(sundayEligibility.canRegister, isTrue);
      expect(sundayEligibility.status.name, 'scheduleAdjustment');

      store.registerApplication(registeredAt: nextSunday);
      expect(store.currentScheduledAt, DateTime(2026, 1, 18, 8));
    });

    test(
      'allows weekly one-day-early schedule adjustment from actual date',
      () {
        final store = TreatmentSessionStore();
        final avonex = medicationById('avonex');
        final friday = DateTime(2026, 1, 9, 8);
        final thursday = DateTime(2026, 1, 8, 8);

        store.configureTreatment(
          medication: avonex,
          initialApplicationPointId: 'avonex_thigh_right_01',
          scheduledAt: friday,
        );

        final eligibility = store.evaluateEligibility(now: thursday);
        expect(eligibility.canRegister, isTrue);
        expect(eligibility.status.name, 'scheduleAdjustment');

        final record = store.registerApplication(registeredAt: thursday);
        expect(record.adjustedSchedule, isTrue);
        expect(store.currentScheduledAt, DateTime(2026, 1, 15, 8));
      },
    );
  });
}
