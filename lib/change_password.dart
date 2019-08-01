import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

import 'dialog/fail_dialog.dart';
import 'functions/authenticate.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController retypePassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: GradientAppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.pinkAccent,
              size: 30.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Setting',
            style: TextStyle(fontSize: 30.0),
          ),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.6, 0.9],
            colors: [
              Colors.pinkAccent,
              Colors.white,
            ],
          ),
        ),
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
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 100.0, right: 30.0, left: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Change Password',
                      style: TextStyle(
                          fontFamily: 'Realistica',
                          fontSize: 50.0,
                          color: Colors.pinkAccent),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: TextFormField(
                        controller: oldPassword,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Old password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: TextFormField(
                        controller: newPassword,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'New password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (password) {
                          var result = password.length < 4
                              ? "Password should have at least 6 characters"
                              : null;
                          return result;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: TextFormField(
                        controller: retypePassword,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value != newPassword.text) {
                            return 'Password is not matching';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Retype new password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
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
                                    "Change",
                                  ),
                                  Icon(Icons.arrow_forward)
                                ],
                              ),
                              onPressed: () async {
                                if (newPassword.text != null &&
                                    retypePassword.text != null) {
                                  if (newPassword.text == retypePassword.text) {
                                    newPassword.clear();
                                    retypePassword.clear();
                                    oldPassword.clear();
                                    await Authenticate().changePassword(
                                      oldPassword: oldPassword.text,
                                      newPassword: newPassword.text,
                                      context: context,
                                    );
                                  }
                                } else {
                                  print('object');
                                  showDialog(
                                      context: context,
                                      builder: (_) {
                                        return FailDialog();
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
          ),
        ),
      ),
    );
  }
}
