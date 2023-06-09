import 'dart:convert';

import 'package:defu_front_end/screens/departmentScreens/departmentLogin.dart';
import 'package:defu_front_end/screens/userScreens/dashboard.dart';
import 'package:defu_front_end/screens/userScreens/signUp.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  Future<http.Response> login(String mail, String password) async {
    return http.post(
      Uri.parse('http://localhost:3000/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(<String, String>{'mail': mail, 'password': password}),
    );
  }

  Map userData = {};

  void enterData(String key, dynamic value) {
    setState(() {
      Map temp = userData;
      temp[key] = value;
      userData = temp;
      print(userData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/signInImage.png',
                        fit: BoxFit.fitWidth,
                        height: 300,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Login As User',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 36,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          'New User?',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color(0xff939393)),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.blue, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 500,
                color: const Color(0xffF2F2F7),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      height: 67,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          const Icon(
                            Icons.mail,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: 270,
                            child: TextFormField(
                              onChanged: (text) {
                                enterData('mail', text);
                              },
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              decoration: const InputDecoration(
                                hintText: 'Email',
                                enabledBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 67,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          const Icon(
                            Icons.lock,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: 270,
                            child: TextFormField(
                              onChanged: (text) {
                                enterData('password', text);
                              },
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              decoration: const InputDecoration(
                                hintText: 'Password',
                                enabledBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Row(
                        children: [
                          const Spacer(),
                          const Text(
                            'Forgot Password?',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color(0xff939393)),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Tap Here',
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 16),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 190,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xff6A4C93)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          http.Response response = await login(
                              userData['mail'], userData['password']);
                          Map res = json.decode(response.body);
                          print(res);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DashboardScreen(
                                      userId: res['_id'],
                                    )),
                          );
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    Center(
                      child: Row(
                        children: [
                          const Spacer(),
                          const Text(
                            'Click here for',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color(0xff939393)),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DepartmentLogin(),
                                ),
                              );
                            },
                            child: const Text(
                              'Department Login',
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 16),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
