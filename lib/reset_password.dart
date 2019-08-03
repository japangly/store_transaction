import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:recase/recase.dart';
import 'package:store_transaction/dialog/email_not_found_dialog.dart';
import 'package:store_transaction/functions/authenticate.dart';
import 'package:store_transaction/login_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController emailTextController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.only(left: 200.0, right: 200.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 200.0, right: 30.0, left: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Reset Password',
                        style: TextStyle(
                            fontFamily: 'Realistica',
                            fontSize: 50.0,
                            color: Colors.pinkAccent),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: TextFormField(
                          controller: emailTextController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: ReCase('email address').titleCase,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return ReCase(
                                'please enter the email address',
                              ).sentenceCase;
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                )),
                                textColor: Colors.white,
                                color: Colors.pinkAccent,
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new Text(
                                      "Reset",
                                    ),
                                    Icon(Icons.arrow_forward)
                                  ],
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    bool isSuccess = await Authenticate()
                                        .resetPassword(
                                            email: emailTextController.text
                                              ..toLowerCase().trim());
                                    if (isSuccess == true) {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()),
                                          (Route<dynamic> route) => false);
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (_) {
                                            return EmailNotFoundDialog();
                                          });
                                    }
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
            ),
          ),
        ),
      ),
    );
  }
}
