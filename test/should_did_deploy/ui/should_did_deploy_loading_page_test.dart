import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shouldideploy/should_did_deploy/ui/should_did_deploy_loading_page.dart';

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

  group('ShouldDidDeployLoadingPage tests', () {
    testWidgets(' - ', (tester) async {
      await createWidget(tester);
      await tester.pump();

      expect(
        find.text('Your network connection is slow.\n Maybe it\'s a sign. 🫠\n'
            ' Wait for the result to make your decision!'),
        findsOneWidget,
      );
    });
  });
}
