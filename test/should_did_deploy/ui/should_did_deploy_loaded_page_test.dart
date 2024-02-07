import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:shouldideploy/should_did_deploy/data/model/mocked_responses.dart';
import 'package:shouldideploy/should_did_deploy/data/model/should_did_deploy_model.dart';
import 'package:shouldideploy/should_did_deploy/ui/should_did_deploy_loaded_page.dart';

import '../../flutter_test_config.dart';

void main() {
  Future<void> createWidget(
    WidgetTester tester,
    String data,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ShouldDidDeployLoadedPage(
          data: ShouldDidDeployToday.fromJson(data),
          onTryAgain: () {},
        ),
      ),
    );
  }

  group('[Widget] ShouldDidDeployLoadedPage - ', () {
    testWidgets('You can deploy', (tester) async {
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

    testWidgets('You can not deploy', (tester) async {
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

  group('[Golden] ShouldDidDeployLoadedPage - ', () {
    testGoldens('You can deploy', (tester) async {
      await loadAppFonts();
      await tester.pumpWidgetBuilder(
        ShouldDidDeployLoadedPage(
          data: ShouldDidDeployToday.fromJson(mockedSuccess),
          onTryAgain: () {},
        ),
      );
      await tester.pumpAndSettle();

      await multiScreenGolden(
        tester,
        'Loaded_Page-Can_deploy',
        devices: projectDevices,
      );
    });

    testGoldens('You can not deploy', (tester) async {
      await loadAppFonts();
      await tester.pumpWidgetBuilder(
        ShouldDidDeployLoadedPage(
          data: ShouldDidDeployToday.fromJson(mockedError),
          onTryAgain: () {},
        ),
      );
      await tester.pumpAndSettle();

      await multiScreenGolden(
        tester,
        'Loaded_Page-Can_not_deploy',
        devices: projectDevices,
      );
    });
  });
}
