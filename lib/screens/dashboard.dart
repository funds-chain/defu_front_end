import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  @override
  Widget build(BuildContext context) {
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'Adithya P K',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '#123Adiu',
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
                            const Text(
                              '\u{20B9}${45000.00}',
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
                        'Schemes for you',
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
                          itemCount: entries.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
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
                                        const Text(
                                          'Students Only',
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
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
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
                                                padding: const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: const Color(0xffF2F2F7),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: const [
                                                    Text(
                                                      'Apply By',
                                                      style: TextStyle(
                                                        color: Color(0xff8E8E8E),
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      '22 Oct 2023',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: const [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Post-Matric Scholarship',
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
                                            children: const [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              SizedBox(
                                                width: 190,
                                                child: Text(
                                                  'gfvnoervuibn Lorem ipsum biouef iosdfnde gfvnoervuibn Lorem ipsum biouef iosdfnde',
                                                  style: TextStyle(
                                                    color: Color(0xff131313),
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
                            );
                          },
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
