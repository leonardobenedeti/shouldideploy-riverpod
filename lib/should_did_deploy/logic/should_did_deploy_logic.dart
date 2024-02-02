import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shouldideploy/should_did_deploy/data/model/should_did_deploy_model.dart';
import 'package:shouldideploy/should_did_deploy/data/repository/shouldideploy_repository.dart';

part 'should_did_deploy_logic.g.dart';

@riverpod
Future<ShouldDidDeployToday> shouldDidDeployToday(
  ShouldDidDeployTodayRef ref,
) async {
  final repository = GetIt.I<ShouldDidDeployRepository>();

  final response = await repository.shouldDidDeployToday();

  return ShouldDidDeployToday.fromJson(response);
}
