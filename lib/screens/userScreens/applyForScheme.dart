import 'package:flutter/material.dart';

class ApplyForScheme extends StatefulWidget {
  const ApplyForScheme({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {

    final String dept = 'Karnataka State Council \nfor Science and Technology';
    final String schemeName = 'KSCST : Rainwater Harvesting \n(RWH) : Karnataka';
    final String schemeDate = '23 Mar 2018';
    final Map formdata = {
      'step1': {
        'header': 'Fill the following Details',
        'form': [
          {
            'label': 'Temp name',
            'type': 'text'
          },
          {
            'label': 'Temp name',
            'type': 'text'
          },
          {
            'label': 'Temp name',
            'type': 'text'
          },
        ]
      },
      'step2': {
      'header': 'Fill the following Details',
      'form': [
        {
          'label': 'Temp name',
          'type': 'text'
        },
        {
          'label': 'Temp name',
          'type': 'text'
        },
        {
          'label': 'Temp name',
          'type': 'text'
        },
        {
          'label': 'Temp name',
          'type': 'text'
        },
        {
          'label': 'Temp2 name',
          'type': 'text'
        },
        {
          'label': 'Temp3 name',
          'type': 'text'
        },
      ]
    }
    };
    List formKeys = createMapList(formdata);
    
    Color getStepColor(item){
      if(item == stepKey){
        return Color.fromRGBO(61, 137, 245, 1);
      } return Color.fromRGBO(201, 201, 201, 1);
    }

    Widget GetStepsWidget(List keys){
      return new Row(
        children: keys.map((item) =>
          new TextButton(onPressed: (){
            setState(() {
              stepKey = item;
              print(stepKey);
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

    Widget GetInnerFormWidget(List items){
      return new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.map((item) =>
          new Column(children: [
            TextFormField(
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintText: item['label'],
              ),
            ),
            SizedBox(height: 10,),
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
                      GetStepsWidget(formKeys),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    if(formdata.containsKey(stepKey))...[
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
