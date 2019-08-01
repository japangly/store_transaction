import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../env.dart';
import '../themes/helpers/fonts.dart';
import '../themes/helpers/theme_colors.dart';

class BarCodeAdd extends StatelessWidget {
  BarCodeAdd({Key key, this.documentId}) : super(key: key);

  final String documentId;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 10,
      contentPadding: const EdgeInsets.only(top: 30.0, right: 40, left: 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      content: SingleChildScrollView(
        child: Container(
          width: Environment().getWidth(width: 16.0),
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  AutoSizeText(
                    "Input Bar Code",
                    style: font20Black,
                    minFontSize: 32.0,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Barcode",
                    labelStyle: TextStyle(fontSize: 24.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0, bottom: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      padding:
                          const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
                      color: pinkColor,
                      child: AutoSizeText(
                        'ADD',
                        minFontSize: 24.0,
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
