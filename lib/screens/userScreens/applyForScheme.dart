import 'package:flutter/material.dart';

class ApplyForScheme extends StatefulWidget {
  const ApplyForScheme({Key? key}) : super(key: key);

  @override
  State<ApplyForScheme> createState() => _ApplyForSchemeState();
}

class _ApplyForSchemeState extends State<ApplyForScheme> {
  @override
  Widget build(BuildContext context) {
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
          title: const Text('Apply For Scheme'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
