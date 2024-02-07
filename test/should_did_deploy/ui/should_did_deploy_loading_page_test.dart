import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:shouldideploy/should_did_deploy/ui/should_did_deploy_loading_page.dart';

import '../../flutter_test_config.dart';

void main() {
  Future<void> createWidget(
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ShouldDidDeployLoadingPage(),
      ),
    );
  }

  group('[Widget] ShouldDidDeployLoadingPage', () {
    testWidgets(' - Loading scenario', (tester) async {
      await createWidget(tester);
      await tester.pump();

      expect(
        find.text('Your network connection is slow.\n Maybe it\'s a sign. 🫠\n'
            ' Wait for the result to make your decision!'),
        findsOneWidget,
      );
    });
  });

  group('[Golden] ShouldDidDeployLoadingPage', () {
    testGoldens(' - Loading scenario', (tester) async {
      await loadAppFonts();
      await tester.pumpWidgetBuilder(
        const ShouldDidDeployLoadingPage(),
      );

      await multiScreenGolden(
        tester,
        'Loading_Page',
        devices: projectDevices,
        customPump: (p0) => tester.pump(const Duration(seconds: 2)),
      );
    });
  });
}
