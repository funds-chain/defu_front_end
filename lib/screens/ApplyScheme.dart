import 'package:flutter/material.dart';
import 'package:defu_front_end/Models/NewSchemes.dart';

class ApplyScheme extends StatelessWidget {
  final NewSchemes scheme;
  final String description = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque in imperdiet justo, sit amet viverra velit. Vestibulum eu neque vitae nibh commodo tristique. Sed vel augue et nisl pulvinar vestibulum. Pellentesque augue turpis, pretium a placerat in, porta facilisis justo. Vestibulum ut risus nibh. Vivamus ut neque dictum dui feugiat sodales a eget arcu. Vivamus blandit nulla elit, non molestie massa tincidunt et.Phasellus efficitur purus nec felis vulputate, sed cursus elit auctor. Nam non consectetur magna, non semper purus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Morbi et elit id turpis euismod lacinia ut sit amet justo. Sed felis velit, efficitur quis tortor vitae, egestas interdum nulla. Quisque quis mi est. Suspendisse convallis ipsum tortor, vitae volutpat libero posuere at. Nullam suscipit congue risus, at malesuada enim efficitur id. Vestibulum iaculis, est a cursus porttitor, risus arcu blandit lorem, nec volutpat lacus turpis et nibh. Aenean consequat pharetra facilisis. Sed nunc quam, sollicitudin id fringilla non, bibendum blandit nulla. Proin blandit blandit bibendum.Etiam et purus sollicitudin, fermentum enim sed, vulputate erat. Cras malesuada metus magna, quis gravida dolor scelerisque quis. Nulla facilisi. Mauris a scelerisque diam. Praesent consequat aliquam neque eu tempus. Phasellus enim sapien, iaculis sit amet lacinia eu, pretium eget arcu. Sed sed lectus lacus. Praesent et lectus sem. Mauris in mollis sem. Sed quis nibh et ex vestibulum aliquam. Vivamus facilisis magna sem, eget efficitur nunc interdum id. Sed lacinia ante nec orci tincidunt, vitae commodo ligula tristique. Maecenas laoreet augue non commodo volutpat. Fusce aliquam ex a commodo consectetur. Nulla gravida ante dolor, commodo vehicula odio sodales et. Praesent non erat sollicitudin, vulputate dolor a, tincidunt ipsum.Nam porttitor commodo arcu, vel viverra erat consequat id. Aenean euismod nisl vel tellus lacinia consectetur. Sed nibh nunc, suscipit volutpat augue tincidunt, congue tempus tortor. Sed urna nulla, facilisis et pulvinar non, cursus at ante. Vivamus in consectetur leo. Nam mollis ac dui sit amet fringilla. Etiam faucibus convallis sem, a hendrerit sem dictum a. Donec sodales eros non nisl pulvinar porta. Vestibulum nec rutrum ligula. Phasellus rhoncus pellentesque ipsum, eget placerat leo auctor non. Quisque pharetra neque ut ultrices blandit. Curabitur pretium magna in libero imperdiet, in mattis quam scelerisque. Vestibulum scelerisque bibendum leo. Phasellus vestibulum nisl sed nulla dictum, vel accumsan tortor finibus. Aenean porttitor nec dui at condimentum. Sed lobortis nunc a lorem ornare, ultricies luctus lorem interdum.Duis molestie sagittis lectus a posuere. Aenean facilisis nunc mattis, fringilla sem eget, pretium libero. Proin vel lectus sed risus tincidunt maximus. Maecenas et pulvinar dui, at consectetur orci. Cras facilisis varius neque, ut venenatis purus sollicitudin ac. Nulla facilisi. Vestibulum mattis varius mauris et maximus. Duis sit amet feugiat lacus, nec viverra nunc. Pellentesque pellentesque, enim eget ullamcorper gravida, lectus turpis pulvinar lorem, vitae maximus dui arcu ac tortor.';
  ApplyScheme({required this.scheme});

  String schemeStatus(int id){
    switch(id){
      case 0: return 'Apply';
      case 1: return 'Submitted';
      case 2: return 'Accepted';
      default: return 'Rejected';
    }
  }

  Color schemeStatusColor(int id){
    switch(id){
      case 0: return Colors.blueAccent;
      case 1: return Colors.yellow;
      case 2: return Colors.green;
      default: return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: AppBar(
          elevation: 2,
          backgroundColor: Colors.black,
          leading: Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black, // Replace with your desired color
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white, // Replace with your desired color
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          actions: [
            ClipRRect(
              child: TextButton(
                onPressed: () {
                  // Handle button press
                  print('Applied button pressed');
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0), // Adjust the value as needed
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(schemeStatusColor(scheme.status)),
                ),
                child: Text(
                  '${schemeStatus(scheme.status)}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16
                  ),
                ),
              ),
            ),
          ],
          title: Text('Scheme Details'),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/schema.png',
                    height: 200,
                    width: 200,
                  ),
                  Text('${scheme.department}',
                    style: TextStyle(
                        fontSize: 24
                    ),
                  )
                ],
              ),
              Text('${scheme.name}',
                style: TextStyle(
                    fontSize: 32
                ),
              ),
              Image.asset(
                'assets/images/schema.png',
                height: 200,
                width: 200,
              ),
              Text('$description'
              )
            ],
          ),
        ),
      ),
    );
  }
}
