import 'package:flutter/material.dart';
import 'package:defu_front_end/Models/Schemes.dart';

class AppliedScheme extends StatelessWidget {
  final Schemes scheme;

  AppliedScheme({required this.scheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scheme Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${scheme.name}'),
            Text('Department: ${scheme.department}'),
            Text('Submission Status: ${scheme.status.toString()}'),
          ],
        ),
      ),
    );
  }
}
