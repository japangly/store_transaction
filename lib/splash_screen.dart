import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dashboard.dart';
import 'login_screen.dart';
import 'themes/helpers/buttons.dart';
import 'themes/helpers/fonts.dart';
import 'themes/helpers/splash_screen_plugin.dart';
import 'themes/helpers/theme_colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences sharedPreferences;
  String token;

  @override
  void initState() {
    super.initState();
    initSharePreference();
  }

  void initSharePreference() async {
    sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString('uid');
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreenStyles(
      seconds: 3,
      navigateAfterSeconds: DecisionRoute(),
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

class DecisionRoute extends StatefulWidget {
  @override
  _DecisionRouteState createState() => _DecisionRouteState();
}

class _DecisionRouteState extends State<DecisionRoute> {
  bool connectionStatus;
  SharedPreferences sharedPreferences;
  String token;

  @override
  void initState() {
    super.initState();
    getTokenFromSharePreference();
  }

  void getTokenFromSharePreference() async {
    sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString('uid');
  }

  checkInternetConnection() async {
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      connectionStatus = true;
    } else {
      connectionStatus = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkInternetConnection(),
      builder: (BuildContext context, snapshot) {
        return connectionStatus == false
            ? NoInternetScreen()
            : (token == null) ? LoginScreen() : Dashboard();
      },
    );
  }
}

class NoInternetScreen extends StatefulWidget {
  @override
  _NoInternetScreenState createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Stock Transaction'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(64.0),
            child: Container(
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 50.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: AutoSizeText(
                          'No Internet Connection!',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Avenir',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                        child: AutoSizeText(
                          'Please check your internet connection and try again.',
                          style: font15Grey,
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                  CustomButton(
                    textButton: 'Exit',
                    colorButton: removeColor,
                    onPressed: () {
                      exit(0);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
