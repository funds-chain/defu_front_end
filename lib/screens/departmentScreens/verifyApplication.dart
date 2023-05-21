

import 'package:flutter/material.dart';

class VerifyApplication extends StatefulWidget {
  const VerifyApplication({Key? key, required this.userType}) : super(key: key);
  final String userType;
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
  String stepKey = 'step1';

  Map formDataFinal = {};
  List verifiedSteps = [];
  List verifiedDocs = [];

  Map userDetails = {
    'name': "Aditya PK",
    'gender': "male",
    'age': "19"
  };

  @override
  Widget build(BuildContext context) {

    final String dept = 'Karnataka State Council \nfor Science and Technology';
    final String schemeName = 'KSCST : Rainwater Harvesting \n(RWH) : Karnataka';
    final String schemeDate = '23 Mar 2018';
    final String applicationId = 'IUVBEFIOAB876UB';
    final Map formdata = {
      'step1': {
        'header': 'Fill the following Details',
        'form': [
          {
            'label': 'Temp name1',
            'type': 'text'
          },
          {
            'label': 'Temp name2',
            'type': 'text'
          },
          {
            'label': 'Temp name3',
            'type': 'file',
            'status': 'pending',
          },
        ]
      },
      'step2': {
        'header': 'Fill the following Details',
        'form': [
          {
            'label': 'Temp name4',
            'type': 'text'
          },
          {
            'label': 'Temp name5',
            'type': 'text'
          },
          {
            'label': 'Temp name6',
            'type': 'text'
          },
          {
            'label': 'Temp name7',
            'type': 'text'
          },
          {
            'label': 'Temp2 name8',
            'type': 'text'
          },
          {
            'label': 'Temp3 name9',
            'type': 'text'
          },
        ]
      },
      'Ack': {
        'header': 'I Acknowledge the terms and Conditions',
        'body': "There were 16 NAM countries participating and 17 foreign participants in the programme. There were 9 Indian participants from various states of India. The training programme focused on rainwater harvesting, ground water recharge from buildings, apartments, office complexes, corporate sectors, companies and various institutions. Open spaces both in urban and rural areas along with watershed management in farm sector was also covered. The training programme was supported by 22 resource persons from various institutions and different parts of India with 24 technical presentations. There were five Technical sessions covering the following topics: 1. Need for Rainwater Harvesting 2. Resource estimation 3. Methods of rainwater harvesting a) Harvesting, recharge, conservation b) Rainwater harvesting from roof tops and open spaces 4. Resource - water quality and effects (health, land, water source etc.) 5. Details of Rainwater harvesting roof tops and open spaces – design, plan, cost estimation etc. 6. Rainwater harvesting in small farms / agricultural fields 7. Conservation and artificial recharge, design, plan, cost estimation etc. 8. Ground water recharge - open space, dug wells, tube wells, trenches, farm ponds etc. There were two field visits for practical exposure on Rainwater Harvesting and Ground water recharge. The first one was in Bangalore to practically demonstrate rainwater harvesting at different sectors."
      }
    };
    List formKeys = createMapList(formdata);

    void enterToFinalFormData(String key, String value){
      formDataFinal[key] = value;
      print(formDataFinal);
    }

    Color getStepColor(item){
      if(verifiedSteps.contains(item)){
        return Color.fromRGBO(114, 175, 16, 1);
      }
      else if(item == stepKey){
        return Color.fromRGBO(61, 137, 245, 1);
      } return Color.fromRGBO(201, 201, 201, 1);
    }

    Widget GetStepsWidget(List keys){
      return new Row(
        children: keys.map((item) =>
        new TextButton(onPressed: (){
          setState(() {
            stepKey = item;
            formDataFinal=formDataFinal;
          });
        }, child: Text(item,
            style: TextStyle(
                color: getStepColor(item),
                fontSize: 18,
                fontWeight: FontWeight.w500
            )))
        ).toList(),
      );
    }

    Color getDocColor(label){
      if(verifiedDocs.contains(label)){
        return Color.fromRGBO(114, 175, 16, 0.4);
      }else{
        return Colors.white;
      }
    }

    Widget GetInnerFormWidget(List items){
      return new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items.map((item) =>
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if(item['type'] == "file")...[
                SizedBox(height: 20,),
                Text(item['label'],
                    style: TextStyle(
                        color: Color.fromRGBO(108, 108, 108, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                    )),
                SizedBox(height: 10,),
                InkWell(
                  onTap: () async {
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: getDocColor(item['label']), // Replace with your desired color
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/download.png',

                          ),
                          SizedBox(width: 20,),
                          Text('tap to download',
                              style: TextStyle(
                                  color: Color.fromRGBO(108, 108, 108, 1),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment:MainAxisAlignment.start,
                  children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        verifiedDocs.add(item['label']);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
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
                    SizedBox(width: 20,),
                  ElevatedButton(
                    onPressed: () {
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
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
                ],)
              ],
              if(item['type'] == "text")...[
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
                SizedBox(height: 10,),
              ]
            ],)
          ).toList()
      );
    }

    Widget GetOuterFormWidget(Map item){
      return new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item['header'],
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500
              )),
          SizedBox(height: 20,),
          GetInnerFormWidget(item['form']),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [ElevatedButton(
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
          ),],)
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
                      GetStepsWidget(formKeys),
                    ],
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      if(formdata.containsKey(stepKey) && stepKey == "Ack")...[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(formdata['Ack']['header'],
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                )),
                            SizedBox(height: 20,),
                            Text(formdata['Ack']['body'],
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400
                                )),
                            SizedBox(height: 20,),
                            ElevatedButton(
                              onPressed: () {},
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
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
                      if(formdata.containsKey(stepKey) && stepKey != "Ack")...[
                        GetOuterFormWidget(formdata[stepKey]),
                      ]
                    ],
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
