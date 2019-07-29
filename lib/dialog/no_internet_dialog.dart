import 'package:flutter/material.dart';
import 'package:store_transaction/themes/helpers/fonts.dart';

import '../env.dart';

class NoInternetDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 10,
      contentPadding:
          const EdgeInsets.only(top: 40.0, right: 20, left: 20, bottom: 20.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: SingleChildScrollView(
        child: Container(
          width: Environment().getWidth(width: 15),
          height: Environment().getHeight(height: 13),
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Icon(
                    Icons.signal_wifi_off,
                    color: Colors.red,
                    size: 70.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "No Internet Connection!",
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Avenir',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                    child: Text(
                      'Please check your internet connection and try again.',
                      style: font20Grey,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
