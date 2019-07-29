import 'package:flutter/material.dart';
import 'package:store_transaction/themes/helpers/theme_colors.dart';
// import 'package:store_stockroom/themes/helpers/theme_colors.dart';

import 'login_screen.dart';
import 'themes/helpers/splash_screen_plugin.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreenStyles(
      seconds: 3,
      navigateAfterSeconds: LoginScreen(),
      imageBackground: AssetImage('assets/images/splash_screen.png'),
      title: Text(
        'Mickey & Honey',
        style: TextStyle(
            fontFamily: 'Realistica', color: whiteColor, fontSize: 70),
      ),
      loaderColor: Colors.transparent,
    );
  }
}
