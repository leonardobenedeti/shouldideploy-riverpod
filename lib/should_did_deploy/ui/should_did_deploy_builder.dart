import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shouldideploy/should_did_deploy/logic/should_did_deploy_logic.dart';
import 'package:shouldideploy/should_did_deploy/ui/should_did_deploy_error_page.dart';
import 'package:shouldideploy/should_did_deploy/ui/should_did_deploy_loaded_page.dart';
import 'package:shouldideploy/should_did_deploy/ui/should_did_deploy_loading_page.dart';

class ShouldDidDeployBuilder extends ConsumerWidget {
  const ShouldDidDeployBuilder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final response = ref.watch(shouldDidDeployTodayProvider);

    return switch (response) {
      AsyncData(:final value) => ShouldDidDeployLoadedPage(
          data: value,
          onTryAgain: () => ref.refresh(shouldDidDeployTodayProvider.future),
        ),
      AsyncLoading() => const ShouldDidDeployLoadingPage(),
      AsyncError() => ShouldDidDeployErrorPage(
          onTryAgain: () => ref.refresh(shouldDidDeployTodayProvider.future),
        ),
      _ => const ShouldDidDeployLoadingPage(),
    };
  }
}
