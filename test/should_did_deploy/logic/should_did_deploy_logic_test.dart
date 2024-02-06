import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktailx/mocktailx.dart';
import 'package:shouldideploy/should_did_deploy/data/repository/shouldideploy_repository.dart';
import 'package:shouldideploy/should_did_deploy/logic/should_did_deploy_logic.dart';

import '../../mocks/shouldiddeploy_api_mock.dart' as shouldideployApi;

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

  group('Logic - shouldDidDeployToday - ', () {
    test('Success', () async {
      when(() => _repository.shouldDidDeployToday())
          .thenAnswer((_) async => shouldideployApi.mockedSuccess);

      final response = await shouldDidDeployToday(_ref);

      final shouldideploy = response.shouldideploy;
      expect(shouldideploy, isTrue);
    });

    test('Error', () async {
      when(() => _repository.shouldDidDeployToday())
          .thenAnswer((_) async => shouldideployApi.mockedError);

      final response = await shouldDidDeployToday(_ref);

      final shouldideploy = response.shouldideploy;
      expect(shouldideploy, isFalse);
    });
  });
}
