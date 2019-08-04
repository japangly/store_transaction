import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'splash_screen.dart';

void main() async {
  ///
  /// Force the layout to Orientati on Landscape mode
  ///
  ///
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then(
    (_) {
      runApp(
        MaterialApp(
          title: 'store_transaction',
          home: SplashScreen(),
        ),
      );
    },
  );
}
