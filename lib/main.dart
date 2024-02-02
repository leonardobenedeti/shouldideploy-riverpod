import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shouldideploy/core/singletons.dart';
import 'package:shouldideploy/should_did_deploy/ui/should_did_deploy_builder.dart';

void main() {
  Singletons.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Should Did Deploy',
      home: ShouldDidDeployBuilder(),
    );
  }
}
