import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'splash_screen.dart';
import 'package:store_transaction/splash_screen.dart';

import 'themes/helpers/fonts.dart';

class ConnectPrinterScreen extends StatefulWidget {
  @override
  _ConnectPrinterScreenState createState() => _ConnectPrinterScreenState();
}

class _ConnectPrinterScreenState extends State<ConnectPrinterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SharedPreferences sharedPreferences;
  TextEditingController _bluetoothAddress = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getSharePreference();
  }

  Future _getSharePreference() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pinkAccent,
          centerTitle: true,
          title: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  ReCase('printer setting').titleCase,
                  style: font20White,
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(150.0),
                child: Row(
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Expanded(
                        flex: 5,
                        child: TextFormField(
                          controller: _bluetoothAddress,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText:
                                ReCase('input printer address').sentenceCase,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return ReCase(
                                'please enter the printer address',
                              ).sentenceCase;
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        )),
                        textColor: Colors.white,
                        color: Colors.pinkAccent,
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              ReCase('connect').titleCase,
                            ),
                          ],
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await sharedPreferences
                                .setString(
                              'bluetoothAddress',
                              _bluetoothAddress.text,
                            )
                                .whenComplete(() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return SplashScreen();
                                  },
                                ),
                              );
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
