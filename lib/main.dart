import 'package:flutter/material.dart';
import 'package:shouldideploy/core/singletons.dart';
import 'package:shouldideploy/main_builder.dart';

void main() {
  Singletons.init();
  runApp(const MainBuilder());
}
