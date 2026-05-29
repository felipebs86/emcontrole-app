import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:emcontrole/app/app.dart';

void main() {
  testWidgets('shows foundation screens and navigates between them', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const EMControleApp());

    expect(find.text('Bem-vindo ao EMControle'), findsOneWidget);

    await tester.tap(find.text('Tratamento'));
    await tester.pumpAndSettle();
    expect(find.text('Tratamento'), findsWidgets);

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

    await tester.tap(find.text('Tratamento'));
    await tester.pumpAndSettle();

    await tester.ensureVisible(
      find.byKey(const Key('treatment-submit-button')),
    );
    await tester.tap(find.byKey(const Key('treatment-submit-button')));
    await tester.pump();

    expect(find.text('Informe seu nome.'), findsOneWidget);
    expect(find.text('Informe o nome do medicamento.'), findsOneWidget);
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
    await tester.enterText(
      find.byKey(const Key('treatment-medication-field')),
      'Medicamento informado',
    );
    await tester.ensureVisible(find.byKey(const Key('treatment-site-field')));
    await tester.enterText(
      find.byKey(const Key('treatment-site-field')),
      'Braço esquerdo',
    );
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
}
