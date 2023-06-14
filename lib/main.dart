import 'package:defu_front_end/screens/departmentScreens/applicationStatus.dart';
import 'package:defu_front_end/screens/departmentScreens/createScheme.dart';
import 'package:defu_front_end/screens/departmentScreens/createUser.dart';
import 'package:defu_front_end/screens/departmentScreens/departmentDashboard.dart';
import 'package:defu_front_end/screens/departmentScreens/departmentLogin.dart';
import 'package:defu_front_end/screens/departmentScreens/editUser.dart';
import 'package:defu_front_end/screens/departmentScreens/showUsersApplied.dart';
import 'package:defu_front_end/screens/departmentScreens/viewUsers.dart';
import 'package:defu_front_end/screens/userScreens/ConfirmPIN.dart';
import 'package:defu_front_end/screens/userScreens/SetPin.dart';
import 'package:defu_front_end/screens/userScreens/applyForScheme.dart';
import 'package:defu_front_end/screens/userScreens/dashboard.dart';
import 'package:defu_front_end/screens/userScreens/logIn.dart';
import 'package:defu_front_end/screens/userScreens/signUp.dart';
import 'package:defu_front_end/screens/userScreens/wrongPIN.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'departmentDashboard',
      routes: {
        'signUpScreen': (context) => const SignUpScreen(),
        'logInScreen': (context) => const LogIn(),
        'dashboard': (context) =>
            const DashboardScreen(userId: "6478dfee8a8cb3d08c490bdf"),
        'setPIN': (context) => const SetPIN(),
        'confirmPIN': (context) => const ConfirmPIN(),
        'wrongPIN': (context) => const WrongPIN(),
        'departmentLogin': (context) => const DepartmentLogin(),
        'departmentDashboard': (context) => const DepartmentDashboard(
            userId: "648351b62002a2343b851f3a", deptName: "KSCST"),
        'applyForScheme': (context) => const ApplyForScheme(
            disabled: false,
            schemeId: "6478f5d8d86e57f0f03825cd",
            userId: "6478dfee8a8cb3d08c490bdf"),
        'viewUsers': (context) => const ViewUsers(),
        'createUser': (context) => const CreateUser(),
        'editUser': (context) => const EditUser(),
        // 'verifyApplication': (context) =>
        //     const VerifyApplication(userType: 'verification-officer'),
        'applicationStatus': (context) => const ApplicationStatus(),
        'createScheme': (context) => const CreateScheme(
              deptName: 'KSCST',
            ),
        'ShowUsersApplied': (context) => const ShowUsersApplied(
              schemeId: "6478f5d8d86e57f0f03825cd",
              depUser: {"role": "verificationOfficer"},
            ),
      },
    );
  }
}
