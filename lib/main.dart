import 'package:defu_front_end/screens/dashboard.dart';
import 'package:defu_front_end/screens/signUp.dart';
import 'package:defu_front_end/screens/logIn.dart';
import 'package:defu_front_end/screens/SetPin.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'setPIN',
      routes: {
        'signUpScreen': (context) => const SignUpScreen(),
        'logInScreen' : (context) => const LogIn(),
        'dashboard' : (context) => const DashboardScreen(),
        'setPIN' : (context) => const SetPIN(),
      },
    );
  }
}
