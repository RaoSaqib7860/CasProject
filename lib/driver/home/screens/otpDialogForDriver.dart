import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_smart_ride_cas/app/theme/colors.dart';
import 'package:get_smart_ride_cas/widgets/flush_bar.dart';
import 'package:flutter/services.dart';
enum MobileVerificationStateForDriver {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE
}

class MobileNoDialogForDriverLogin extends StatefulWidget {
  final double width;
  final double height;
  final String image;
  final String userName;

  final String phoneNoController;
  final String userEmail;

  const MobileNoDialogForDriverLogin(
      {Key key,
      this.width,
      this.height,
      this.phoneNoController,
      this.userEmail,
      this.userName,
      this.image})
      : super(key: key);

  @override
  _MobileNoDialogForDriverLoginState createState() =>
      _MobileNoDialogForDriverLoginState();
}

class _MobileNoDialogForDriverLoginState
    extends State<MobileNoDialogForDriverLogin> {
  int _groupValue = 1;
  bool selectGender;
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _otpController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  MobileVerificationStateForDriver currentState =
      MobileVerificationStateForDriver.SHOW_MOBILE_FORM_STATE;
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
      if (authCredential?.user != null) {}
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });

      FlushBar.showSimpleFlushBar(e.message, context, Colors.red, Colors.white);
    }
  }

  getMobileFormWidget(context) {
    return Center(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              child: TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[300])),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Enter phone number"),
                controller: _phoneController,
              ),
            ),
          ),
          //_myRadioButton(
          //   title: "female",
          //   value: 0,
          //   onChanged: (newValue) => setState(() => _groupValue = newValue),
          // ),
          // _myRadioButton(
          //   title: "male",
          //   value: 1,
          //   onChanged: (newValue) => setState(() => _groupValue = newValue),
          // ),
          RaisedButton(
              color: AppColors.mainColor,
              onPressed: () async {
                if (_phoneController.text.length == 0) {
                  FlushBar.showSimpleFlushBar(
                      "enter phone no", context, Colors.red, Colors.white);
                } else {
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
                          currentState = MobileVerificationStateForDriver
                              .SHOW_OTP_FORM_STATE;
                          this.verificationId = verificationId;
                        });
                      },
                      codeAutoRetrievalTimeout: (verificationId) async {},
                      phoneNumber: "+92" + _phoneController.text);
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
              controller: _otpController,
               keyboardType: TextInputType.number,
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
          : currentState ==
                  MobileVerificationStateForDriver.SHOW_MOBILE_FORM_STATE
              ? getMobileFormWidget(context)
              : getOTPFormWidget(context),
    ));
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
