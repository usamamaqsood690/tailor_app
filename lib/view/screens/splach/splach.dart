import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tailor_app/view/screens/dashboard/bottom_nav_bar.dart';
import 'package:tailor_app/view/screens/mesurment/measurements.dart';
import 'package:tailor_app/view/screens/mesurment/mesurment_chart.dart';

import '../../../constant.dart';

class Splach extends StatefulWidget {
  const Splach({super.key});

  @override
  State<Splach> createState() => _SplachState();
}

class _SplachState extends State<Splach> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(Duration(seconds: 3), _goNext);
  }

  _goNext() async {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => BottomNavBar()));
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          // Adjust the height as needed
          color: appcolor, // Container background color
          child: Container(
            margin: EdgeInsets.symmetric(vertical: marginLR),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'asserts/icons/logo.jpeg', // Replace with your actual asset path
                  width: 150,
                  height: 150,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Version 1(Beta)",
                    style: TextStyle(
                        color: dfColor,
                        fontSize: exSmFontSize,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Text(
                  "Tailoe App",
                  style: TextStyle(
                      color: dfColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "One Service 360",
                  style: TextStyle(
                    color: dfColor,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
