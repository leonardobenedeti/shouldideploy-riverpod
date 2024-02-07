import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktailx/mocktailx.dart';
import 'package:shouldideploy/should_did_deploy/data/model/mocked_responses.dart';
import 'package:shouldideploy/should_did_deploy/data/repository/shouldideploy_repository.dart';
import 'package:shouldideploy/should_did_deploy/logic/should_did_deploy_logic.dart';
import 'package:shouldideploy/should_did_deploy/ui/should_did_deploy_builder.dart';
import 'package:shouldideploy/should_did_deploy/ui/should_did_deploy_error_page.dart';
import 'package:shouldideploy/should_did_deploy/ui/should_did_deploy_loaded_page.dart';

class MockShouldDidDeployRepository extends Mock
    implements ShouldDidDeployRepository {}

class MockShouldDidDeployTodayRef extends Mock
    implements ShouldDidDeployTodayRef {}

void main() {
  late ShouldDidDeployRepository _repository;
  late ShouldDidDeployTodayRef _ref;

  setUpAll(() {
    _repository = MockShouldDidDeployRepository();
    _ref = MockShouldDidDeployTodayRef();
    GetIt.instance.registerSingleton<ShouldDidDeployRepository>(_repository);
  });

  Future<void> createWidget(
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          shouldDidDeployTodayProvider.overrideWith(
            (ref) => shouldDidDeployToday(_ref),
          ),
        ],
        child: const MaterialApp(
          home: ShouldDidDeployBuilder(),
        ),
      ),
    );
  }

  group('[Widget] - ShouldDidDeployBuilder - ', () {
    testWidgets('Starting with loading state and then success', (tester) async {
      when(() => _repository.shouldDidDeployToday())
          .thenAnswer((_) async => mockedSuccess);

      await createWidget(tester);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(ShouldDidDeployLoadedPage), findsOneWidget);

      final tryAgainButton = find.byType(ElevatedButton);
      expect(tryAgainButton, findsOneWidget);
      await tester.tap(tryAgainButton);
      await tester.pump();

      verify(() => _repository.shouldDidDeployToday()).called(2);
    });

    testWidgets('Starting with loading state and then error', (tester) async {
      when(() => _repository.shouldDidDeployToday()).thenThrow(Exception());

      await createWidget(tester);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(ShouldDidDeployErrorPage), findsOneWidget);

      final tryAgainButton = find.byType(ElevatedButton);
      expect(tryAgainButton, findsOneWidget);
      await tester.tap(tryAgainButton);
      await tester.pump();

      verify(() => _repository.shouldDidDeployToday()).called(2);
    });
  });
}
