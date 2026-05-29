import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:emcontrole/app/app.dart';
import 'package:emcontrole/features/treatment/data/medication_catalog_data_source.dart';
import 'package:emcontrole/features/treatment/domain/application_rotation_service.dart';

void main() {
  test('application point ids are globally unique', () {
    final medications = const MedicationCatalogDataSource().loadMedications();
    final pointIds = [
      for (final medication in medications)
        for (final point in medication.applicationPoints) point.id,
    ];

    expect(pointIds.toSet(), hasLength(pointIds.length));
  });

  test('application point illustrations match medication protocols', () {
    final medications = const MedicationCatalogDataSource().loadMedications();
    final copaxone = medications.singleWhere(
      (medication) => medication.id == 'copaxone',
    );
    final avonex = medications.singleWhere(
      (medication) => medication.id == 'avonex',
    );

    expect(
      copaxone.applicationPoints.every(
        (point) => point.imageAssetPath.contains('copaxone_'),
      ),
      isTrue,
    );
    expect(
      avonex.applicationPoints.every(
        (point) => point.imageAssetPath.endsWith('avonex_thigh_rotation.svg'),
      ),
      isTrue,
    );
  });

  test('rotation service advances medication points by protocol', () {
    final service = const ApplicationRotationService();
    final medications = const MedicationCatalogDataSource().loadMedications();
    final copaxone = medications.singleWhere(
      (medication) => medication.id == 'copaxone',
    );
    final avonex = medications.singleWhere(
      (medication) => medication.id == 'avonex',
    );
    final tecfidera = medications.singleWhere(
      (medication) => medication.id == 'tecfidera',
    );

    expect(service.getInitialPoint(copaxone)?.id, 'copaxone_abdomen_01');
    expect(
      service.getNextPoint(copaxone, 'copaxone_abdomen_01')?.id,
      'copaxone_abdomen_02',
    );
    expect(
      service.getNextPoint(copaxone, 'copaxone_hip_left_18')?.id,
      'copaxone_abdomen_01',
    );
    expect(
      service.getNextPoint(copaxone, 'missing')?.id,
      'copaxone_abdomen_01',
    );

    expect(service.getInitialPoint(avonex)?.id, 'avonex_thigh_right_01');
    expect(
      service.getNextPoint(avonex, 'avonex_thigh_right_01')?.id,
      'avonex_thigh_left_02',
    );
    expect(
      service.getNextPoint(avonex, 'avonex_thigh_left_02')?.id,
      'avonex_thigh_right_01',
    );

    expect(service.getInitialPoint(tecfidera), isNull);
    expect(service.getNextPoint(tecfidera, null), isNull);
  });

  testWidgets('shows foundation screens and navigates between them', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const EMControleApp());

    expect(find.text('Bem-vindo ao EMControle'), findsOneWidget);

    await tester.tap(find.text('Tratamento').last);
    await tester.pumpAndSettle();
    expect(find.text('Configure seu tratamento'), findsOneWidget);

    await tester.tap(find.text('Diário'));
    await tester.pumpAndSettle();
    expect(find.text('Diário'), findsWidgets);

    await tester.tap(find.text('Histórico'));
    await tester.pumpAndSettle();
    expect(find.text('Histórico'), findsWidgets);

    await tester.tap(find.text('Ajustes'));
    await tester.pumpAndSettle();
    expect(find.text('Ajustes'), findsWidgets);
  });

  testWidgets('validates and submits treatment setup form', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const EMControleApp());

    await tester.tap(find.text('Tratamento').last);
    await tester.pumpAndSettle();

    await tester.ensureVisible(
      find.byKey(const Key('treatment-submit-button')),
    );
    await tester.tap(find.byKey(const Key('treatment-submit-button')));
    await tester.pump();

    expect(find.text('Informe seu nome.'), findsOneWidget);
    expect(find.text('Selecione um medicamento.'), findsOneWidget);
    expect(find.text('Informe a data da primeira aplicação.'), findsOneWidget);
    expect(find.text('Informe o horário da aplicação.'), findsOneWidget);

    await tester.ensureVisible(find.byKey(const Key('treatment-name-field')));
    await tester.enterText(
      find.byKey(const Key('treatment-name-field')),
      'Maria',
    );
    await tester.ensureVisible(
      find.byKey(const Key('treatment-medication-field')),
    );
    await tester.tap(find.byKey(const Key('treatment-medication-field')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Copaxone - Injetável').last);
    await tester.pumpAndSettle();

    expect(find.text('Copaxone - Injetável'), findsOneWidget);
    expect(
      find.text('Siga sempre a orientação da sua equipe de saúde.'),
      findsOneWidget,
    );

    await tester.ensureVisible(find.byKey(const Key('treatment-site-field')));
    await tester.tap(find.byKey(const Key('treatment-site-field')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Local 1 - Abdômen direito superior').last);
    await tester.pumpAndSettle();

    expect(find.text('Próximo local de aplicação'), findsOneWidget);
    expect(find.text('Local 1'), findsOneWidget);
    expect(find.text('Abdômen direito superior'), findsOneWidget);
    expect(find.text('Prévia do próximo ponto'), findsOneWidget);
    expect(find.text('Local 2 - Abdômen direito inferior'), findsOneWidget);

    await tester.ensureVisible(
      find.byKey(const Key('treatment-reminders-switch')),
    );
    final switchBounds = tester.getRect(
      find.byKey(const Key('treatment-reminders-switch')),
    );
    await tester.tapAt(switchBounds.centerRight - const Offset(32, 0));
    await tester.pump();

    await tester.ensureVisible(
      find.byKey(const Key('treatment-start-date-field')),
    );
    await tester.tap(find.byKey(const Key('treatment-start-date-field')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    await tester.ensureVisible(
      find.byKey(const Key('treatment-application-time-field')),
    );
    await tester.tap(find.byKey(const Key('treatment-application-time-field')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    await tester.ensureVisible(
      find.byKey(const Key('treatment-submit-button')),
    );
    await tester.tap(find.byKey(const Key('treatment-submit-button')));
    await tester.pump();

    expect(find.text('Tratamento configurado com sucesso.'), findsOneWidget);
    expect(
      find.text('Configuração salva em memória nesta sessão'),
      findsOneWidget,
    );
  });

  testWidgets('hides application site selector for oral medication', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const EMControleApp());

    await tester.tap(find.text('Tratamento').last);
    await tester.pumpAndSettle();

    await tester.ensureVisible(
      find.byKey(const Key('treatment-medication-field')),
    );
    await tester.tap(find.byKey(const Key('treatment-medication-field')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tecfidera - Oral').last);
    await tester.pumpAndSettle();

    expect(find.text('Tecfidera - Oral'), findsOneWidget);
    expect(find.byKey(const Key('treatment-site-field')), findsNothing);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is RichText &&
            widget.text.toPlainText().contains('2 vezes ao dia'),
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is RichText && widget.text.toPlainText().contains('Oral'),
      ),
      findsWidgets,
    );
  });
}
