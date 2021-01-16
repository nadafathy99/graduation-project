import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  Future<String> signin(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return null;
    } catch (e) {
      switch (e.code) {
        case "invalid-email":
          return ('Invalid email or password');

        case "user-disabled":
          return ('This user has been disabled');

        case "wrong-password":
          return ('Invalid email or password');

        case "user-not-found":
          return ('User not found');

        default:
          return ('Check your internet connection');
      }
    }
  }

  Future<String> signup(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return null;
    } catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          return ('This email is already in use');

        case "invalid-email":
          return ('Invalid email');

        case "weak-password":
          return ('Weak password!');

        default:
          return ('Check your internet connection');
      }
    }
  }

  Future<String> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return null;
    } catch (e) {
      return "error!";
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<String> changePassword(String newPassword) async {
    try {
      await FirebaseAuth.instance.currentUser
          .updatePassword(newPassword)
          .then((value) => null);
    } catch (e) {
      switch (e.code) {
        case "weak-password":
          return ('Weak password!');

        case "requires-recent-login":
          return ('Kindly, login again and try');

        default:
          return ('Check your internet connection');
      }
    }
  }
}
