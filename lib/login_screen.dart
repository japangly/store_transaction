import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:recase/recase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_transaction/reset_password.dart';

import 'dashboard.dart';
import 'dialog/email_not_found_dialog.dart';
import 'env.dart';
import 'functions/authenticate.dart';
import 'themes/helpers/fonts.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

TextEditingController emailTextController = TextEditingController();
TextEditingController passwordTextController = TextEditingController();

class _LoginState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SharedPreferences sharedPreferences;
  bool _loadingState = false;

  @override
  void initState() {
    super.initState();
  }

  Future signIn(BuildContext context) async {
    setState(() {
      _loadingState = true;
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await Authenticate()
        .signIn(
      email: emailTextController.text.toLowerCase().trim(),
      password: passwordTextController.text,
    )
        .then((token) {
      sharedPreferences.setString(
        'keyUserId',
        token,
      );
      sharedPreferences.setString(
        'email',
        emailTextController.text.toLowerCase().trim(),
      );
    }).whenComplete(() {
      setState(() {
        _loadingState = false;
      });
    }).whenComplete(() {
      emailTextController.clear();
      passwordTextController.clear();
      sharedPreferences.getString('keyUserId') != null
          ? Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Dashboard()),
              (Route<dynamic> route) => false)
          : showDialog(
              context: context,
              builder: (_) {
                return EmailNotFoundDialog();
              });
    });
  }

  @override
  Widget build(BuildContext context) {
    // final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: ModalProgressHUD(
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
                child: Form(
                  key: _formKey,
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
                              TextFormField(
                                controller: emailTextController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: 'Email address',
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
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: TextFormField(
                                  obscureText: true,
                                  controller: passwordTextController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return ReCase(
                                        'please enter the password',
                                      ).sentenceCase;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20.0, bottom: 10.0),
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
                                        onPressed: () async {
                                          if (_formKey.currentState
                                              .validate()) {
                                            await signIn(context);
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 30.0),
                                child: Column(
                                  children: <Widget>[
                                    FlatButton(
                                      child: Text(
                                        'Forgot password?',
                                        style: font20Grey,
                                      ),
                                      onPressed: () async {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ResetPasswordScreen()));
                                      },
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
          ),
          inAsyncCall: _loadingState,
          progressIndicator: CircularProgressIndicator()),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
