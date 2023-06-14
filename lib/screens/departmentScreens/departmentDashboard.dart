import 'dart:convert';

import 'package:defu_front_end/screens/departmentScreens/createScheme.dart';
import 'package:defu_front_end/screens/departmentScreens/showUsersApplied.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DepartmentDashboard extends StatefulWidget {
  const DepartmentDashboard(
      {Key? key, required this.userId, required this.deptName})
      : super(key: key);

  final String userId;
  final String deptName;

  @override
  State<DepartmentDashboard> createState() => _DepartmentDashboardState();
}

class _DepartmentDashboardState extends State<DepartmentDashboard> {
  final String description1 =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque in imperdiet justo, sit amet viverra velit. Vestibulum eu neque vitae nibh commodo tristique. ';

  Widget SchemeBuilder(List schemes) {
    return ListView.builder(
      itemCount: schemes.length,
      itemBuilder: (context, index) {
        Map scheme = schemes[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          margin: EdgeInsets.all(8.0),
          child: Container(
            height: 300,
            color: Colors.black12,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 150,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.date_range,
                              color: Colors.green,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${scheme['schemeStartDate'].substring(0, 10)}',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: false,
                        child: Container(
                          width: 80,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.refresh_rounded,
                                color: Colors.redAccent,
                              ),
                              Text(
                                '${scheme['schemeName']}',
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(16),
                          primary: Colors.white,
                        ),
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             AppliedUsers(scheme: scheme)));
                        },
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/schema.png',
                                  height: 60,
                                  width: 60,
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xffF2F2F7),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '${scheme['schemeName']}',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${scheme['schemeName']}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: 300,
                                  child: Text(
                                    '${scheme['schemeName']}',
                                    style: TextStyle(
                                      color: Color(0xff131313),
                                      fontSize: 16,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ])),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Map user = {
    'mail': "NA",
    "username": "NA",
    "_id": "XXXXXXXXXX",
    "walletBalance": "XXXXXXXXXX"
  };

  List openSchemes = [
    {'schemeStartDate': 'xxxxxxxxxxxxxxx', 'schemeEndDate': 'xxxxxxxxxxxxxx'}
  ];
  List closedSchemes = [
    {"metadata": {}, "schemeAppliedDate": "xxxxxxxxxx"}
  ];

  Future<http.Response> getUserDetails(String id) async {
    return http.get(Uri.parse('http://192.168.1.5:3000/user/id/${id}'));
  }

  Future<http.Response> getSchemeDetails() async {
    return http.get(Uri.parse('http://192.168.1.5:3000/schemes'));
  }

  Future<http.Response> getSchemeDetailsSingle(String id) async {
    return http.get(Uri.parse('http://192.168.1.5:3000/schemes/${id}'));
  }

  Future<http.Response> getSchemeDetailsForUser(String id) async {
    return http
        .get(Uri.parse('http://192.168.1.5:3000/schemes/bydepartment/${id}'));
  }

  void getData(String id) async {
    http.Response response = await getUserDetails(id);
    Map res = json.decode(response.body);
    print(res);
    http.Response responseSchemes =
        await getSchemeDetailsForUser(widget.deptName);
    Map resSchemes = json.decode(responseSchemes.body);

    setState(() {
      user = res['data'];
      openSchemes = resSchemes['data'];
      closedSchemes = resSchemes['data'];
    });
    print(openSchemes);
  }

  @override
  Widget build(BuildContext context) {
    if (user['mail'] == "NA") {
      getData(widget.userId);
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu_rounded,
            size: 35,
            color: Color(0xff9747FF),
          ),
        ),
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.circle_notifications_outlined,
              size: 35,
              color: Color(0xff9747FF),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: const Color(0xffF2F2F7),
            child: Column(
              children: [
                Container(
                  height: 80,
                  color: Colors.black,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          Container(
                            height: 67,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: Center(
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.account_circle_outlined,
                                      size: 40,
                                      color: Color(0xff9747FF),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user['username'],
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        user['_id'].substring(0, 8),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Color(0xff939393)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.arrow_circle_right,
                                      size: 35,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.content_paste_search,
                              size: 25,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.folder,
                              size: 25,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/kcst.png',
                          height: 80,
                        ),
                        // SizedBox(
                        //   width: 20,
                        // ),
                        // Text(widget.deptName,
                        //     style: TextStyle(
                        //         fontSize: 18, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  color: const Color(0xffF2F2F7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 13,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Search for schemes',
                          // Add a clear button to the search bar
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {},
                          ),
                          // Add a search icon or button to the search bar
                          prefixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              // Perform the search here
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  color: const Color(0xffF2F2F7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Schemes Open',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreateScheme(
                                          deptName: widget.deptName)));
                            },
                            icon: const Icon(
                              Icons.add_circle_rounded,
                              size: 45,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 235,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: openSchemes.length,
                          itemBuilder: (BuildContext context, int index) {
                            Map scheme = openSchemes[index];
                            return GestureDetector(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 10, 0),
                                child: Container(
                                  height: 100,
                                  width: 350,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff1D4B8C),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            'Type - ${scheme["schemeType"]}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.arrow_forward_ios,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                        'assets/images/schema.png',
                                                        height: 60,
                                                        width: 60,
                                                      ),
                                                      const Spacer(),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: const Color(
                                                              0xffF2F2F7),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Apply By',
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xff8E8E8E),
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              '${scheme['schemeEndDate'].substring(0, 10)}',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        '${scheme['schemeName']}',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      SizedBox(
                                                        width: 190,
                                                        child: Text(
                                                          '${scheme['schemeCreatedBy']}',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xff131313),
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                ])),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShowUsersApplied(
                                              depUser: user,
                                              schemeId: scheme['_id'],
                                            )));
                              },
                            );
                          },
                        ),
                      ),
                      // Container(height: 500, child: SchemeBuilder(openSchemes)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // Container(
                //   padding: const EdgeInsets.all(20),
                //   color: const Color(0xffF2F2F7),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       const Text(
                //         'Closed Schemes',
                //         style: TextStyle(
                //             fontSize: 20,
                //             color: Colors.black,
                //             fontWeight: FontWeight.bold),
                //       ),
                //       const SizedBox(
                //         height: 10,
                //       ),
                //       Container(
                //           height: 500, child: SchemeBuilder(closedSchemes)),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
