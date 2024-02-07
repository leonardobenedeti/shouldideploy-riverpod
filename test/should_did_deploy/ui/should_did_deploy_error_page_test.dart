import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:shouldideploy/should_did_deploy/ui/should_did_deploy_error_page.dart';

import '../../flutter_test_config.dart';

void main() {
  Future<void> createWidget(
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ShouldDidDeployErrorPage(
          onTryAgain: () {},
        ),
      ),
    );
  }

  group('[Widget] - ShouldDidDeployErrorPage', () {
    testWidgets(' - Error scenario', (tester) async {
      await createWidget(tester);
      await tester.pump();

      expect(find.text('Oops, something unexpected happened'), findsOneWidget);
    });
  });

  group('[Goldens] - ShouldDidDeployErrorPage', () {
    testGoldens(' - Error scenario', (tester) async {
      await loadAppFonts();
      await tester.pumpWidgetBuilder(
        ShouldDidDeployErrorPage(onTryAgain: () {}),
      );
      await tester.pumpAndSettle();

      await multiScreenGolden(
        tester,
        'Error_Page',
        devices: projectDevices,
      );
    });
  });
}
