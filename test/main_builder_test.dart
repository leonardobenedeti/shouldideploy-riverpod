import 'package:flutter_test/flutter_test.dart';
import 'package:shouldideploy/main_builder.dart';
import 'package:shouldideploy/should_did_deploy/ui/should_did_deploy_builder.dart';

void main() {
  Future<void> createWidget(
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MainBuilder());
  }

  group('ShouldDidDeployErrorPage tests', () {
    testWidgets(' - ', (tester) async {
      await createWidget(tester);
      await tester.pump();

      expect(find.byType(ShouldDidDeployBuilder), findsOneWidget);
    });
  });
}
