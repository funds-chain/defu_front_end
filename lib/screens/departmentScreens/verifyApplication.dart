import 'dart:convert';
import 'dart:io';

import 'package:defu_front_end/screens/departmentScreens/departmentDashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class VerifyApplication extends StatefulWidget {
  const VerifyApplication(
      {Key? key,
      required this.userType,
      required this.application,
      required this.depUser})
      : super(key: key);
  final Map depUser;
  final String userType;
  final Map application;
  @override
  State<VerifyApplication> createState() => _VerifyApplicationState();
}

class _VerifyApplicationState extends State<VerifyApplication> {
  List createMapList(Map mapname) {
    List tempList = [];
    for (String key in mapname.keys) {
      tempList.add(key);
    }
    return tempList;
  }

  Future<void> _download(String url) async {
    try {
      String message;
      // Download image
      final http.Response response = await http.get(Uri.parse(url));

      // Get temporary directory
      final dir = await getTemporaryDirectory();

      // Create an image name
      var filename = '${dir.path}/image.png';

      // Save to filesystem
      final file = File(filename);
      await file.writeAsBytes(response.bodyBytes);

      // Ask the user to save it
      final params = SaveFileDialogParams(sourceFilePath: file.path);
      final finalPath = await FlutterFileDialog.saveFile(params: params);

      if (finalPath != null) {
        message = 'Image saved to disk';
      }
    } catch (e) {
      print(e);
      print('An error occurred while saving the image');
    }
  }

  String stepKey = 'step1';

  Map formDataFinal = {};
  List verifiedSteps = [];
  List verifiedDocs = [];

  @override
  Widget build(BuildContext context) {
    Map userDetails = {
      'name': widget.application['user']['username'],
      'gender': "male",
      'age': "19"
    };
    final String dept = widget.application['scheme']['schemeCreatedBy'];
    final String schemeName = widget.application['scheme']['schemeName'];
    final String schemeDate =
        widget.application['scheme']['schemeStartDate'].substring(0, 10);
    final String applicationId = widget.application["_id"];
    final Map formdata = widget.application['scheme']['schemeFormMetaData'];
    List formKeys = createMapList(formdata);

    void enterToFinalFormData(String key, String value) {
      formDataFinal[key] = value;
      print(formDataFinal);
    }

    Future<http.Response> verifyApplication(String depUserId) async {
      return http.post(
        Uri.parse(
            'http://192.168.1.5:3000/appliedSchemes/verify/finishVerification'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(<String, dynamic>{
          "appliedSchemesId": widget.application["_id"],
          "userId": widget.application['user']['_id'],
          "schemeStatus": "approved",
          "schemeApprovedBy": depUserId,
          "schemeSanctionedAmount": widget.application['scheme']
              ['schemeSanctionedAmount']
        }),
      );
    }

    Color getStepColor(item) {
      if (verifiedSteps.contains(item)) {
        return Color.fromRGBO(114, 175, 16, 1);
      } else if (item == stepKey) {
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

    Color getDocColor(label) {
      if (verifiedDocs.contains(label)) {
        return Color.fromRGBO(114, 175, 16, 0.4);
      } else {
        return Colors.white;
      }
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
                        SizedBox(
                          height: 20,
                        ),
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
                            await _download(
                                widget.application['fileNames'][item['label']]);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: getDocColor(item[
                                  'label']), // Replace with your desired color
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/download.png',
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text('tap to download',
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(108, 108, 108, 1),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  verifiedDocs.add(item['label']);
                                });
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 15, 0, 15),
                                child: Text(
                                  'Accept Document',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromRGBO(114, 175, 16, 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  )),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  verifiedDocs.remove((item['label']));
                                });
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 15, 0, 15),
                                child: Text(
                                  'Reject Document',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromRGBO(255, 70, 70, 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  )),
                            )
                          ],
                        )
                      ],
                      if (item['type'] == "text") ...[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(item['label'],
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500)),
                            TextFormField(
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                hintText:
                                    widget.application['schemeFormFilledData']
                                        [item['label']],
                              ),
                              onChanged: (text) {
                                enterToFinalFormData(item['label'], text);
                              },
                              enabled: false,
                              initialValue:
                                  widget.application['schemeFormFilledData']
                                      [item['label']],
                            ),
                          ],
                        ),
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
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    verifiedSteps.add(stepKey);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: Text(
                    'Mark verified',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(114, 175, 16, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )),
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
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('Username',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(applicationId,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('Application ID',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ],
                        ),
                      ),
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
                                http.Response response =
                                    await verifyApplication(
                                        widget.depUser['_id']);
                                Map res = json.decode(response.body);
                                print(res);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DepartmentDashboard(
                                                userId: widget.depUser['_id'],
                                                deptName:
                                                    widget.application['scheme']
                                                        ['schemeCreatedBy'])));
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
                                  'Finish Verification',
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
