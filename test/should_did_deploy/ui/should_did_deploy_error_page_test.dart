import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shouldideploy/should_did_deploy/ui/should_did_deploy_error_page.dart';

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

  group('ShouldDidDeployErrorPage tests', () {
    testWidgets(' - ', (tester) async {
      await createWidget(tester);
      await tester.pump();

      expect(find.text('Oops, something unexpected happened'), findsOneWidget);
    });
  });
}
