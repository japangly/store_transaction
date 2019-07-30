import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_transaction/login_screen.dart';

class Authenticate {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseUser user;
  SharedPreferences sharedPreferences;

  Future<String> signIn(
      {@required String email, @required String password}) async {
    try {
      user = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return user.uid;
    } catch (error) {
      return null;
    }
  }

  Future<FirebaseUser> getCurrentUser() async {
    user = await firebaseAuth.currentUser();
    return user;
  }

  Future<void> signOut() async {
    return firebaseAuth.signOut();
  }

  Future<bool> changePassword(
      {@required String oldPassword,
      @required String newPassword,
      @required BuildContext context}) async {
    user = await getCurrentUser();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      firebaseAuth
          .signInWithEmailAndPassword(email: user.email, password: oldPassword)
          .then((reAuth) {
        user.updatePassword(newPassword);
        sharedPreferences.clear().whenComplete(() {
          Navigator.of(context)
              .pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (Route<dynamic> route) => false)
              .whenComplete(() {
            Authenticate().signOut();
          });
        });
        return true;
      });
      print('Success changed password');
    } catch (error) {
      print('error $error');
      return false;
    }
  }

  Future<void> resetPassword({@required String email}) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
