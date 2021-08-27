import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_smart_ride_cas/Commons/choose_account_type_screen.dart';
import 'package:get_smart_ride_cas/Commons/commons.dart';
import 'package:get_smart_ride_cas/Commons/constant.dart';
import 'package:get_smart_ride_cas/api/rider_api/waiting_controller.dart';
import 'package:get_smart_ride_cas/app/theme/colors.dart';
import 'package:get_smart_ride_cas/app/theme/textStyles.dart';
import 'package:get_smart_ride_cas/driver/constant/ps_constants.dart';
import 'package:get_smart_ride_cas/driver/home/screens/driver_all_ridig_list_page.dart';
import 'package:get_smart_ride_cas/driver/home/screens/driver_dashboard.dart';
import 'package:get_smart_ride_cas/rider/home/myController.dart';
import 'package:get_smart_ride_cas/rider/home/rider_home_screen.dart';
import 'package:get_smart_ride_cas/rider/screens/SmartDrawer/profile_card_screen.dart';
import 'package:get_smart_ride_cas/rider/screens/sliders/intro.dart';
import 'package:get_smart_ride_cas/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static var image;
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  Future selectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }

    await printPayload(payload);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DriverAllRidingRequestPage(),
      ),
    );
  }

  printPayload(var payload) {
    return print("Pay load.................$payload");
  }

  @override
  void initState() {
    // Get.put(MyController(), permanent: true);

    // Get.put(WaitingController());
    super.initState();

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
    // showNotification(
    //     <String, dynamic>{"Title": "Hi", "Message": "How are you "});

    Future.delayed(
        Duration(
          seconds: 3,
        ), () async {
      SharedPreferences _instance = await Utils.getSharedPreferencesInstance();
      print("..App discripton..${_instance.getString(Const.APP_DESCRIPTION)}");
      print("..Email..${_instance.getString(Const.RIDER_EMAIL)}");
      print("..Phone NO..${_instance.getString(Const.RIDER_PHONE_NO)}");
      print("..User Type..${_instance.getString(Const.USER_TYPE)}");
      print("..Str1..${_instance.getString(Const.STR1)}");
      print("..Str2..${_instance.getString(Const.STR2)}");
      print("..Str3..${_instance.getString(Const.STR3)}");
      print("..Str4..${_instance.getString(Const.STR4)}");
      DriverConst.str1 = _instance.getString(Const.STR1);
      DriverConst.str2 = _instance.getString(Const.STR2);
      DriverConst.str3 = _instance.getString(Const.STR3);
      DriverConst.str4 = _instance.getString(Const.STR4);
      Commons.userType = _instance.getString(Const.USER_TYPE);
      Commons.riderEmail = _instance.getString(Const.RIDER_EMAIL); //str 1
      Commons.riderPhoneNO = _instance.getString(Const.RIDER_PHONE_NO); //str 2

      Commons.userName = _instance.getString(Const.RiderUserName);

      Commons.image =
          //  ProfileCard.image != null
          // ? _instance.getString(ProfileCard.image.path)
          // :
          _instance.getString(Const.Riderimage);
      // SplashScreen.image  Commons.image;
      print(" Rider IMAGE.............. ${Commons.image}");
      print(" Rider Email ${Commons.riderEmail}");

      if (_instance.getString(Const.APP_DESCRIPTION) == "true") {
        if (_instance.getString(Const.USER_TYPE) == "Driver") {
          if (_instance.getString(Const.STR1) != null) {
            return Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => DriverDashboard()));
          } else {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => ChooseAccountType()),
                (Route<dynamic> route) => false);

            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => ChooseAccountType(),
            //     ));
          }
        } else if (_instance.getString(Const.USER_TYPE) == "Rider") {
          if (_instance.getString(Const.RIDER_EMAIL) != null) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => RiderHomeScreen()),
                (Route<dynamic> route) => false);
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) =>
            //             //  BlocProvider<GetdriverdataBloc>(
            //             //     create: (BuildContext context) => GetdriverdataBloc(),
            //             //     child:
            //             RiderHomeScreen()
            //         //),
            //         ));
            //
          } else if (_instance.getString(Const.RIDER_PHONE_NO) != null) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => RiderHomeScreen()),
                (Route<dynamic> route) => false);

            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) =>
            //             //  BlocProvider<GetdriverdataBloc>(
            //             //     create: (BuildContext context) => GetdriverdataBloc(),
            //             //     child:
            //             RiderHomeScreen()
            //         //),
            //         ));
            //
          } else {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => ChooseAccountType()),
                (Route<dynamic> route) => false);

            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => ChooseAccountType(),
            //     ));
          }
        }
      } else {
        return Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => IntroSliderGSR()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        // backgroundColor: appSecondaryColorblu,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: LayoutBuilder(
            builder: (context, constraints) => Stack(
              children: [
                FlareActor(
                  "images/elms_bg_splash.flr",
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  animation: "Untitled",
                  antialias: true,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElasticInDown(
                        animate: true,
                        duration: Duration(seconds: 2),
                        child: SizedBox(
                          child: Image.asset(
                            "images/GetSmartRideLogo.png",
                            fit: BoxFit.scaleDown,
                            width: 200,
                          ),
                          // child: FlareActor(
                          //   "images/elms_logo_flr.flr",
                          //   fit: BoxFit.fill,
                          //   alignment: Alignment.center,
                          //   animation: "Untitled",
                          //   antialias: true,
                          // ),
                        ),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.02,
                      ),
                      ElasticInRight(
                          animate: true,
                          duration: Duration(seconds: 2),
                          child: Text(
                            'GetSmartRide',
                            style: AppTextStyles.splashTitle,
                          )),
                      SizedBox(
                        height: constraints.maxHeight * 0.02,
                      ),
                      ElasticInLeft(
                        animate: true,
                        duration: Duration(seconds: 2),
                        child: Text(
                          "We Connect Drivers & Passengers",
                          style: AppTextStyles.heading2,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ZoomIn(
                      duration: Duration(seconds: 1),
                      child: Text(
                        "www.GetSmartRide.com",
                        style: AppTextStyles.heading3.copyWith(
                            color: AppColors.whiteColor, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
/*
 Future<String> getDataFromSF() async {
    SharedPreferencesData.sharedPreferencesModel =
        await SharedPreferences.getInstance();

    DriverConst.str1 =
        SharedPreferencesData.sharedPreferencesModel.getString(Const.STR1);
    DriverConst.str2 =
        SharedPreferencesData.sharedPreferencesModel.getString(Const.STR2);
    DriverConst.str3 =
        SharedPreferencesData.sharedPreferencesModel.getString(Const.STR3);
    DriverConst.str4 =
        SharedPreferencesData.sharedPreferencesModel.getString(Const.STR4);
    Commons.userType =
        SharedPreferencesData.sharedPreferencesModel.getString(Const.USER_TYPE);
    Commons.riderEmail = SharedPreferencesData.sharedPreferencesModel
        .getString(Const.RIDER_EMAIL);
    Commons.riderEmail = SharedPreferencesData.sharedPreferencesModel
        .getString(Const.RIDER_PHONE_NO);

    Commons.riderPhoneNO = SharedPreferencesData.sharedPreferencesModel
        .getString(Const.RIDER_PHONE_NO);
    print("----------====---------${Commons.riderEmail}");
    return SharedPreferencesData.sharedPreferencesModel
        .getString(Const.APP_DESCRIPTION);
  }
*/
