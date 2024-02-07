import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktailx/mocktailx.dart';
import 'package:shouldideploy/should_did_deploy/data/model/mocked_responses.dart';
import 'package:shouldideploy/should_did_deploy/data/repository/shouldideploy_repository.dart';
import 'package:shouldideploy/should_did_deploy/logic/should_did_deploy_logic.dart';

class MockShouldDidDeployRepository extends Mock
    implements ShouldDidDeployRepository {}

class MockShouldDidDeployTodayRef extends Mock
    implements ShouldDidDeployTodayRef {}

void main() {
  late ShouldDidDeployRepository _repository;
  late ShouldDidDeployTodayRef _ref;

  setUpAll(() {
    _ref = MockShouldDidDeployTodayRef();
    _repository = MockShouldDidDeployRepository();
    GetIt.instance.registerSingleton<ShouldDidDeployRepository>(_repository);
  });

  group('[Unit] shouldDidDeployToday - ', () {
    test('You can deploy', () async {
      when(() => _repository.shouldDidDeployToday())
          .thenAnswer((_) async => mockedSuccess);

      final response = await shouldDidDeployToday(_ref);

      final shouldideploy = response.shouldideploy;
      expect(shouldideploy, isTrue);
    });

    test('You can not deploy', () async {
      when(() => _repository.shouldDidDeployToday())
          .thenAnswer((_) async => mockedError);

      final response = await shouldDidDeployToday(_ref);

      final shouldideploy = response.shouldideploy;
      expect(shouldideploy, isFalse);
    });
  });
}
