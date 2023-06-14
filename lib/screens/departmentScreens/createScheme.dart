import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class CreateScheme extends StatefulWidget {
  const CreateScheme({Key? key, required this.deptName}) : super(key: key);
  final String deptName;

  @override
  State<CreateScheme> createState() => _CreateSchemeState();
}

class _CreateSchemeState extends State<CreateScheme> {
  List createMapList(Map mapname) {
    List tempList = [];
    for (String key in mapname.keys) {
      tempList.add(key);
    }
    return tempList;
  }

  String stepKey = 'Basic Details';

  Map formDataFinal = {};
  List members = [
    {
      "_id": "xxxxxxxxxxxxxxxxxxxxx",
      "username": "NA",
      "mail": "ananthreddy@tempmail.com",
      "password": '2b105VOtGLQaCDDYyZDxzW3VIOhY4IVeNuFCNJZuX/09S7rtzUDk2oOzC',
      "role": "NA",
      "walletPin": "",
      "walletBalance": 0,
      "dateOfBirth": null,
      "departmentId": "ca614c21-a268-4cd8-954c-c2a84e864437",
      "__v": 0
    }
  ];

  Map formdata = {
    'Basic Details': {
      'header': 'Enter Basic Details of Scheme',
      'form': [
        {'label': 'Scheme Name', 'type': 'text'},
        {'label': 'Scheme Funding Value', 'type': 'text'},
        {'label': 'Scheme Description', 'type': 'text'},
      ]
    },
    'step1': {'header': "", 'form': []},
    'Add New Step': {},
  };

  List assignedMembers = [];

  Future<http.Response> getMembers(String dept_name) async {
    return http.get(Uri.parse(
        'http://192.168.1.5:3000/user/getDepartmentUser/${dept_name}'));
  }

  Future<http.Response> createScheme() async {
    Map resForm = formdata;
    resForm.remove("Add New Step");
    resForm.remove("Basic Details");
    resForm['Ack'] = {
      'header': 'I Acknowledge the terms and Conditions',
      'body':
          "There were 16 NAM countries participating and 17 foreign participants in the programme. There were 9 Indian participants from various states of India. The training programme focused on rainwater harvesting, ground water recharge from buildings, apartments, office complexes, corporate sectors, companies and various institutions. Open spaces both in urban and rural areas along with watershed management in farm sector was also covered. The training programme was supported by 22 resource persons from various institutions and different parts of India with 24 technical presentations. There were five Technical sessions covering the following topics: 1. Need for Rainwater Harvesting 2. Resource estimation 3. Methods of rainwater harvesting a) Harvesting, recharge, conservation b) Rainwater harvesting from roof tops and open spaces 4. Resource - water quality and effects (health, land, water source etc.) 5. Details of Rainwater harvesting roof tops and open spaces – design, plan, cost estimation etc. 6. Rainwater harvesting in small farms / agricultural fields 7. Conservation and artificial recharge, design, plan, cost estimation etc. 8. Ground water recharge - open space, dug wells, tube wells, trenches, farm ponds etc. There were two field visits for practical exposure on Rainwater Harvesting and Ground water recharge. The first one was in Bangalore to practically demonstrate rainwater harvesting at different sectors."
    };
    return http.post(
      Uri.parse('http://192.168.1.5:3000/schemes/createScheme'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(<String, dynamic>{
        'schemeName': formDataFinal['Scheme Name'],
        'schemeDescription': formDataFinal['Scheme Description'],
        'schemeSanctionedAmount': formDataFinal['Scheme Funding Value'],
        'schemeType': "Funding",
        "schemeCategory": "Student Only",
        'schemeCreatedBy': widget.deptName,
        'schemeFormMetaData': json.encode(resForm)
      }),
    );
  }

  void getData() async {
    http.Response response = await getMembers(widget.deptName);
    Map res = json.decode(response.body);

    setState(() {
      members = res['data'];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (members[0]['username'] == 'NA') {
      getData();
    }
    List formKeys = createMapList(formdata);

    void enterToFinalFormData(String key, String value) {
      formDataFinal[key] = value;
    }

    Color getStepColor(item) {
      if (item == stepKey) {
        return Color.fromRGBO(61, 137, 245, 1);
      }
      return Color.fromRGBO(201, 201, 201, 1);
    }

    Widget GetStepsWidget(List keys) {
      return new SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: keys
              .map((item) => new Row(
                    children: [
                      if (item == "Add New Step") ...[
                        ElevatedButton(
                          onPressed: () {
                            Map temp = formdata;
                            formdata.remove('Add New Step');
                            formdata['step${formKeys.length - 1}'] = {
                              'header': "",
                              'form': []
                            };
                            formdata['Add New Step'] = {};
                            setState(() {
                              formdata = temp;
                            });
                          },
                          child: Text(
                            'Add New Step',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromRGBO(61, 137, 245, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              )),
                        ),
                      ],
                      if (item != "Add New Step") ...[
                        new TextButton(
                            onPressed: () {
                              setState(() {
                                stepKey = item;
                                formdata = formdata;
                              });
                            },
                            child: Text(item,
                                style: TextStyle(
                                    color: getStepColor(item),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500)))
                      ]
                    ],
                  ))
              .toList(),
        ),
      );
    }

    Widget GetInnerFormWidget(List items) {
      return new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items
              .map((item) => new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (item['type'] == "file") ...[
                        Text(item['label'],
                            style: TextStyle(
                                color: Color.fromRGBO(108, 108, 108, 1),
                                fontSize: 14,
                                fontWeight: FontWeight.w500)),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () async {
                            final XFile? pickedFile =
                                await ImagePicker().pickImage(
                              source: ImageSource.gallery,
                              maxWidth: 1800,
                              maxHeight: 1800,
                            );
                            if (pickedFile != null) {
                              File imageFile = File(pickedFile.path);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors
                                  .white, // Replace with your desired color
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/upload.png',
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text('Upload file (size less than 4mb)',
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(108, 108, 108, 1),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                      if (item['type'] == "text") ...[
                        TextFormField(
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            hintText: item['label'],
                          ),
                          onChanged: (text) {
                            enterToFinalFormData(item['label'], text);
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ]
                    ],
                  ))
              .toList());
    }

    Widget GetMembersList() {
      return new Column(
        children: members
            .map((member) => new Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromRGBO(226, 226, 226,
                            1), // Replace with your desired color
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Text(member['_id'].substring(0, 12),
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500)),
                                    Text('User ID',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500)),
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    member['role'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
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
                                    Text(member['username'],
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500)),
                                    if (assignedMembers
                                        .contains(member['_id'])) ...[
                                      ElevatedButton(
                                        onPressed: () {
                                          assignedMembers.remove(member['_id']);
                                          setState(() {
                                            members = members;
                                            assignedMembers = assignedMembers;
                                          });
                                        },
                                        child: Text(
                                          'Remove',
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
                                    if (!(assignedMembers
                                        .contains(member['_id']))) ...[
                                      ElevatedButton(
                                        onPressed: () {
                                          assignedMembers.add(member['_id']);
                                          setState(() {
                                            members = members;
                                            assignedMembers = assignedMembers;
                                          });
                                        },
                                        child: Text(
                                          'Assign',
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

    Widget GetAssignVerificationOffer() {
      return new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Assign Verification Officers',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          SizedBox(
            height: 20,
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Search for Members',
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
          SizedBox(
            height: 20,
          ),
          GetMembersList()
        ],
      );
    }

    Widget GetFormFieldsInput(List items) {
      print(items);
      return new Column(
        children: items
            .asMap()
            .entries
            .map((item) => new Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white, // Replace with your desired color
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Text('Form Field',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500)),
                                ElevatedButton(
                                  onPressed: () {
                                    Map temp = formdata;
                                    temp[stepKey]['form'].removeAt(item.key);
                                    setState(() {
                                      stepKey = stepKey;
                                      formdata = formdata;
                                    });
                                  },
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      primary: Color.fromRGBO(247, 37, 37, 1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
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
                              height: 60,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(242, 242, 247, 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: TextFormField(
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: item.value['label'],
                                  ),
                                  onChanged: (text) {
                                    formdata[stepKey]['form'][item.key]
                                        ['label'] = text;
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(242, 242, 247, 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: DropdownMenu(
                                    initialSelection: item.value['type'],
                                    onSelected: (value) {
                                      formdata[stepKey]['form'][item.key]
                                          ['type'] = value;
                                    },
                                    dropdownMenuEntries: [
                                      DropdownMenuEntry(
                                          value: 'text', label: 'Plain Text'),
                                      DropdownMenuEntry(
                                          value: 'file', label: 'Upload File')
                                    ],
                                  )),
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

    Widget GetOuterFormWidget(Map item) {
      if (stepKey.contains("step")) {
        return new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Create Form To Be Filled',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintText: "Enter header to the step",
              ),
              onChanged: (text) {
                formdata[stepKey]['header'] = text;
                setState(() {
                  formdata = formdata;
                  formDataFinal = formDataFinal;
                  stepKey = stepKey;
                  members = members;
                  assignedMembers = assignedMembers;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            GetFormFieldsInput(item['form']),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Map temp = formdata;
                    temp[stepKey]['form']
                        .add({'label': 'field name', 'type': 'text'});
                    setState(() {
                      stepKey = stepKey;
                      formdata = formdata;
                    });
                  },
                  child: Text(
                    'Add New Field',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(61, 137, 245, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      )),
                ),
              ],
            ),
          ],
        );
      } else if (stepKey == "Basic Details") {
        return new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item['header'],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            SizedBox(
              height: 20,
            ),
            GetInnerFormWidget(item['form']),
            SizedBox(
              height: 20,
            ),
            GetAssignVerificationOffer()
          ],
        );
      } else {
        return new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item['header'],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            SizedBox(
              height: 20,
            ),
            GetInnerFormWidget(item['form']),
          ],
        );
      }
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(71),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          leadingWidth: double.infinity,
          leading: TextButton(
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  'Create Scheme',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    http.Response response = await createScheme();
                    Map res = json.decode(response.body);
                    print(res);
                    Navigator.pop(context);
                    Fluttertoast.showToast(
                        msg: res["message"],
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 8,
                        backgroundColor: Color.fromRGBO(114, 175, 16, 1),
                        textColor: Colors.white,
                        fontSize: 24.0);
                  },
                  child: Text(
                    'Create',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(114, 175, 16, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // Replace with your desired color
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GetStepsWidget(formKeys),
                    ],
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      if (formdata.containsKey(stepKey) &&
                          stepKey == "Ack") ...[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(formdata['Ack']['header'],
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: 20,
                            ),
                            Text(formdata['Ack']['body'],
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400)),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 15, 0, 15),
                                child: Text(
                                  'Confirm Submission',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromRGBO(114, 175, 16, 1),
                                  minimumSize: const Size.fromHeight(50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  )),
                            ),
                          ],
                        )
                      ],
                      if (formdata.containsKey(stepKey) &&
                          stepKey != "Ack") ...[
                        GetOuterFormWidget(formdata[stepKey]),
                      ]
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
