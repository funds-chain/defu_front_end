import 'dart:convert';

import 'package:defu_front_end/screens/departmentScreens/departmentDashboard.dart';
import 'package:defu_front_end/screens/userScreens/logIn.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DepartmentLogin extends StatefulWidget {
  const DepartmentLogin({Key? key}) : super(key: key);

  @override
  State<DepartmentLogin> createState() => _DepartmentLoginState();
}

class _DepartmentLoginState extends State<DepartmentLogin> {
  Future<http.Response> getDepartments() async {
    return http
        .get(Uri.parse('http://localhost:3000/department/getDepartments'));
  }

  void getData() async {
    http.Response response = await getDepartments();
    Map res = json.decode(response.body);
    setState(() {
      dept = dept;
      departments = res['data'];
    });
  }

  Future<http.Response> login(String mail, String password) async {
    return http.post(
      Uri.parse('http://localhost:3000/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(<String, String>{'mail': mail, 'password': password}),
    );
  }

  List departments = [];
  String dept = "";

  Map userData = {};

  void enterData(String key, dynamic value) {
    setState(() {
      dept = dept;
      Map temp = userData;
      temp[key] = value;
      userData = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (departments.length == 0) {
      getData();
    }
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
                        'Department Login',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 36,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          'To get your department signed up, contact admin',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color(0xff939393)),
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
                            Icons.account_circle_rounded,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),

                            // dropdown below..
                            child: DropdownButton(
                              value: "KSCST",
                              onChanged: (value) {
                                print(value);
                                setState(() {
                                  dept = value.toString();
                                });
                              },
                              items: departments
                                  .map((item) => DropdownMenuItem(
                                        value: item['department_name'],
                                        child:
                                            Text('${item['department_name']}'),
                                      ))
                                  .toList(),

                              // add extra sugar..
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 42,
                              underline: SizedBox(),
                            ),
                          )
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DepartmentDashboard(
                                    userId: res['_id'], deptName: dept)),
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
                                  builder: (context) => LogIn(),
                                ),
                              );
                            },
                            child: const Text(
                              'User Login',
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
