import 'package:donation_app/screens/authentication_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: RaisedButton(
        onPressed: () {
          FirebaseAuth.instance.signOut();
          Navigator.of(context)
              .pushReplacementNamed(AuthenticationScreen.routeName);
        },
        child: Text(
          "logout",
          style: TextStyle(
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
