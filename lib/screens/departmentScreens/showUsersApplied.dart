import 'dart:convert';

import 'package:defu_front_end/screens/departmentScreens/verifyApplication.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ShowUsersApplied extends StatefulWidget {
  const ShowUsersApplied(
      {Key? key, required this.schemeId, required this.depUser})
      : super(key: key);
  final String schemeId;
  final Map depUser;
  @override
  State<ShowUsersApplied> createState() => _ShowUsersAppliedState();
}

class _ShowUsersAppliedState extends State<ShowUsersApplied> {
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
  List verifiedDocs = [];

  String dept = 'NA';
  String schemeName = 'NA';
  String schemeDate = 'xxxxxxxxxxxxxxxx';

  List applications = [
    {
      "_id": "xxxxxxxxxxxxxxxxxxxx",
      "schemeAppliedDate": "xxxxxxxxxxxxxxxxx",
      "user": {
        "username": "NA",
      }
    }
  ];

  Future<http.Response> getSchemeDetailsSingle() async {
    return http
        .get(Uri.parse('http://localhost:3000/schemes/${widget.schemeId}'));
  }

  Future<http.Response> getSchemeApplications() async {
    return http.get(Uri.parse(
        'http://localhost:3000/appliedSchemesByScheme/${widget.schemeId}'));
  }

  Future<http.Response> getUserDetails(String id) async {
    return http.get(Uri.parse('http://localhost:3000/user/id/${id}'));
  }

  void getData() async {
    http.Response response = await getSchemeDetailsSingle();
    Map responseScheme = json.decode(response.body);
    http.Response responseApplication = await getSchemeApplications();
    Map responseApplic = json.decode(responseApplication.body);
    for (var i = 0; i < responseApplic['data'].length; i++) {
      http.Response response =
          await getUserDetails(responseApplic['data'][i]['userId']);
      Map responseUser = json.decode(response.body);
      responseApplic['data'][i]['user'] = responseUser['data'];
      responseApplic['data'][i]['scheme'] = responseScheme['data'];
    }

    setState(() {
      dept = responseScheme['data']['schemeCreatedBy'];
      schemeName = responseScheme['data']['schemeName'];
      schemeDate = responseScheme['data']['schemeStartDate'].substring(0, 10);
      applications = responseApplic['data'];
    });
  }

  Widget GetMembersList() {
    return new Column(
      children: applications
          .map((member) => new Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromRGBO(
                          226, 226, 226, 1), // Replace with your desired color
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Text(member['_id'].substring(0, 14),
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                  Text('Application ID',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500)),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  member['schemeAppliedDate'].substring(0, 10),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    )),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: [
                                  Text(member['user']['username'],
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                VerifyApplication(
                                                    depUser: widget.depUser,
                                                    userType:
                                                        widget.depUser['role'],
                                                    application: member)),
                                      );
                                    },
                                    child: Text(
                                      'Verify Application',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        primary:
                                            Color.fromRGBO(61, 137, 245, 1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        )),
                                  ),
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (dept == "NA") {
      getData();
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
          title: Text('Verify Application'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                            SizedBox(
                              width: 20,
                            ),
                            Text(dept,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(schemeName,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(schemeDate,
                          style: TextStyle(
                              color: Color(0xff8E8E8E),
                              fontSize: 20,
                              fontWeight: FontWeight.w400)),
                      SizedBox(
                        height: 20,
                      ),
                      GetMembersList(),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
