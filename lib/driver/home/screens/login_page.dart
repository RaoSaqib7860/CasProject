import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:clip_shadow/clip_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_smart_ride_cas/Commons/constant.dart';
import 'package:get_smart_ride_cas/Commons/shared_preferences.dart';
import 'package:get_smart_ride_cas/api/common/ps_resource.dart';
import 'package:get_smart_ride_cas/api/common/ps_status.dart';
import 'package:get_smart_ride_cas/api/driver_api/driver_api_services.dart';
import 'package:get_smart_ride_cas/app/theme/colors.dart';
import 'package:get_smart_ride_cas/driver/constant/ps_constants.dart';
import 'package:get_smart_ride_cas/driver/home/screens/driver_dashboard.dart';
import 'package:get_smart_ride_cas/driver/home/screens/driver_initial_requirements_page.dart';
import 'package:get_smart_ride_cas/driver/repository/initial_requirements/bloc/driverinitialrequirements_bloc.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_login_reponse.dart';
import 'package:get_smart_ride_cas/rider/screens/SmartDrawer/mobileNoDialog.dart';
import 'package:get_smart_ride_cas/utils/utils.dart';
import 'package:get_smart_ride_cas/widgets/flush_bar.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'otpDialogForDriverRegister.dart';

bool loginPhoneNo;

class DriverLoginPage extends StatefulWidget {
  static bool onRegister;
  @override
  _DriverLoginPageState createState() => _DriverLoginPageState();
}

class _DriverLoginPageState extends State<DriverLoginPage> {
  var height, width;

  //======================================
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  double textFieldHeight = 60;
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextStyle _textStyleBlueTheme = TextStyle(
    color: Colors.lightBlue,
  );
  Color iconColor = Colors.lightBlue;

  ///         Resposne Data Map in  below function       \\\
  ///
  ///
  String status, utype;
  bool connectivityError = false;
  bool textOpacity = false;
  bool singUpAnimation = false;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    // LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Geolocator.requestPermission();
    }
    return Geolocator.getCurrentPosition();
  }

  bool isLoading = false;
  @override
  void initState() {
    _determinePosition().then((value) async {
      print(
          "...................._current position ................${value.toString()}");

      try {
        LatLng latLng = LatLng(value.latitude, value.longitude);
        final coordinates = new Coordinates(latLng.latitude, latLng.longitude);
        var address =
            await Geocoder.local.findAddressesFromCoordinates(coordinates);
        var area = address.first;

        DriverConst.driverLongitude = value.longitude;
        DriverConst.driverLatitude = value.latitude;
        DriverConst.driver_city_name = area.subAdminArea;

        print(".............Area........${area.subAdminArea}");
      } catch (e) {
        print(e);
      }
    });
    Future.delayed(const Duration(milliseconds: 0), () {
      setState(() {
        textOpacity = true;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    //  _phoneController.text = "03047654321"; //bwp

    //  _phoneController.text = "03061234567"; // lod
    //  _passwordController.text = "123456";

    return Scaffold(
      //   backgroundColor: Colors.blue,
      resizeToAvoidBottomPadding: false,
      body: Container(
        height: height,
        width: width,
        // color: Colors.red,
        child: Stack(
          children: [
            Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill, image: AssetImage("images/bg2.jpg"),
                  //image: AssetImage("images/background12.jpg"),
                ),
              ),
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      blurRadius: 16,
                      spreadRadius: 16,
                      color: Colors.black.withOpacity(0.3))
                ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                    child: Container(
                      height: height * 0.8,
                      width: width * 0.9,
                      decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              width: 2, color: Colors.white.withOpacity(0.2))),
                    ),
                  ),
                ),
              ),
            ),
            // Center(
            //     child: GlassmorphicContainer(
            //   height: height * 0.8,
            //   width: width * 0.9,
            //   borderRadius: height * 0.02,
            //   blur: 15,
            //   alignment: Alignment.center,
            //   border: 2,
            //   linearGradient: LinearGradient(colors: [
            //     Colors.blue,

            //     //Colors.black.withOpacity(0.2),
            //     Colors.white38.withOpacity(0.6)
            //   ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            //   borderGradient: LinearGradient(colors: [
            //     Colors.white24.withOpacity(0.2),
            //     Colors.white70.withOpacity(0.2)
            //   ]),
            // )),
            //======================== Left Clipper ======================\\

            // ClipShadow(
            //   boxShadow: [
            //     BoxShadow(
            //       offset: Offset(0.0, 0.0),
            //       blurRadius: 10.0,
            //       spreadRadius: 10.0,
            //       color: Colors.grey.withOpacity(0.8),
            //     )
            //   ],
            //   clipper: LoginBackgroundClipper(clipType: ClipType.Left),
            //   child:

            //6,9,11,13
            // ============================== Blured Image =============================== \\
            // child: BackdropFilter(
            //   filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            //   child: Container(
            //     color: Colors.white.withOpacity(0.9),
            //   ),
            // ),
            //   ),
            //    ),

            //
            //======================= Right Clipper ========================\\
            //

            // ClipShadow(
            //   boxShadow: [
            //     BoxShadow(
            //       // offset: Offset(0.0, 0.0),
            //       // blurRadius: 10.0,
            //       // spreadRadius: 10.0,
            //       color: Colors.grey.withOpacity(0.8),
            //     )
            //   ],
            //   clipper: LoginBackgroundClipper(clipType: ClipType.Right),
            //   child: Container(
            //     height: height,
            //     width: width,
            //     decoration: BoxDecoration(
            //       image: DecorationImage(
            //         fit: BoxFit.fitHeight,
            //         image: AssetImage("images/background12.jpg"),

            //         // image: NetworkImage(
            //         //     "https://thumbs.dreamstime.com/b/planks-dark-old-wood-texture-background-170515350.jpg"),
            //       ),
            //     ),
            //     //6,9,11,13
            //     // ============================== Blured Image =============================== \\
            //     // child: BackdropFilter(
            //     //   filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            //     //   child: Container(
            //     //     color: Colors.blue.withOpacity(0.6),
            //     //   ),
            //     // ),
            //   ),
            // ),

            //========================= Content Data Show Here ==========================\\
            Container(
              height: height,
              width: width,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.12),
                      child: Container(
                        alignment: Alignment.center,
                        height: height * 0.2,
                        width: width,
                        child: Image.asset("images/driver.jpg",
                            fit: BoxFit.fill, color: AppColors.mainColor),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.05, top: height * 0.03),
                      child: Container(
                        width: width,
                        alignment: Alignment.centerLeft,
                        child: AnimatedOpacity(
                          duration: Duration(seconds: 2),
                          curve: Curves.easeIn,
                          opacity: textOpacity == false ? 0 : 1,
                          child: AnimatedContainer(
                            padding: EdgeInsets.only(
                              left: textOpacity == false ? 100 : 20,
                            ),
                            duration: Duration(seconds: 2),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: GradientText("Driver",
                                    gradient: LinearGradient(colors: [
                                      AppColors.mainColor,
                                      Colors.lightBlue[700],
                                      AppColors.mainColor,
                                    ]),
                                    style: TextStyle(fontSize: 35),
                                    textAlign: TextAlign.center)),
                          ),
                        ),
                      ),
                    ),

                    ///           Phone Number        \\\
                    ///
                    Padding(
                      padding: EdgeInsets.only(top: 15, left: 28, right: 28),
                      child: AnimatedContainer(
                        curve: Curves.bounceOut,
                        duration: Duration(seconds: 3),
                        width: textOpacity == false
                            ? 0
                            : MediaQuery.of(context).size.width,
                        child: Container(
                          //   color: Colors.grey,
                          height: height * 0.11,
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "Phone NO is required"),
                              LengthRangeValidator(
                                  min: 11,
                                  max: 11,
                                  errorText: 'Invalid phone number'),
                            ]),
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.white),
                              fillColor: Colors.grey.withOpacity(0.6),
                              //   filled: true,
                              //  focusColor: Colors.grey,
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      BorderSide(color: iconColor, width: 2)),
                              labelText: "Phone NO",

                              labelStyle: _textStyleBlueTheme,
                              hintText: "phone nO",
                              prefixIcon: Icon(
                                Icons.phone_android,
                                color: AppColors.mainColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    ///           Password         \\\
                    Padding(
                      padding: EdgeInsets.only(
                          top: 2, left: 28, right: 28, bottom: 0),
                      child: AnimatedContainer(
                        curve: Curves.bounceOut,
                        duration: Duration(seconds: 3),
                        width: textOpacity == false
                            ? 0
                            : MediaQuery.of(context).size.width,
                        child: Container(
                          //  color: Colors.grey,
                          height: height * 0.11,
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            obscureText: true,
                            controller: _passwordController,
                            keyboardType: TextInputType.text,
                            validator: RequiredValidator(
                                errorText: "Password is required"),
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.white),
                              fillColor: Colors.grey.withOpacity(0.6),
                              // filled: true,
                              isDense: true,
                              //    contentPadding: EdgeInsets.symmetric(vertical: 15),
                              labelText: "Password",
                              labelStyle: _textStyleBlueTheme,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      BorderSide(color: iconColor, width: 2)),
                              hintText: "password",
                              prefixIcon: Icon(
                                Icons.lock_open,
                                color: AppColors.mainColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    //                                  Button Login                \\\

                    Padding(
                      padding: EdgeInsets.only(
                        top: height * 0.01,
                        left: 28,
                        right: 28,
                      ),
                      child: AnimatedContainer(
                        curve: Curves.bounceOut,
                        duration: Duration(seconds: 3),
                        width: textOpacity == false
                            ? 0
                            : MediaQuery.of(context).size.width,
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    AppColors.mainColor,
                                    Colors.white,
                                    //  Colors.white,
                                    Colors.white,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.8),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                ),
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          height: 45,
                          width: width * 0.84,
                          child: FlatButton(
                            onPressed: () {
                              if (formKey.currentState.validate()) {
                                ApiServices api = ApiServices();
                                setState(() {
                                  isLoading = true;
                                  Utils.checkInternetConnectivity()
                                      .then((value) async {
                                    if (value == true) {
                                      var map = <String, dynamic>{
                                        "PhoneNumber":
                                            "${_phoneController.text}",
                                        "Password":
                                            "${_passwordController.text}",
                                      };
                                      PsResource<DriverLoginResponse>
                                          _resource =
                                          await api.driverLogin(map);
                                      print("....${_resource.message}");

                                      if (_resource.status ==
                                          PsStatus.SUCCESS) {
                                        print(
                                            "....${_resource.message}.......${_resource.data.driverImage}.......${_resource.data.drivingLicence}......${_resource.data.idCardImage}");
                                        if (_resource.data.status ==
                                            "Driver Login Successfully") {
                                          DriverConst.str1 =
                                              _resource.data.str1;

                                          DriverConst.str2 =
                                              _resource.data.str2;

                                          DriverConst.str3 =
                                              _resource.data.str3;

                                          DriverConst.str4 =
                                              _resource.data.str4;

                                          checkUserId(_resource, context);
                                        } else if (_resource.data.status ==
                                            "Invalid UserName/Password") {
                                          setState(() {
                                            isLoading = false;
                                          });
                                          FlushBar.showSimpleFlushBar(
                                              "Invalid UserName/Password",
                                              context,
                                              Colors.pink,
                                              Colors.white);
                                        }
                                      } else if (_resource.message ==
                                          'Connection Error!') {
                                        print("Has no record");
                                        setState(() {
                                          isLoading = false;
                                        });
                                      } else {
                                        if (_resource.errorCode ==
                                            DriverConst.ERROR_CODE_10001) {
                                          print("Has no record");
                                          setState(() {
                                            isLoading = false;
                                          });
                                        }
                                      }
                                    } else {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      FlushBar.showSimpleFlushBar(
                                          "Check Connectivity",
                                          context,
                                          Colors.pink,
                                          Colors.white);
                                    }
                                  });
                                });
                              }
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: AppColors.mainColor,
                                fontSize: 21,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.025,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          "Login with phone no",
                          minFontSize: 10,
                          maxFontSize: 15,
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        SizedBox(
                          width: width * 0.05,
                        ),
                        InkWell(
                          onTap: () {
                            loginPhoneNo = true;
                            showAnimatedDialog(
                              context: context,
                              barrierDismissible: true,
                              duration: Duration(seconds: 2),
                              animationType: DialogTransitionType.scale,
                              builder: (BuildContext context) {
                                return MobileNoDialog(
                                  width: width,
                                  height: height,
                                );
                              },
                            );
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue[700]),
                              child: Icon(
                                Icons.forward,
                                color: Colors.white,
                                size: 30,
                              )),
                        )
                      ],
                    ),

                    ///               End Button Login              \\\
                    ///

                    ///               Forget Password      \\\
                    ///
                    // Padding(
                    //   padding: EdgeInsets.only(left: 0, top: height * 0.03),
                    //   child: AnimatedOpacity(
                    //     duration: Duration(seconds: 2),
                    //     curve: Curves.easeIn,
                    //     opacity: textOpacity == false ? 0 : 1,
                    //     child: AnimatedContainer(
                    //       padding: EdgeInsets.only(
                    //         left: textOpacity == false ? 100 : 20,
                    //       ),
                    //       duration: Duration(seconds: 2),
                    //       child: Row(
                    //         children: [
                    //           Container(
                    //             width: width,
                    //             //alignment: Alignment.center,
                    //             child: Text(
                    //               "Login with phone no",
                    //               style:
                    //                   TextStyle(color: Colors.white, fontSize: 17),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    ///           Last Text
                    Expanded(
                      child: Container(
                        //    color: Colors.white,
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: height * 0.03),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "New to Driver Find App ?",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 22,
                                child: FlatButton(
                                  onPressed: () {
                                    DriverLoginPage.onRegister = true;
                                    showAnimatedDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      duration: Duration(seconds: 2),
                                      animationType: DialogTransitionType.scale,
                                      builder: (BuildContext context) {
                                        return OTPDialogForDriverRegister(
                                          width: width,
                                          height: height,
                                        );
                                      },
                                    );
                                    // DriverConst.driverlogin = false;
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           DriverSignUpPage(),
                                    //     ));
                                  },
                                  child: Text(
                                    "Register",
                                    style: TextStyle(
                                        color: Colors.white,
                                        textBaseline: TextBaseline.alphabetic),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            isLoading == true
                ? Container(
                    height: height,
                    color: Colors.lightBlue.withOpacity(0.2),
                    child: Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  checkUserId(PsResource<DriverLoginResponse> model, context) {
    if (model.data.id == 1) {
      DriverConst.driverlogin = true;
      FlushBar.showSimpleFlushBar(
          "Login successful", context, Colors.blue, Colors.white);

      DriverConst.str1 = model.data.str1;
      DriverConst.str2 = model.data.str2;
      DriverConst.str3 = model.data.str3;
      DriverConst.str4 = model.data.str4;

      setDataToSharedPreferances(model);
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return DriverDashboard();
        },
      ));
      // }
    } else if (model.data.id == 2) {
      FlushBar.showSimpleFlushBar(
          "Waiting for admin verification", context, Colors.pink, Colors.white);
    } else if (model.data.id == 3) {
      DriverConst.driverlogin = true;
      FlushBar.showSimpleFlushBar("Waiting for franchise verification", context,
          Colors.pink, Colors.white);
      if (model.data.idCardImage.isEmpty ||
          model.data.drivingLicence.isEmpty ||
          model.data.idCardImage.isEmpty ||
          model.data.vehicleNumber.isEmpty) {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return BlocProvider<DriverinitialrequirementsBloc>(
              create: (context) => DriverinitialrequirementsBloc(),
              child: DriverInitialRequirementPage(
                phoneNo: _phoneController.text,
                password: _passwordController.text,
              ),
            );
          },
        ));
      } else {
        return null;
      }
    } else if (model.data.id == 4) {
      FlushBar.showSimpleFlushBar(
          "Block by admin", context, Colors.pink, Colors.white);
    } else {
      FlushBar.showSimpleFlushBar(
          "Deactive by admin", context, Colors.pink, Colors.white);
    }
  }

  Future<void> setDataToSharedPreferances(
      PsResource<DriverLoginResponse> model) async {
    SharedPreferencesData.sharedPreferencesModel =
        await SharedPreferences.getInstance();
    SharedPreferencesData.sharedPreferencesModel
        .setString(Const.STR1, model.data.str1);

    SharedPreferencesData.sharedPreferencesModel
        .setString(Const.STR2, model.data.str2);

    SharedPreferencesData.sharedPreferencesModel
        .setString(Const.STR3, model.data.str3);

    SharedPreferencesData.sharedPreferencesModel
        .setString(Const.STR4, model.data.str4);
  }
}
