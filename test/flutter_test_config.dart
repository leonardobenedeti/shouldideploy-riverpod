import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:golden_toolkit/golden_toolkit.dart' as toolkit;

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  return await GoldenToolkit.runWithConfiguration(
    () async {
      TestWidgetsFlutterBinding.ensureInitialized();

      await loadAppFonts();
      return testMain();
    },
    config: GoldenToolkitConfiguration(
      enableRealShadows: true,
      deviceFileNameFactory: _buildDeviceName,
    ),
  );
}

String _buildDeviceName(String name, Device device) =>
    'goldens/${name}__${device.name}.png';

class Devices {
  static toolkit.Device get iPhone15 => const toolkit.Device(
        size: Size(414, 896),
        name: 'iPhone_15',
        safeArea: EdgeInsets.only(top: 48, bottom: 34),
      );

  static toolkit.Device get iPhone15ProMax => const toolkit.Device(
        size: Size(428, 926),
        name: 'iPhone_15_ProMax',
        safeArea: EdgeInsets.only(top: 47, bottom: 34),
      );
}

final projectDevices = [
  Devices.iPhone15,
  Devices.iPhone15ProMax,
];

extension DoubleExtensions on double {
  String title() {
    return toString().replaceFirst('.', '_');
  }
}
