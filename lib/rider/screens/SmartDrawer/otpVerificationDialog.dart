import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get_smart_ride_cas/Commons/choose_account_type_screen.dart';
import 'package:get_smart_ride_cas/Commons/commons.dart';
import 'package:get_smart_ride_cas/Commons/constant.dart';
import 'package:get_smart_ride_cas/Commons/shared_preferences.dart';
import 'package:get_smart_ride_cas/api/common/ps_api.dart';
import 'package:get_smart_ride_cas/api/common/ps_resource.dart';
import 'package:get_smart_ride_cas/api/rider_api/rider_api.dart';
import 'package:get_smart_ride_cas/api/rider_api/rider_api_services.dart';
import 'package:get_smart_ride_cas/app/theme/colors.dart';
import 'package:get_smart_ride_cas/rider/home/rider_home_screen.dart';
import 'package:get_smart_ride_cas/rider/objects/otp_response.dart';
import 'package:get_smart_ride_cas/rider/objects/ridingClientPhoneNumberForOtp.dart';
import 'package:get_smart_ride_cas/widgets/flush_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../riderInfoPageAfterOtp.dart';
import '../signup_screen.dart';

enum MobileVerificationStateForOtp {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE
}

class OTPVerificationDialog extends StatefulWidget {
  final double width;
  final double height;
  // final String image;
  // final String userName;

  final String phoneNoController;
  // final String userEmail;

  const OTPVerificationDialog({
    Key key,
    this.width,
    this.height,
    this.phoneNoController,
  }) : super(key: key);

  @override
  _OTPVerificationDialogState createState() => _OTPVerificationDialogState();
}

class _OTPVerificationDialogState extends State<OTPVerificationDialog> {
  int _groupValue = 1;
  String countryCode = "+92";
  bool selectGender;
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _otpController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  MobileVerificationStateForOtp currentState =
      MobileVerificationStateForOtp.SHOW_MOBILE_FORM_STATE;
  String verificationId;
  bool showLoading = false;
  signUpWithPhoneAuthCredential(PhoneAuthCredential phoneCredential) async {
    setState(() {
      showLoading = true;
    });
    try {
      final authCredential = await _auth.signInWithCredential(phoneCredential);
      setState(() {
        showLoading = false;
      });
      if (authCredential?.user != null) {
        RiderApiServices api = RiderApiServices();
        Uuid uuid = Uuid();
        var id = uuid.v4();
        InsertRidingPhoneNoForOtp model = InsertRidingPhoneNoForOtp(
            uUID: id,
            ridingClientPhoneNo: _phoneController.text,
            email: _phoneController.text);
        PsResource<Otp_Response> _resource =
            await api.loginClientPhoneNoAfterOTPVerify(
                InsertRidingPhoneNoForOtp().toMap(model));

        //   var email = _resource.data.email;
        var name = _resource.data.name;
        var image = _resource.data.image;
        var phoneNo = _resource.data.phoneNo;
        var email = _resource.data.email;
        //  var email = _resource.data.email;
        // print("email.........$email");
        print("name.........$name");
        print("image.........$image");
        print("phoneeee.........$phoneNo");
        print("emaillll/////////////////........$email");
        if (_resource.data.status == "Riding Client Available") {
          if (_resource.data.id == 0) {
            FlushBar.showSimpleFlushBar(
                "User are deactive", context, Colors.pink, Colors.white);
          } else if (_resource.data.id == 1) {
            print(".abc.........login no save");
            print(".abc.........login no $phoneNo");
            RiderUser user = RiderUser(
                id: id,
                image: "${RiderApi.baseUrl + image}",
                username: name,
                //     email: email,
                phoneNo: phoneNo);
            setDataToSharedPreferances(user);

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>

                        // RiderInfoPageAfterOtp(
                        //       currentUserEmail: email,
                        //       riderImage: image,
                        //       riderName: name,
                        //     )

                        RiderHomeScreen(
                          //     currentUserEmail: email,
                          riderImage: "${RiderApi.baseUrl + image}",
                          riderPhoneNo: _phoneController.text,
                          riderName: name,
                        )));
          } else if (_resource.data.id == 2) {
            showAnimatedDialog(
              context: context,
              barrierDismissible: true,
              duration: Duration(seconds: 2),
              animationType: DialogTransitionType.scale,
              builder: (BuildContext context) {
                return OTPVerificationDialog(
                  width: widget.width,
                  height: widget.height,
                );
              },
            );
            print('rida');
          }
        } else if (_resource.data.status == "Riding Client Not Available") {
          FlushBar.showSimpleFlushBar(
              "Riding client not available for this number",
              context,
              Colors.red,
              Colors.white);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RiderInfoPageAfterOtp(
                        phoneNumber: _phoneController,
                        //   riderName: name,
                      )));
        }
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });

      FlushBar.showSimpleFlushBar(e.message, context, Colors.red, Colors.white);
    }
  }

  getMobileFormWidget(context) {
    print(countryCode);
    return Center(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              child: Row(
                children: [
                  CountryCodePicker(
                    onChanged: (cunCode) {
                      countryCode = cunCode.toString();
                      print(countryCode);
                    },
                    //  hideMainText: true,
                    showFlagMain: true,
                    showFlag: true,
                    initialSelection: 'Pk',
                    hideSearch: false,

                    padding: EdgeInsets.zero,
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18)),
                              borderSide: BorderSide(color: Colors.grey[200])),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: Colors.grey[300])),
                          filled: true,
                          fillColor: Colors.grey[100],
                          hintText: "Enter phone number",
                          hintStyle: TextStyle(fontSize: 14)),
                      controller: _phoneController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          RaisedButton(
              color: AppColors.mainColor,
              onPressed: () async {
                if (_phoneController.text.length == 0) {
                  FlushBar.showSimpleFlushBar(
                      "enter phone no", context, Colors.red, Colors.white);
                } else {
                  String phoneNo = _phoneController.text;
                  if (countryCode.toString() == "+92") {
                    print(".....1");
                    if (phoneNo.length == 11) {
                      print(".....2");
                      if (phoneNo[0] == "0") {
                        print(".....3");
                        phoneNo = phoneNo.substring(1);
                        /// most important step/
                        /// // isma ham shuru wala zero ko khatam kre
                        /// 
                     _phoneController.text =phoneNo;
                      }
                    }
                    else if(phoneNo.length == 10){}
                    else {
                       FlushBar.showSimpleFlushBar(
                      "Phone No is Invalid", context, Colors.red, Colors.white);
                      return;
                    }
                  }
                  print(".......");
                  print("......$phoneNo");
                  print("....."+countryCode + _phoneController.text);
                  setState(() {
                    showLoading = true;
                  });
                  await _auth.verifyPhoneNumber(
                      verificationCompleted: (phoneAuthCredential) async {
                        setState(() {
                          showLoading = false;
                        });
                        print(
                            "VERIFICATION COMPLETED.....$phoneAuthCredential");
                      },
                      verificationFailed: (verificationFailed) async {
                        setState(() {
                          showLoading = false;
                        });
                        FlushBar.showSimpleFlushBar(verificationFailed.message,
                            context, Colors.red, Colors.white);
                        print(
                            "...................${verificationFailed.message}");
                      },
                      codeSent: (verificationId, resendingToken) async {
                        setState(() {
                          showLoading = false;
                          currentState =
                              MobileVerificationStateForOtp.SHOW_OTP_FORM_STATE;
                          this.verificationId = verificationId;
                        });
                      },
                      codeAutoRetrievalTimeout: (verificationId) async {},
                      phoneNumber: countryCode + phoneNo);
                }
              },
              child: Text(
                "verify",
                style: TextStyle(color: Colors.white),
              )),
        ],
      ),
    );
  }

  getOTPFormWidget(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 50,
            child: TextFormField(
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: Colors.grey[200])),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: Colors.grey[300])),
                  filled: true,
                  fillColor: Colors.grey[100],
                  hintText: "Enter OTP Number"),
              controller: _otpController,keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
            ),
          ),
        ),
        RaisedButton(
            color: AppColors.mainColor,
            onPressed: () async {
              if (_otpController.text.length == 0) {
                FlushBar.showSimpleFlushBar(
                    "enter otp", context, Colors.red, Colors.white);
              }
              PhoneAuthCredential phoneCredential =
                  PhoneAuthProvider.credential(
                      verificationId: verificationId,
                      smsCode: _otpController.text);
              signUpWithPhoneAuthCredential(phoneCredential);
            },
            child: Text(
              "verify",
              style: TextStyle(color: Colors.white),
            )),
      ],
    );
  }

  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Dialog(
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)
        // ),
        //key: _scaffoldKey,
        child: Container(
      decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(20),
          // color: Colors.black.withOpacity(0.0)
          ),
      width: width * 0.7,
      height: height * 0.35,
      child: showLoading == true
          ? Center(child: CircularProgressIndicator())
          : currentState == MobileVerificationStateForOtp.SHOW_MOBILE_FORM_STATE
              ? getMobileFormWidget(context)
              : getOTPFormWidget(context),
    ));
  }

  Future<void> setDataToSharedPreferances(RiderUser user) async {
    Commons.riderEmail = user.email;
    Commons.image = user.image;
    Commons.userName = user.username;
    Commons.riderPhoneNO = user.phoneNo;
    print("--------------- Shared Preferrences ---------- $user.email");
    SharedPreferencesData.sharedPreferencesModel =
        await SharedPreferences.getInstance();
    // SharedPreferencesData.sharedPreferencesModel.clear();
    SharedPreferencesData.sharedPreferencesModel
        .setString(Const.RIDER_EMAIL, user.email);
    SharedPreferencesData.sharedPreferencesModel
        .setString(Const.RiderUserName, user.username);
    SharedPreferencesData.sharedPreferencesModel
        .setString(Const.Riderimage, user.image);
    // SharedPreferencesData.sharedPreferencesModel.remove(Const.RIDER_PHONE_NO);
    SharedPreferencesData.sharedPreferencesModel
        .setString(Const.RIDER_PHONE_NO, user.phoneNo);
  }
  // Widget _myRadioButton(
  //     {String title, int value, Function onChanged, bool select}) {
  //   return RadioListTile(
  //     //  selected: true,
  //     value: value,
  //     groupValue: _groupValue,
  //     onChanged: onChanged,
  //     title: Text(title),
  //   );
  // }
}
