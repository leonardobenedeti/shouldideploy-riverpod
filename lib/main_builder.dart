import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shouldideploy/should_did_deploy/ui/should_did_deploy_builder.dart';

class MainBuilder extends StatelessWidget {
  const MainBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(
      child: MaterialApp(
        title: 'Should Did Deploy',
        home: ShouldDidDeployBuilder(),
      ),
    );
  }
}
