import 'package:flutter/material.dart';
import 'package:store_transaction/dashboard.dart';
import 'package:store_transaction/login_screen.dart';
import 'package:store_transaction/splash_screen.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Material App',
      home: LoginScreen(),
    ),
  );
}
