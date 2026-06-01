import 'dart:io';

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

    test(
      'injectable protocols are catalog-driven instead of medication-id driven',
      () {
        final avonex = medicationById('avonex');
        final rebif = medicationById('rebif');
        final betaferon = medicationById('betaferon');
        final plegridy = medicationById('plegridy');
        final kesimpta = medicationById('kesimpta');

        expect(
          service.getApplicationProtocol(avonex)?.strategy,
          ApplicationRotationStrategy.alternateSides,
        );
        expect(
          service.getApplicationProtocol(rebif)?.strategy,
          ApplicationRotationStrategy.alternateSides,
        );
        expect(
          service.getApplicationProtocol(betaferon)?.strategy,
          ApplicationRotationStrategy.alternateSides,
        );
        expect(
          service.getApplicationProtocol(plegridy)?.strategy,
          ApplicationRotationStrategy.alternateSides,
        );
        expect(
          service.getApplicationProtocol(kesimpta)?.strategy,
          ApplicationRotationStrategy.alternateSides,
        );
      },
    );

    test('Rebif alternates side pairs across generated anatomical regions', () {
      final rebif = medicationById('rebif');

      expect(service.getInitialPoint(rebif)?.id, 'rebif_abdomen_right_point');
      expect(
        service.getNextPoint(rebif, 'rebif_abdomen_right_point')?.id,
        'rebif_abdomen_left_point',
      );
      expect(
        service.getNextPoint(rebif, 'rebif_abdomen_left_point')?.id,
        'rebif_right_thigh_point',
      );
      expect(
        service.getNextPoint(rebif, 'rebif_arm_left_point')?.id,
        'rebif_glute_hip_right_point',
      );
    });

    test(
      'Kesimpta rotation includes abdomen, thighs, and assisted upper arm',
      () {
        final kesimpta = medicationById('kesimpta');

        expect(
          service.getApplicationPoints(kesimpta).map((point) => point.id),
          containsAll([
            'kesimpta_abdomen_right_point',
            'kesimpta_abdomen_left_point',
            'kesimpta_right_thigh_point',
            'kesimpta_left_thigh_point',
            'kesimpta_upper_arm_point',
          ]),
        );
      },
    );

    test('Copaxone advances from the first point to the second point', () {
      final copaxone = medicationById('copaxone_20mg');

      final nextPoint = service.getNextPoint(copaxone, 'copaxone_abdomen_01');

      expect(nextPoint?.id, 'copaxone_abdomen_02');
      expect(nextPoint?.label, 'Local 2');
      expect(nextPoint?.parentSiteLabel, 'Abdômen direito');
    });

    test('Copaxone returns from the last point to the first point', () {
      final copaxone = medicationById('copaxone_40mg');

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
      final copaxone = medicationById('copaxone_20mg');

      final nextPoint = service.getNextPoint(copaxone, 'unknown_point');

      expect(nextPoint?.id, 'copaxone_abdomen_01');
      expect(nextPoint?.label, 'Local 1');
    });

    test('all application points satisfy the visual contract', () {
      for (final medication in medications) {
        final points = service.getApplicationPoints(medication);
        final pointIds = <String>{};

        for (final point in points) {
          expect(
            point.id,
            matches(RegExp(r'^[a-z0-9_]+$')),
            reason: '${medication.id} has an unstable point id: ${point.id}',
          );
          expect(
            pointIds.add(point.id),
            isTrue,
            reason:
                '${medication.id} has a duplicated application point id: ${point.id}',
          );
          expect(
            point.imageAssetPath,
            isNotEmpty,
            reason: '${point.id} must reference an image asset.',
          );
          expect(
            point.highlightAreaId,
            isNotEmpty,
            reason: '${point.id} must declare a highlight area id.',
          );
          expect(
            point.parentSiteLabel,
            isNotEmpty,
            reason: '${point.id} must declare a parent region label.',
          );
          expect(
            point.regionId,
            isNotNull,
            reason: '${point.id} must declare regionId.',
          );
          expect(
            point.regionType,
            isNotNull,
            reason: '${point.id} must declare regionType.',
          );
          expect(
            point.bodySide,
            isNotNull,
            reason: '${point.id} must declare bodySide.',
          );

          final asset = File(point.imageAssetPath);
          expect(
            asset.existsSync(),
            isTrue,
            reason:
                '${point.id} references a missing asset: ${point.imageAssetPath}',
          );

          if (_isSvgAsset(point.imageAssetPath)) {
            final svg = asset.readAsStringSync();
            expect(
              _containsSvgId(svg, point.highlightAreaId),
              isTrue,
              reason:
                  '${point.id} expects ${point.highlightAreaId} inside ${point.imageAssetPath}.',
            );
          }
        }
      }
    });

    test('Copaxone abdomen SVG matches the four-point visual contract', () {
      final svg = File(
        'assets/images/application_sites/copaxone_abdomen_points.svg',
      ).readAsStringSync();
      final expectedIds = {
        'abdomen_right_upper',
        'abdomen_right_lower',
        'abdomen_left_upper',
        'abdomen_left_lower',
      };

      final abdomenIds = _svgIds(
        svg,
      ).where((id) => id.startsWith('abdomen_')).toSet();

      expect(abdomenIds, expectedIds);
      expect(_applicationMarkerCount(svg), expectedIds.length);
    });

    test('Copaxone highlight areas map to one precise marker each', () {
      final copaxone = medicationById('copaxone_20mg');

      for (final point in service.getApplicationPoints(copaxone)) {
        if (!_isSvgAsset(point.imageAssetPath)) {
          continue;
        }

        final svg = File(point.imageAssetPath).readAsStringSync();
        final element = _svgElementById(svg, point.highlightAreaId);

        expect(
          _applicationMarkerCount(element),
          lessThanOrEqualTo(1),
          reason:
              '${point.highlightAreaId} must map to a single visible marker in ${point.imageAssetPath}.',
        );
      }
    });
  });
}

bool _containsSvgId(String svg, String id) {
  return RegExp('''\\bid=(["'])${RegExp.escape(id)}\\1''').hasMatch(svg);
}

bool _isSvgAsset(String path) => path.toLowerCase().endsWith('.svg');

Set<String> _svgIds(String svg) {
  return RegExp(
    '''\\bid=(["'])(.*?)\\1''',
  ).allMatches(svg).map((match) => match.group(2)!).toSet();
}

int _applicationMarkerCount(String svg) {
  return RegExp(r'<circle\b[^>]*\br="10"').allMatches(svg).length;
}

String _svgElementById(String svg, String id) {
  final escapedId = RegExp.escape(id);
  final group = RegExp(
    '''<g\\b[^>]*\\bid=(["'])$escapedId\\1[^>]*>[\\s\\S]*?</g>''',
  ).firstMatch(svg);

  if (group != null) {
    return group.group(0)!;
  }

  return RegExp(
        '''<[^>]+\\bid=(["'])$escapedId\\1[^>]*(?:/>|>[\\s\\S]*?</[^>]+>)''',
      ).firstMatch(svg)?.group(0) ??
      '';
}
