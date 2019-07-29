import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../env.dart';
import '../themes/helpers/fonts.dart';
import '../themes/helpers/theme_colors.dart';

String _selectedService = 'SERVICE';
String _selectedName = 'PERSON NAME';

class AddServices extends StatefulWidget {
  AddServices({Key key, this.documentId}) : super(key: key);

  final String documentId;

  @override
  _AddServicesState createState() => _AddServicesState();
}

class _AddServicesState extends State<AddServices> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 10,
      contentPadding: const EdgeInsets.only(
          top: 64.0, right: 64.0, left: 64.0, bottom: 64.0),
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
                  AutoSizeText(
                    "Add Service",
                    minFontSize: 32.0,
                    maxFontSize: 128.0,
                    style: font20Black,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: DropdownButton<String>(
                  hint: AutoSizeText(
                    _selectedService,
                    minFontSize: 24.0,
                  ),
                  items: <String>[
                    'Hair Conditioner',
                    'Cut Nail',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: AutoSizeText(
                        value,
                        minFontSize: 24.0,
                      ),
                    );
                  }).toList(),
                  onChanged: (selected) {
                    setState(() {
                      _selectedService = selected;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: DropdownButton<String>(
                  hint: AutoSizeText(
                    _selectedName,
                    minFontSize: 24.0,
                  ),
                  items: <String>['Nou TithPanha', 'Num Pang Sach']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: AutoSizeText(
                        value,
                        minFontSize: 24.0,
                      ),
                    );
                  }).toList(),
                  onChanged: (selected) {
                    setState(() {
                      _selectedName = selected;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      padding:
                          const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
                      color: blueColor,
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
