

import 'package:flutter/material.dart';

class ApplicationStatus extends StatefulWidget {
  const ApplicationStatus({Key? key}) : super(key: key);
  @override
  State<ApplicationStatus> createState() => _ApplicationStatusState();
}

class _ApplicationStatusState extends State<ApplicationStatus> {

  List createMapList(Map mapname) {
    List tempList = [];
    for (String key in mapname.keys) {
      tempList.add(key);
    }
    return tempList;
  }
  String stepKey = 'step1';

  Map formDataFinal = {};
  List verifiedSteps = [];

  Map userDetails = {
    'name': "Aditya PK",
    'gender': "male",
    'age': "19"
  };

  List approverList = [
    {
      'name': "Aditya PK",
      'role': "verification officer",
      'status': "verified"
    },{
      'name': "Vignesh U",
      'role': "verification officer",
      'status': "pending"
    },
    {
      'name': "Tarun K",
      'role': "department head",
      'status': "rejected"
    }
  ];

  @override
  Widget build(BuildContext context) {

    final String dept = 'Karnataka State Council \nfor Science and Technology';
    final String schemeName = 'KSCST : Rainwater Harvesting \n(RWH) : Karnataka';
    final String schemeDate = '23 Mar 2018';
    final String applicationId = 'IUVBEFIOAB876UB';

    Color getVerifiedColor(item){
      if(item == "verified"){
        return Color.fromRGBO(114, 175, 16, 1);
      }
      else if(item == "pending"){
        return Color.fromRGBO(209, 214, 0, 1);
      }
      else {
        return Color.fromRGBO(255, 70, 70, 1);
      }
    }

    String getStatusIcon(item){
      if(item == "verified"){
        return 'assets/images/tickGreen.png';
      }
      else if(item == "pending"){
        return 'assets/images/tickYellow.png';
      }
      else {
        return 'assets/images/tickRed.png';
      }
    }

    Widget verificationOfficerCards(List items){
      return new Column(
          children: items.map((item) =>
          new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white, // Replace with your desired color
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item['name'],
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            )),
                        SizedBox(height: 10,),
                        Text('${item['role']}',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400
                            )),
                        SizedBox(height: 20,),
                        Text('Status - ${item['status']}',
                            style: TextStyle(
                                color: getVerifiedColor(item['status']),
                                fontSize: 22,
                                fontWeight: FontWeight.w500
                            )),
                      ],),
                    Image.asset(
                      getStatusIcon(item['status']),
                      height: 60,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
          ],)
          ).toList()
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          leading: TextButton(
            onPressed: () {},
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {},
            ),
          ),
          title: Text('Application Status'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(242, 242, 242, 1), // Replace with your desired color
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Replace with your desired color
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/kcst.png',
                                height: 80,
                              ),
                              SizedBox(width: 20,),
                              Text(dept,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text(schemeName,
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold
                            )),
                        SizedBox(height: 10,),
                        Text(schemeDate,
                            style: TextStyle(
                                color: Color(0xff8E8E8E),
                                fontSize: 20,
                                fontWeight: FontWeight.w400
                            )),
                        SizedBox(height: 20,),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(userDetails['name'],
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold
                                      )),
                                  SizedBox(height: 10,),
                                  Text('Age ${userDetails['age']} - ${userDetails['gender']}',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400
                                      )),
                                ],),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(applicationId,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold
                                      )),
                                  SizedBox(height: 10,),
                                  Text('Application ID',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400
                                      )),
                                ],),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text('Approval Process',
                            style: TextStyle(
                                fontSize: 24,
                                color: Color.fromRGBO(86, 86, 86, 1),
                                fontWeight: FontWeight.w500
                            )),
                        SizedBox(height: 10,),
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        verificationOfficerCards(approverList),
                      ],
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
