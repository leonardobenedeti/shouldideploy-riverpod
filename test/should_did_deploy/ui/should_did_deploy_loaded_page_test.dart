import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shouldideploy/should_did_deploy/data/model/should_did_deploy_model.dart';
import 'package:shouldideploy/should_did_deploy/ui/should_did_deploy_loaded_page.dart';

import '../../mocks/shouldiddeploy_api_mock.dart';

void main() {
  Future<void> createWidget(
    WidgetTester tester,
    String data,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ShouldDidDeploySuccessPage(
          data: ShouldDidDeployToday.fromJson(data),
          onTryAgain: () {},
        ),
      ),
    );
  }

  group('ShouldDidDeployLoadedPage tests', () {
    testWidgets(
        ' - Quando abrir a tela de sucesso com um retorno positivo, '
        'é preciso mostrar a mensagem e a tela configurada em tons verdes ',
        (tester) async {
      await createWidget(tester, mockedSuccess);
      await tester.pump();

      final questionFinder = find.text('Should did deploy today?');

      expect(questionFinder, findsOneWidget);
      expect(
        (tester.firstWidget(questionFinder) as Text).style?.color,
        Colors.blueGrey[900],
      );

      final tryAgainButton = find.byType(ElevatedButton);

      expect(
        tester.widget(tryAgainButton.first),
        isA<ElevatedButton>().having(
          (w) => w.style?.backgroundColor?.resolve({}),
          'button color',
          Colors.lightGreen[300],
        ),
      );

      final scaffoldFinder = find.byType(Scaffold);
      final scaffold = tester.widget<Scaffold>(scaffoldFinder);
      expect(scaffold.backgroundColor, Colors.lightGreen[200]);
    });

    testWidgets(
        ' - Quando abrir a tela de sucesso com um retorno negativo, '
        'é preciso mostrar a mensagem e a tela configurada em tons vermelhos ',
        (tester) async {
      await createWidget(tester, mockedError);
      await tester.pump();

      final questionFinder = find.text('Should did deploy today?');
      expect(questionFinder, findsOneWidget);
      expect(
        (tester.firstWidget(questionFinder) as Text).style?.color,
        Colors.white,
      );

      final tryAgainButton = find.byType(ElevatedButton);

      expect(
        tester.widget(tryAgainButton.first),
        isA<ElevatedButton>().having(
          (w) => w.style?.backgroundColor?.resolve({}),
          'button color',
          Colors.red[400],
        ),
      );

      final scaffoldFinder = find.byType(Scaffold);
      final scaffold = tester.widget<Scaffold>(scaffoldFinder);
      expect(scaffold.backgroundColor, Colors.red[300]);
    });
  });
}
