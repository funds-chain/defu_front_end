import 'dart:convert';

import 'package:defu_front_end/Models/NewSchemes.dart';
import 'package:defu_front_end/Models/Schemes.dart';
import 'package:defu_front_end/screens/userScreens/appliedScheme.dart';
import 'package:defu_front_end/screens/userScreens/applyForScheme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key, required this.userId}) : super(key: key);

  final String userId;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Schemes> previouslyAppliedSchemes = [
    new Schemes(1, 'Scheme1', 'Department1'),
    new Schemes(2, 'Scheme2', 'Department2'),
    new Schemes(3, 'Scheme3', 'Department3')
  ];

  final List<NewSchemes> newSchemes = [
    new NewSchemes(0, 'New Scheme1', 'Department1', 'Students Only',
        DateTime(2023, 10, 22)),
    new NewSchemes(0, 'New Scheme2', 'Department2', 'Students Only',
        DateTime(2023, 10, 22)),
    new NewSchemes(0, 'New Scheme3', 'Department3', 'Students Only,',
        DateTime(2023, 10, 22)),
  ];

  String schemeStatus(int id) {
    switch (id) {
      case 0:
        return 'Apply';
      case 1:
        return 'Submitted';
      case 2:
        return 'Accepted';
      default:
        return 'Rejected';
    }
  }

  Color schemeStatusColor(int id) {
    switch (id) {
      case 0:
        return Colors.white;
      case 1:
        return Colors.yellow;
      case 2:
        return Colors.green;
      default:
        return Colors.red;
    }
  }

  Map user = {
    'mail': "NA",
    "username": "NA",
    "_id": "XXXXXXXXXX",
    "walletBalance": "XXXXXXXXXX"
  };
  List exploreSchemes = [];
  List appliedSchemes = [
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
        .get(Uri.parse('http://192.168.1.5:3000/appliedSchemesByUser/${id}'));
  }

  void getData(String id) async {
    http.Response response = await getUserDetails(id);
    Map res = json.decode(response.body);

    http.Response responseSchemes = await getSchemeDetails();
    Map resSchemes = json.decode(responseSchemes.body);

    http.Response responseSchemesApplied = await getSchemeDetailsForUser(id);
    Map resSchemesApplied = json.decode(responseSchemesApplied.body);

    for (var i = 0; i < resSchemesApplied['data'].length; i++) {
      print(resSchemesApplied['data'][i]['_id']);
      http.Response response = await getSchemeDetailsSingle(
          resSchemesApplied['data'][i]['schemeId']);
      Map responseSchemes = json.decode(response.body);
      resSchemesApplied['data'][i]['metadata'] = responseSchemes['data'];
    }

    setState(() {
      user = res['data'];
      exploreSchemes = resSchemes['data'];
      appliedSchemes = resSchemesApplied['data'];
    });
    print(appliedSchemes);
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
                                          fontSize: 24,
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
                                    width: 50,
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
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  color: const Color(0xffF2F2F7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 13,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft,
                            colors: [
                              Color(0xff1C4A8B),
                              Color(0xffF72585),
                            ],
                            stops: [0.5, 0.9],
                          ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 24,
                            ),
                            Row(
                              children: [
                                const Text(
                                  'My Wallet',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.more_horiz,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Wallet Balance',
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xffCACACA)),
                            ),
                            Text(
                              '\u{20B9}${user['walletBalance']}',
                              style: TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'Recent Updates',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Search for your applied schemes',
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
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  color: const Color(0xffF2F2F7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Explore Schemes',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 235,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: exploreSchemes.length,
                          itemBuilder: (BuildContext context, int index) {
                            Map scheme = exploreSchemes[index];
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
                                            '${scheme["schemeCategory"]}',
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
                                        padding: const EdgeInsets.all(15.0),
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
                                      builder: (context) => ApplyForScheme(
                                          schemeId: scheme['_id'],
                                          disabled: false,
                                          userId: user['_id'])),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Previously applied Schemes',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 235,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: appliedSchemes.length,
                          itemBuilder: (BuildContext context, int index) {
                            Map scheme = appliedSchemes[index];
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
                                            '${scheme["schemeStatus"]}',
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
                                        padding: const EdgeInsets.all(15.0),
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
                                                              '${scheme['schemeAppliedDate'].substring(0, 10)}',
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
                                                        '${scheme['metadata']['schemeName']}',
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
                                                          '${scheme['metadata']['schemeCreatedBy']}',
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
                                      builder: (context) => ApplyForScheme(
                                          schemeId: scheme['_id'],
                                          disabled: false,
                                          userId: user['_id'])),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      Visibility(
                        visible: false,
                        child: SizedBox(
                          height: 225,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: previouslyAppliedSchemes.length,
                            itemBuilder: (BuildContext context, int index) {
                              Schemes scheme = previouslyAppliedSchemes[index];
                              return GestureDetector(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 10, 0),
                                  child: Container(
                                    height: 100,
                                    width: 200,
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
                                              '${schemeStatus(scheme.status)}',
                                              style: TextStyle(
                                                  color: schemeStatusColor(
                                                      scheme.status),
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
                                        Container(
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
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xffF2F2F7),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text('${scheme.name}')
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
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
                                                  Text(
                                                    '${scheme.name}',
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
                                                      '${scheme.department}',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xff131313),
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AppliedScheme(scheme: scheme)));
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
