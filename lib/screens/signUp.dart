import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                        'Register As User',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 36,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          'Already have an account?',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color(0xff939393)),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Sign In',
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
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              decoration: const InputDecoration(
                                hintText: 'Aadhar Number',
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
                              'Tape Here',
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
                        onPressed: () {},
                        child: const Text(
                          'Register',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    )
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
