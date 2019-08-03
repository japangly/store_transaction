import 'package:flutter/material.dart';
import 'package:store_transaction/dashboard.dart';
import 'notification.dart';

import 'home_screen.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Material App',
      home: new SendNotification(),
    ),
  );
}
