import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_transaction/change_password.dart';
import 'package:store_transaction/functions/authenticate.dart';
import 'package:store_transaction/themes/helpers/theme_colors.dart' as prefix0;

import 'env.dart';
import 'login_screen.dart';
import 'themes/helpers/fonts.dart';
import 'themes/helpers/theme_colors.dart';

class UserProfile extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;

  const UserProfile({Key key, @required this.documentSnapshot})
      : super(key: key);
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pinkAccent,
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.settings,
                size: 30.0,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return ChangePasswordScreen();
                    },
                  ),
                );
              },
            )
          ],
          title: Text('Profile',
              style: TextStyle(color: Colors.white, fontSize: 30.0)),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView(children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 15.0),
                      child: Center(
                        child: Container(
                          width: Environment().getHeight(height: 12),
                          height: Environment().getHeight(height: 12),
                          child: CircleAvatar(
                            minRadius: Environment().getHeight(height: 5),
                            maxRadius: Environment().getHeight(height: 5),
                            backgroundImage: NetworkImage(
                              widget.documentSnapshot.data['image'],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '${widget.documentSnapshot.data['last name']} ${widget.documentSnapshot.data['first name']}',
                          style: font30Black,
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.documentSnapshot.data['role'],
                            style: TextStyle(
                              fontSize: 20.0,
                              color: blackColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 100.0, right: 100.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              'Phone Number',
                              style: font20Grey,
                            ),
                            trailing: Text(
                                widget.documentSnapshot.data['phone number'],
                                style: font20Black),
                          ),
                          ListTile(
                            title: Text(
                              'Email',
                              style: font20Grey,
                            ),
                            trailing: Text(
                                widget.documentSnapshot.data['email'],
                                style: font20Black),
                          ),
                          ListTile(
                            title: Text(
                              'Birthday',
                              style: font20Grey,
                            ),
                            trailing: Text(
                                DateFormat('d MMM y')
                                    .format(widget
                                        .documentSnapshot.data['date of birth']
                                        .toDate())
                                    .toString(),
                                style: font20Black),
                          ),
                          ListTile(
                            title: Text(
                              'Place of Birth',
                              style: font20Grey,
                            ),
                            trailing: Text(
                                widget.documentSnapshot.data['place of birth'],
                                style: font20Black),
                          ),
                          ListTile(
                            title: Text(
                              'Address',
                              style: font20Grey,
                            ),
                            trailing: Text(
                                widget.documentSnapshot.data['address'],
                                style: font20Black),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
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
                                    child: new Text(
                                      "Logout",
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    onPressed: () async {
                                      SharedPreferences sharedPreferences =
                                          await SharedPreferences.getInstance();
                                      sharedPreferences
                                          .clear()
                                          .whenComplete(() {
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginScreen()),
                                                (Route<dynamic> route) => false)
                                            .whenComplete(() {
                                          Authenticate().signOut();
                                        });
                                      });
                                      // Navigator.pushNamedAndRemoveUntil(context, newRouteName, predicate);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ]),
            ),
          ],
        ));
  }
}
