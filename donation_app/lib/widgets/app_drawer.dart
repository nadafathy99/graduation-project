import 'package:donation_app/providers/user_provider.dart';
import 'package:donation_app/screens/authentication_screen.dart';
import 'package:donation_app/screens/home_screen.dart';
import 'package:donation_app/screens/profile_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: SafeArea(
          child: Column(children: [
            ListTile(
              leading: Icon(
                Icons.home,
                size: 30,
                color: Colors.black,
              ),
              title: Text(
                "Home",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: Icon(
                Icons.arrow_right,
                size: 30,
                color: Colors.black,
              ),
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(HomeScreen.routeName),
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.person,
                size: 30,
                color: Colors.black,
              ),
              title: Text(
                "Profile",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: Icon(
                Icons.arrow_right,
                size: 30,
                color: Colors.black,
              ),
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(ProfileScreen.routeName),
            ),
            Divider(),
            ListTile(
                leading: Icon(
                  Icons.logout,
                  size: 30,
                  color: Colors.black,
                ),
                title: Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context)
                      .pushReplacementNamed(AuthenticationScreen.routeName);
                  Provider.of<UserProvider>(context, listen: false).signOut();
                }),
          ]),
        ),
      ),
    );
  }
}
