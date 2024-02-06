import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktailx/mocktailx.dart';
import 'package:shouldideploy/core/singletons.dart';
import 'package:shouldideploy/should_did_deploy/data/repository/shouldideploy_repository.dart';

class MockSingletons extends Mock implements Singletons {}

void main() {
  test('Que é recomendado fazer o deploy com uma mensagem positiva.', () async {
    Singletons.init();

    final repositoryIsRegistered =
        GetIt.instance.isRegistered<ShouldDidDeployRepository>();

    expect(repositoryIsRegistered, isTrue);
  });
}
