import 'package:get_it/get_it.dart';
import 'package:shouldideploy/should_did_deploy/data/repository/shouldideploy_repository.dart';

class Singletons {
  static void init() {
    _initRepositories();
  }

  static void _initRepositories() {
    GetIt.instance.registerSingleton<ShouldDidDeployRepository>(
      ShouldDidDeployRepository(),
    );
  }
}
