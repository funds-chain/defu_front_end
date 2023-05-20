import 'package:defu_front_end/Models/appliedUsers.dart';
import 'package:flutter/material.dart';
import 'package:defu_front_end/Models/department_schemes_open.dart';


class AppliedUsers extends StatefulWidget {
  const AppliedUsers({Key? key,required this.scheme}) : super(key: key);
  final department_Schemes_Open scheme;

  @override
  State<AppliedUsers> createState() => _AppliedUsersState();
}

class _AppliedUsersState extends State<AppliedUsers> {
  @override

  List<UsersAppliedSchemes> Users = [
    new UsersAppliedSchemes(name: 'Name 1', id: 'Id 1', age: 30),
    new UsersAppliedSchemes(name: 'Name 2', id: 'Id 2', age: 30),
    new UsersAppliedSchemes(name: 'Name 3', id: 'Id 3', age: 30),
    new UsersAppliedSchemes(name: 'Name 4', id: 'Id 4', age: 30),
  ];

  Widget SchemeBuilder(){
    return ListView.builder(
      itemCount: Users.length,
      itemBuilder: (context, index) {
        UsersAppliedSchemes user = Users[index];
        return Card(
          margin: EdgeInsets.all(8.0),
          child: Container(
            height: 200,
            color: Colors.black12,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            '${user.id}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('Application ID',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                          ),
                          )
                        ],
                      ),
                      Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text('23 Oct 2023',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),),
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
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '${user.name}',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight:
                                              FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(width: 120,),
                                          Container(
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.blueAccent,
                                              borderRadius: BorderRadius.circular(12.0),
                                            ),
                                            child: TextButton(
                                              onPressed: (){},
                                              child: Text('Verify Application',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  '${user.age}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
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

    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 35,
              color: Color(0xff9747FF),
            ),
          ),
          title: const Text('Dashboard',
          style: TextStyle(
            fontSize: 24,
          ),),
          actions: [
            Container(
              height: 10,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: TextButton(
                onPressed: (){},
                child: Text('Disable Scheme',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 16,
                  ),
                ),
              ),
            )
          ],
        ),

        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image(
                      image: AssetImage('assets/images/schema.png')
                  ),
                  Text('Department',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Text('${widget.scheme.name}',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold
                ),
              ),
              Text('23 March 2023',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                ),
              ),
              SizedBox(height: 15,),
              SingleChildScrollView(
                child: Text('${widget.scheme.description}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400
                ),
                ),
              ),
              SizedBox(height: 20,),
              Text('Applications Received',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22
                ),
              ),
              Container(
                  height: 400,
                  child: SchemeBuilder()),
            ],
          ),
        ),
      );
  }
}


