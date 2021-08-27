import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  Utils._();

  static String getString(BuildContext context, String key) {
    if (key != '') {
      return key;
    } else {
      return '';
    }
  }

  static Future<bool> checkInternetConnectivity() async {
    final ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          return true;
        } else {
          return false;
        }
      } on SocketException catch (_) {
        return false;
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          return true;
        } else {
          return false;
        }
      } on SocketException catch (_) {
        return false;
      }
    } else if (connectivityResult == ConnectivityResult.none) {
      // print('No Connection');
      return false;
    } else {
      return false;
    }
  }

  static bool isLightMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light;
  }

  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    // LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Geolocator.requestPermission();
    }
    return Geolocator.getCurrentPosition();
    // return Position(latitude: 29.388564, longitude: 71.701625);
  }

  static Future<String> getCityName() async {
    String cityName;
    Position position = await determinePosition();
//29.388564, 71.701625
    //  LatLng latLng = LatLng(29.388564, 71.701625);
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    cityName = first.subAdminArea;
    return cityName;
  }

  //=========================== Create notification ======================\\

  static initializeNotification(Function selectNotification) {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    /////  Andriod notification initilalization
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    /////  IOS notification initilalization
    var initializationSettingsIOS = IOSInitializationSettings();
    ///////          Notifucation Initialization     \\\\\\\
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    ///////            Select Nitification
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  static getDateInNoformat(String timeFromList) {
    var date = "$timeFromList";
    String time = DateFormat("d").format(DateTime.parse(date));
    return time;
  }

  static getDateFormat(String d) {
    String date = DateFormat('yyyy-MM-dd').format(DateTime.parse(d));
    return date;
  }

  static getTimeinformat(String timeFromList) {
    var date = "$timeFromList";
    String time = DateFormat.jm().format(DateTime.parse(date));
    return time;
  }

  static Future<SharedPreferences> getSharedPreferencesInstance() async {
    SharedPreferences model = await SharedPreferences.getInstance();
    return model;
  }

  static Future showNotification(String title, String message) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    // String title = message["notification"]["title"].toString();
    // String body = message["notification"]["body"].toString();

    print("Title = $title");
    print("Body = $message");
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
        0, title, message, platformChannelSpecifics);
  }
}
