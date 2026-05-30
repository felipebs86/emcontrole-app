import 'package:flutter_test/flutter_test.dart';

import 'package:emcontrole/features/treatment/data/medication_catalog_data_source.dart';
import 'package:emcontrole/features/treatment/domain/application_rotation_service.dart';
import 'package:emcontrole/features/treatment/domain/medication.dart';

void main() {
  final medications = const MedicationCatalogDataSource().loadMedications();
  const service = ApplicationRotationService();

  Medication medicationById(String id) {
    return medications.singleWhere((medication) => medication.id == id);
  }

  group('ApplicationRotationService', () {
    test('Avonex advances from Local 1 right thigh to Local 2 left thigh', () {
      final avonex = medicationById('avonex');

      final nextPoint = service.getNextPoint(avonex, 'avonex_thigh_right_01');

      expect(nextPoint?.id, 'avonex_thigh_left_02');
      expect(nextPoint?.label, 'Local 2');
      expect(nextPoint?.parentSiteLabel, 'Coxa esquerda');
    });

    test('Avonex returns from Local 2 left thigh to Local 1 right thigh', () {
      final avonex = medicationById('avonex');

      final nextPoint = service.getNextPoint(avonex, 'avonex_thigh_left_02');

      expect(nextPoint?.id, 'avonex_thigh_right_01');
      expect(nextPoint?.label, 'Local 1');
      expect(nextPoint?.parentSiteLabel, 'Coxa direita');
    });

    test('Copaxone advances from the first point to the second point', () {
      final copaxone = medicationById('copaxone');

      final nextPoint = service.getNextPoint(copaxone, 'copaxone_abdomen_01');

      expect(nextPoint?.id, 'copaxone_abdomen_02');
      expect(nextPoint?.label, 'Local 2');
      expect(nextPoint?.parentSiteLabel, 'Abdômen direito');
    });

    test('Copaxone returns from the last point to the first point', () {
      final copaxone = medicationById('copaxone');

      final nextPoint = service.getNextPoint(copaxone, 'copaxone_hip_left_18');

      expect(nextPoint?.id, 'copaxone_abdomen_01');
      expect(nextPoint?.label, 'Local 1');
      expect(nextPoint?.parentSiteLabel, 'Abdômen direito');
    });

    test('oral medications do not rotate', () {
      final tecfidera = medicationById('tecfidera');

      expect(service.getInitialPoint(tecfidera), isNull);
      expect(service.getNextPoint(tecfidera, null), isNull);
      expect(service.getApplicationPoints(tecfidera), isEmpty);
    });

    test('infusion medications do not rotate', () {
      final tysabri = medicationById('tysabri');

      expect(service.getInitialPoint(tysabri), isNull);
      expect(service.getNextPoint(tysabri, null), isNull);
      expect(service.getApplicationPoints(tysabri), isEmpty);
    });

    test('invalid current point returns the first available point', () {
      final copaxone = medicationById('copaxone');

      final nextPoint = service.getNextPoint(copaxone, 'unknown_point');

      expect(nextPoint?.id, 'copaxone_abdomen_01');
      expect(nextPoint?.label, 'Local 1');
    });
  });
}
