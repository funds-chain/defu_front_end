import 'dart:convert';
import 'dart:io';

import 'package:defu_front_end/screens/userScreens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ApplyForScheme extends StatefulWidget {
  const ApplyForScheme(
      {Key? key,
      required this.disabled,
      required this.schemeId,
      required this.userId})
      : super(key: key);
  final String schemeId;
  final String userId;
  final bool disabled;
  @override
  State<ApplyForScheme> createState() => _ApplyForSchemeState();
}

class _ApplyForSchemeState extends State<ApplyForScheme> {
  List createMapList(Map mapname) {
    List tempList = [];
    for (String key in mapname.keys) {
      tempList.add(key);
    }
    return tempList;
  }

  String stepKey = 'step1';

  Map formDataFinal = {
    "files": [],
  };

  Map scheme = {
    "_id": "NA",
    "schemeName": "STUDENT PROJECT PROGRAMME",
    "schemeImage": "Untitled Scheme",
    "schemeCategory": "Student Only",
    "schemeType": "Funding",
    "schemeStartDate": "2022-05-28T00:00:00.000Z",
    "schemeEndDate": "2023-03-05T00:00:00.000Z",
    "schemeStatus": "Active",
    "schemeCreatedBy": "KSCST",
    "schemeFileNames": {"undefined": "1685645350869-305248245-kscst.jpeg"},
    "createdAt": "2023-06-01T18:49:10.910Z",
    "updatedAt": "2023-06-01T18:49:10.910Z",
    "schemeDescription": "",
    "schemeFileNames": {"undefined": ""},
    "schemeFormMetaData": {}
  };

  @override
  Widget build(BuildContext context) {
    final String dept = "Karnataka State Council for\nScience and Technology";
    final String schemeName =
        "${scheme["schemeCreatedBy"]}: ${scheme["schemeName"]}";
    final String schemeDate = scheme["schemeStartDate"].substring(0, 10);

    Future<http.Response> getSchemeDetails(String id) async {
      return http.get(Uri.parse('http://192.168.1.5:3000/schemes/${id}'));
    }

    void getData() async {
      http.Response response = await getSchemeDetails(widget.schemeId);
      Map res = json.decode(response.body);
      setState(() {
        scheme = res['data'];
      });
    }

    Future<Map<String, dynamic>> applyScheme(
        dynamic data, List<dynamic> files) async {
      //create multipart request for POST or PATCH method
      var request = http.MultipartRequest(
          "POST", Uri.parse("http://192.168.1.5:3000/appliedSchemes"));
      //add text fields
      request.fields["schemeId"] = data["schemeId"];
      request.fields["userId"] = data["userId"];
      request.fields["schemeFormFilledData"] =
          json.encode(data["schemeFormFilledData"]);
      List fileNames = [];
      //create multipart using filepath, string or bytes
      print(files);
      for (var i = 0; i < files.length; i++) {
        var pic =
            await http.MultipartFile.fromPath("files", files[i]['_file'].path);
        request.files.add(pic);
        fileNames.add(files[i]['_key']);
      }
      request.fields["fileNames"] = json.encode(fileNames);
      var response = await request.send();
      //Get the response from the server
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      return json.decode(responseString);
      // return responseString;
    }

    if (scheme['_id'] == "NA") {
      getData();
    }

    Map formdata = scheme["schemeFormMetaData"];
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
      return new Row(
        children: keys
            .map((item) => new TextButton(
                onPressed: () {
                  setState(() {
                    stepKey = item;
                    formDataFinal = formDataFinal;
                  });
                },
                child: Text(item,
                    style: TextStyle(
                        color: getStepColor(item),
                        fontSize: 18,
                        fontWeight: FontWeight.w500))))
            .toList(),
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
                              formDataFinal['files'].add(
                                  {"_key": item['label'], "_file": imageFile});
                              setState(() {
                                stepKey = stepKey;
                                formDataFinal = formDataFinal;
                              });
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
                        if (widget.disabled) ...[
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
                            enabled: false,
                            initialValue: item['type'],
                          ),
                        ],
                        if (!widget.disabled) ...[
                          TextFormField(
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              hintText: item['label'],
                            ),
                            initialValue: formDataFinal[item['label']],
                            onChanged: (text) {
                              enterToFinalFormData(item['label'], text);
                            },
                          ),
                        ],
                        SizedBox(
                          height: 10,
                        ),
                      ]
                    ],
                  ))
              .toList());
    }

    Widget GetOuterFormWidget(Map item) {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: TextButton(
                  onPressed: () {
                    String item = "";
                    for (var i = 0; i < formKeys.length; i++) {
                      if (formKeys[i] == stepKey) {
                        item = formKeys[i + 1];
                      }
                    }
                    setState(() {
                      stepKey = item;
                      formDataFinal = formDataFinal;
                    });
                  },
                  child: Text(
                    'next step',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
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
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          title: Text('Apply For Scheme'),
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
                      Container(
                        child: Row(
                          children: [
                            Image.network(
                              scheme['schemeFileNames']["undefined"],
                              height: 80,
                              width: 100,
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
                              onPressed: () async {
                                List files = formDataFinal['files'];
                                formDataFinal['files'] = [];
                                Map resData = {
                                  "schemeId": widget.schemeId,
                                  "userId": widget.userId,
                                  "schemeFormFilledData": formDataFinal
                                };
                                dynamic res = await applyScheme(resData, files);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DashboardScreen(
                                              userId: widget.userId,
                                            )));
                                Fluttertoast.showToast(
                                    msg: res["message"],
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 8,
                                    backgroundColor:
                                        Color.fromRGBO(114, 175, 16, 1),
                                    textColor: Colors.white,
                                    fontSize: 24.0);
                              },
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
