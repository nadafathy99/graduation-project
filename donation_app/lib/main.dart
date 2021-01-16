import 'package:donation_app/providers/user_provider.dart';
import 'package:donation_app/screens/authentication_screen.dart';
import 'package:donation_app/screens/home_screen.dart';
import 'package:donation_app/screens/profile_screen.dart';
import 'package:donation_app/screens/splash_screen.dart';
import 'package:donation_app/widgets/Buttom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        title: 'The help',
        theme: ThemeData(
          primaryColor: Colors.black,
          accentColor: Colors.white,
          fontFamily: 'OpenSans',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: FutureBuilder<Object>(
            future: _initialization,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SplashScreen();
              } else {
                if (FirebaseAuth.instance.currentUser != null) {
                  return Bottomnavbar();
                } else {
                  return AuthenticationScreen();
                }
              }
            }),
        routes: {
          HomeScreen.routeName: (context) => HomeScreen(),
          AuthenticationScreen.routeName: (context) => AuthenticationScreen(),
          Bottomnavbar.routeName: (context) => Bottomnavbar(),
          ProfileScreen.routeName: (context) => ProfileScreen(),
        },
      ),
    );
  }
}
