import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentication {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SharedPreferences sharedPreferences;
  FirebaseUser user;

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

  Future<bool> changePassword({
    @required String newPassword,
  }) async {
    try {
      FirebaseUser firebaseUser = await firebaseAuth.currentUser();
      firebaseUser.updatePassword(newPassword);
      return true;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> resetPassword({@required String email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
