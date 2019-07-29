import 'package:flutter/material.dart';
import 'package:store_transaction/themes/helpers/fonts.dart';

import '../env.dart';

class ErrorDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 10,
      contentPadding:
          const EdgeInsets.only(top: 40.0, right: 20, left: 20, bottom: 0.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: SingleChildScrollView(
        child: Container(
          width: Environment().getWidth(width: 13),
          height: Environment().getHeight(height: 13),
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Icon(
                    Icons.error,
                    color: Colors.redAccent,
                    size: 70.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Oops!",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: Text(
                      'Something wrong',
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
