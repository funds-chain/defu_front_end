import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class WrongPIN extends StatefulWidget {
  const WrongPIN({Key? key}) : super(key: key);

  @override
  State<WrongPIN> createState() => _WrongPINState();
}

class _WrongPINState extends State<WrongPIN> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:  PreferredSize(
          preferredSize: Size.fromHeight(75),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.black,
            leading: TextButton(
              onPressed: (){},
              child: Image(
                image: AssetImage('assets/images/schema.png'),
              ),
            ),
            title: const Text('Confirm Wallet PIN'),
          ),
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Row(
                children: [
                  SizedBox(width: 10,),
                  Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black, // Replace with your desired color
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      color: Colors.white, // Replace with your desired color
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  SizedBox(width: 20,),
                  Text("Enter 6 Digit PIN",
                      style:TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      )
                  ),
                ],
              ),
              Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                  child: PinCodeTextField(
                    appContext: context,
                    textStyle: const TextStyle(
                      color: Colors.black54,
                    ),
                    pastedTextStyle: const TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                    ),
                    length: 6,
                    obscureText: true,
                    obscuringCharacter: '*',
                    blinkWhenObscuring: true,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      activeColor: Colors.black,
                      inactiveColor: Colors.white70,
                      selectedColor: Colors.black38,
                      activeFillColor: Color(0xFF6363),
                      selectedFillColor: Color(0xFF6363),
                      inactiveFillColor: Color(0xFF6363),
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                    ),
                    cursorColor: Colors.black,
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    keyboardType: TextInputType.number,
                    boxShadows: const [
                      BoxShadow(
                        offset: Offset(0, 1),
                        color: Colors.black12,
                        blurRadius: 10,
                      )
                    ],
                    onChanged: (value) {},
                  )
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  SizedBox(width: 20,),
                  Text("PIN Codes do not match!",
                  style: TextStyle(
                    color: Color.fromRGBO(255, 0, 0, 1),
                    fontSize: 18
                  ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 10,),
                  TextButton(
                      onPressed: (){
                        Navigator.pushReplacementNamed(context, 'setPIN');
                      },
                      child: Text(
                        "Try Again",
                        style: TextStyle(
                          color: Color.fromRGBO(31, 137, 245, 1),
                          fontSize: 16
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
