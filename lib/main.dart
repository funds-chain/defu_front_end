import 'package:defu_front_end/screens/signUp.dart';
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
      title: 'De-Fu',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const SignUpScreen(),
      routes: {
        'signUpScreen': (context) => const SignUpScreen(),
      },
    );
  }
}
