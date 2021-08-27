import 'package:flutter/material.dart';

class DriverPenaltyPage extends StatefulWidget {
  @override
  _DriverPenaltyPageState createState() => _DriverPenaltyPageState();
}

class _DriverPenaltyPageState extends State<DriverPenaltyPage> {
  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
      ),
    );
  }
}
