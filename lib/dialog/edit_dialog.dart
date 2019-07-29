import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

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
      contentPadding:
          const EdgeInsets.only(top: 20.0, right: 40, left: 40, bottom: 20.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      content: SingleChildScrollView(
        child: Container(
          width: Environment().getWidth(width: 10.0),
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "Edit Product",
                    style: font20Black,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: FormBuilderTextField(
                  attribute: "quantity",
                  style: font15Grey,
                  decoration: InputDecoration(
                    labelText: "Quantity",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomButton(
                      onPressed: () {},
                      textButton: 'Save',
                      colorButton: confirmColor,
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
