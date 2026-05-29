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
}
