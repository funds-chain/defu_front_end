import 'package:defu_front_end/screens/departmentScreens/departmentDashboard.dart';
import 'package:defu_front_end/screens/departmentScreens/departmentLogin.dart';
import 'package:defu_front_end/screens/userScreens/ConfirmPIN.dart';
import 'package:defu_front_end/screens/userScreens/SetPin.dart';
import 'package:defu_front_end/screens/userScreens/applyForScheme.dart';
import 'package:defu_front_end/screens/userScreens/dashboard.dart';
import 'package:defu_front_end/screens/userScreens/logIn.dart';
import 'package:defu_front_end/screens/userScreens/signUp.dart';
import 'package:defu_front_end/screens/userScreens/wrongPIN.dart';
import 'package:defu_front_end/screens/departmentScreens/viewUsers.dart';
import 'package:defu_front_end/screens/departmentScreens/createUser.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'createUser',
      routes: {
        'signUpScreen': (context) => const SignUpScreen(),
        'logInScreen': (context) => const LogIn(),
        'dashboard': (context) => const DashboardScreen(),
        'setPIN': (context) => const SetPIN(),
        'confirmPIN': (context) => const ConfirmPIN(),
        'wrongPIN': (context) => const WrongPIN(),
        'departmentLogin': (context) => const DepartmentLogin(),
        'departmentDashboard': (context) => const DepartmentDashboard(),
        'applyForScheme': (context) => const ApplyForScheme(),
        'viewUsers': (context) => const ViewUsers(),
        'createUser': (context) => const CreateUser(),
      },
    );
  }
}
