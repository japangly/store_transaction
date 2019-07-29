import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:store_transaction/dialog/receipt_dialog.dart';
import 'package:store_transaction/themes/helpers/fonts.dart';
import 'env.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

TextEditingController phoneTextController = TextEditingController();

class _LoginState extends State<LoginScreen> {
  String phoneNumber;
  bool validatePhoneNumber;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0.1, 0.3],
                  colors: [Colors.pinkAccent, Colors.white])),
          child: Padding(
            padding: const EdgeInsets.only(right: 200.0, left: 200.0),
            child: SingleChildScrollView(
              child: Wrap(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 100.0, right: 30.0, left: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Welcome Back',
                          style: TextStyle(
                              fontFamily: 'Realistica',
                              fontSize: 50.0,
                              color: Colors.pinkAccent),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 50.0),
                          child: Text(
                            'Login to continue',
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.black38),
                          ),
                        ),
                        FormBuilderTextField(
                          keyboardType: TextInputType.emailAddress,
                          attribute: 'email',
                          decoration: InputDecoration(
                            labelText: 'Email address',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validators: [
                            FormBuilderValidators.required(
                                errorText: 'Email address cannot be empty.'),
                            FormBuilderValidators.email(
                                errorText:
                                    'Email address need to be a valid email address.'),
                            FormBuilderValidators.maxLength(30),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: FormBuilderTextField(
                            keyboardType: TextInputType.emailAddress,
                            attribute: 'password',
                            decoration: InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 20.0, bottom: 10.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  )),
                                  textColor: Colors.white,
                                  color: Colors.pink,
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      new Text(
                                        "Proceed",
                                      ),
                                      Icon(Icons.arrow_forward)
                                    ],
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (_) {
                                          return ReceiptDialog();
                                        });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 8.0, bottom: 30.0),
                          child: Column(
                            children: <Widget>[
                              FlatButton(
                                child: Text(
                                  'Forgot password?',
                                  style: font20Grey,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/login_screen.png',
                              height: Environment().getHeight(height: 13),
                            )
                          ],
                        ),
                      ],
                    ),
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
