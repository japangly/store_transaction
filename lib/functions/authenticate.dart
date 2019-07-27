import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authenticate {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
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

  Future<bool> changePassword({@required String password}) async {
    user = await getCurrentUser();

    try {
      user.updatePassword(password);
      print('Success changed password');
      return true;
    } catch (error) {
      print('error $error');
      return false;
    }
  }
}
