import 'package:flutter/material.dart';
import 'package:defu_front_end/Models/department_schemes_open.dart';

class DepartmentDashboard extends StatefulWidget {
  const DepartmentDashboard({Key? key}) : super(key: key);

  @override
  State<DepartmentDashboard> createState() => _DepartmentDashboardState();
}

class _DepartmentDashboardState extends State<DepartmentDashboard> {
  final String description1 = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque in imperdiet justo, sit amet viverra velit. Vestibulum eu neque vitae nibh commodo tristique. ';

  final List<department_Schemes_Open> openSchemes = [
    new department_Schemes_Open(applied: 1000, processing: 200, name: 'Scheme 1', byWhom: 'Government', description:'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque in imperdiet justo'),
    new department_Schemes_Open(applied: 1000, processing: 200, name: 'Scheme 2', byWhom: 'Government', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque in imperdiet justo, sit amet viverra velit. Vestibulum eu neque vitae nibh commodo tristique. '),
    new department_Schemes_Open(applied: 1000, processing: 200, name: 'Scheme 3', byWhom: 'Government', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque in imperdiet justo, sit amet viverra velit. Vestibulum eu neque vitae nibh commodo tristique. '),
    new department_Schemes_Open(applied: 1000, processing: 200, name: 'Scheme 4', byWhom: 'Government', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque in imperdiet justo, sit amet viverra velit. Vestibulum eu neque vitae nibh commodo tristique. '),
  ];

  final List<department_Schemes_Open> closedSchemes = [
    new department_Schemes_Open(applied: 1000, processing: 200, name: 'Scheme 1', byWhom: 'Government', description:'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque in imperdiet justo'),
    new department_Schemes_Open(applied: 1000, processing: 200, name: 'Scheme 2', byWhom: 'Government', description:'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque in imperdiet justo'),
    new department_Schemes_Open(applied: 1000, processing: 200, name: 'Scheme 3', byWhom: 'Government', description:'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque in imperdiet justo'),
    new department_Schemes_Open(applied: 1000, processing: 200, name: 'Scheme 4', byWhom: 'Government', description:'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque in imperdiet justo'),

  ];

  Widget SchemeBuilder(List<department_Schemes_Open> schemes){
    return ListView.builder(
      itemCount: schemes.length,
      itemBuilder: (context, index) {
        department_Schemes_Open scheme = schemes[index];
        return Card(
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
                        width: 80,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.account_circle_rounded,
                              color: Colors.green,
                            ),
                            Text(
                              '${scheme.applied}',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
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
                              '${scheme.processing}',
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(16),
                          primary: Colors.white,
                        ),
                        onPressed: () {
                          // Handle button press
                          print('Button pressed');
                        },
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
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
                                    children: [

                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '${scheme.name}',
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
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),


                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children:  [
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: 300,
                                  child: Text(
                                    '${scheme.description}',
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
                          ]
                      )
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

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
                                        'John Doe',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '#DoeJohn',
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
                      const Text(
                        'Schemes Open',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(height: 500,child: SchemeBuilder(openSchemes)),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  padding: const EdgeInsets.all(20),
                  color: const Color(0xffF2F2F7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Closed Schemes',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(height: 500,child: SchemeBuilder(closedSchemes)),
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
