import 'package:flutter/material.dart';

class LocationsTestPage extends StatefulWidget {
  const LocationsTestPage({Key? key}) : super(key: key);

  @override
  State<LocationsTestPage> createState() => _LocationsTestPageState();
}

class _LocationsTestPageState extends State<LocationsTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "List if available locations",
          style: TextStyle(fontSize: 34, color: Colors.red),
        ),
      ),
      body: SingleChildScrollView(
        child: ListView(
          children: [
            
          ],
        ),
      ),
    );
  }
}
