import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_smart_ride_cas/rider/home/rider_home_screen.dart';

class WaitingController extends GetxController {
  static WaitingController get to => Get.find();
  bool isWaitng = false;
  Time time;
  moveT0MapAfterTimeCrossed90(contextt) {
    if (time.second <= 10) {
      Navigator.push(
        contextt,
        MaterialPageRoute(
          builder: (context) => RiderHomeScreen(),
        ),
      );
    }
  }

  driverwaitng(bool value) {
    print('Driver Wating Start');
    isWaitng = value;

    update();
  }
}
