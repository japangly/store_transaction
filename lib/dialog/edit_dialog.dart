import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

import '../env.dart';
import '../themes/helpers/buttons.dart';
import '../themes/helpers/fonts.dart';
import '../themes/helpers/theme_colors.dart';

class EditDialog extends StatelessWidget {
  EditDialog({Key key, @required this.documentId}) : super(key: key);

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
          width: Environment().getWidth(width: 13),
          height: Environment().getHeight(height: 13),
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    ReCase('edit product').titleCase,
                    style: font20Black,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: TextFormField(
                  style: font15Grey,
                  decoration: InputDecoration(
                    labelText: ReCase('quantity').titleCase,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomButton(
                      textButton: ReCase('save').titleCase,
                      colorButton: confirmColor,
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
