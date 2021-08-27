import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get_smart_ride_cas/Commons/constant.dart';
import 'package:get_smart_ride_cas/Commons/shared_preferences.dart';
import 'package:get_smart_ride_cas/api/common/ps_resource.dart';
import 'package:get_smart_ride_cas/api/rider_api/rider_api.dart';
import 'package:get_smart_ride_cas/api/rider_api/rider_api_services.dart';
import 'package:get_smart_ride_cas/app/theme/colors.dart';
import 'package:get_smart_ride_cas/app/theme/textStyles.dart';
import 'package:get_smart_ride_cas/rider/firebaseAuth/authentications.dart';
import 'package:get_smart_ride_cas/rider/home/rider_home_screen.dart';
import 'package:get_smart_ride_cas/rider/objects/insert_email_request.dart';
import 'package:get_smart_ride_cas/rider/objects/otp_response.dart';
import 'package:get_smart_ride_cas/rider/screens/SmartDrawer/otpVerificationDialog.dart';

import 'package:get_smart_ride_cas/widgets/flush_bar.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:get_smart_ride_cas/Commons/commons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SmartDrawer/mobileNoDialog.dart';

bool loginByGmail;
bool onOtpLoginForRider;
var googleEmail;
var googleUserName;
var googleUserImage;

class RiderUser {
  String email, username, image, id, phoneNo;
  //File imagee;
  //File imagee;
  RiderUser({
    this.email,
    this.id,
    this.image,
    this.username,
    // this.imagee,
    this.phoneNo,
  });
}

//String radioValue = "male";

class SignupScreen extends StatefulWidget {
  static String email;
  static String password;
  static bool onOtpLoginForRider;
  final TextEditingController phoneNoController;
  final int radioButtonVal;
  static String riderNumberForNewSignUp;

  const SignupScreen({Key key, this.phoneNoController, this.radioButtonVal})
      : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final Auth _auth = Auth();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RiderUser user;
  bool fetchData = false;

  /// Gmail Authentication  By  Haseeb////////
  Future<RiderUser> googleSignIn(BuildContext context) async {
    final GoogleSignIn _googleSignIn = new GoogleSignIn();

    try {
      GoogleSignInAccount googleSignIn = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignIn.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      print('User is: ${googleSignIn.displayName}');
      print('User is: ${googleSignIn.email}');
      print('User is: ${googleSignIn.photoUrl}');
      print('User is: ${googleSignIn.id}');
      user = RiderUser(
          email: googleSignIn.email,
          id: googleSignIn.id,
          image: googleSignIn.photoUrl,
          username: googleSignIn.displayName);

      if (googleSignIn.displayName == null) {
        print('error in login page googlesignin.displayname is null');
      } else {
        await FirebaseAuth.instance.signInWithCredential(credential);
      }
    } on FirebaseAuthException catch (signUpError) {
      if (signUpError is PlatformException) {
        if (signUpError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
          return null;
        } else if (signUpError.code == 'sign_in_canceled') {
          print(signUpError.toString());
        } else {
          throw signUpError;
        }
      }

      rethrow;
    }
    return user;
  }

  @override
  void initState() {
    SignupScreen.riderNumberForNewSignUp = "riderNumberForNewSignUp";

    super.initState();
  }
  // void _showButtonPressDialog(BuildContext context, String provider) {
  //   Scaffold.of(context).showSnackBar(SnackBar(
  //     content: Text('$provider Button Pressed!'),
  //     backgroundColor: Colors.black26,
  //     duration: Duration(milliseconds: 400),
  //   ));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      backgroundColor: AppColors.mainColor,
      extendBodyBehindAppBar: true,
      body: LayoutBuilder(
        builder: (context, constraints) => Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                //  color: AppColors.secondMainColor.withOpacity(0.1),
                image: DecorationImage(
                  image: AssetImage('images/signup_screen_bg.jpg'),
                  colorFilter: ColorFilter.mode(
                      AppColors.mainColor.withOpacity(0.88), BlendMode.dstATop),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: constraints.maxHeight * 0.04,
                      ),
                      Text(
                        "We Only Regret The Rides ",
                        style: AppTextStyles.heading3,
                      ),
                      Text(
                        "We Didn't Take.",
                        style: AppTextStyles.heading3,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  GlassmorphicContainer(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width * 0.9,
                      borderRadius: 15,
                      blur: 8,
                      alignment: Alignment.center,
                      border: 0,
                      linearGradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.mainColor.withOpacity(0.2),
                            AppColors.secondMainColor.withOpacity(0.3),
                          ],
                          stops: [
                            0.1,
                            1,
                          ]),
                      borderGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.greenColor.withOpacity(0.5),
                          AppColors.greenColor.withOpacity(0.5),
                        ],
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GlassmorphicContainer(
                                height: constraints.maxHeight * 0.1,
                                width: constraints.maxWidth * 0.8,
                                borderRadius: 15,
                                blur: 8,
                                alignment: Alignment.center,
                                border: 0,
                                linearGradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      AppColors.secondMainColor
                                          .withOpacity(0.2),
                                      AppColors.greyColor.withOpacity(0.4),
                                    ],
                                    stops: [
                                      0.1,
                                      1,
                                    ]),
                                borderGradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    AppColors.greenColor.withOpacity(0.5),
                                    AppColors.greenColor.withOpacity(0.5),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: InkWell(
                                        onTap: () async {
                                          //await _auth.googleSignOut();
                                        },
                                        child: AvatarGlow(
                                          animate: true,
                                          glowColor: AppColors.whiteColor,
                                          endRadius: 40.0,
                                          duration:
                                              Duration(milliseconds: 2000),
                                          repeat: true,
                                          showTwoGlows: true,
                                          repeatPauseDuration:
                                              Duration(milliseconds: 100),
                                          child: Material(
                                            elevation: 8.0,
                                            shape: CircleBorder(),
                                            child: CircleAvatar(
                                              backgroundColor: Colors.grey[100],
                                              child: Image.asset(
                                                'images/GetSmartRideLogo.png',
                                                //height: 50,
                                              ),
                                              radius: 25.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      ' Get Smart Ride',
                                      style: AppTextStyles.heading3,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                onOtpLoginForRider = true;
                                showAnimatedDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  duration: Duration(seconds: 2),
                                  animationType: DialogTransitionType.scale,
                                  builder: (BuildContext context) {
                                    return OTPVerificationDialog(
                                      width: constraints.maxWidth,
                                      height: constraints.maxHeight,
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: constraints.maxHeight * 0.06,
                                width: constraints.maxWidth * 0.65,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: AppColors.whiteColor,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Image.asset(
                                      'images/mobile.png',
                                      fit: BoxFit.cover,
                                      width: 25,
                                      height: 25,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      'Mobile no login',
                                      style: AppTextStyles.heading2,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: AppColors.mainColor,
                              onTap: () async {
                                loginByGmail = true;
                                setState(() {
                                  fetchData = true;
                                });

                                googleSignIn(context).then((user) async {
                                  if (user != null) {
                                    //  Commons.riderEmail = user.email;
                                    print(".abc.abc. ${user.email}");
                                    googleEmail = user.email;
                                    googleUserName = user.username;
                                    googleUserImage = user.image;
                                    //   Commons.userName = user.username;

                                    //     Commons.image = user.image;
                                    print(
                                        "--------user not equal to null -----------");
                                    RiderInsertEmailRequest model =
                                        RiderInsertEmailRequest(
                                            ridingClientEmail: user.email);
                                    RiderApiServices api = RiderApiServices();

                                    PsResource<Otp_Response> _resource =
                                        await api.insertRider(
                                            RiderInsertEmailRequest()
                                                .toMap(model));

                                    // }

                                    if (_resource.data.status ==
                                        "Riding Client Available") {
                                      print(".abcd......rider client availble");
                                      // setState(() {
                                      //   fetchData = false;
                                      // });
                                      if (_resource.data.id == 0) {
                                        print(".abcd......deactive");
                                        FlushBar.showSimpleFlushBar(
                                            "User are deactive",
                                            context,
                                            Colors.pink,
                                            Colors.white);
                                      } else if (_resource.data.id == 1) {
                                        print(".abcd......rider client id 1");
                                        var imagee = _resource.data.image;
                                        var name = _resource.data.name;
                                        var email = _resource.data.email;

                                        RiderUser riderUser;
                                        // if (Commons.riderEmail != null &&
                                        //     Commons.userName != null) {
                                        riderUser = RiderUser(
                                            image: imagee.contains("https")
                                                ? "$imagee"
                                                : "${RiderApi.baseUrl + imagee}",
                                            email: email != null ? email : "",
                                            username: name != null ? name : "");
                                        print(".abc.abc. ${riderUser.email}");
                                        // if (Commons.riderEmail != null &&
                                        //     Commons.userName != null) {
                                        setDataToSharedPreferances(riderUser);
                                        //  }
                                        print(
                                            "IMAGE IN SHAREDDDD PREFERENCES IS....'''//////${RiderApi.baseUrl + imagee}");

                                        print(
                                            "IMAGE IN COMMONS ....'''//////${Commons.image}");
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder:
                                                        (context) =>
                                                            RiderHomeScreen()),
                                                (Route<dynamic> route) =>
                                                    false);

                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             RiderHomeScreen()));
                                      } else if (_resource.data.id == 2) {
                                        print(".abcd......rider id 2");

                                        showAnimatedDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          duration: Duration(seconds: 2),
                                          animationType:
                                              DialogTransitionType.scale,
                                          builder: (BuildContext context) {
                                            return MobileNoDialog(
                                              width: constraints.maxWidth,
                                              height: constraints.maxHeight,
                                            );
                                          },
                                        );
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //       builder: (context) =>

                                        //      .     EnterPhoneNumber(
                                        //         user: user,
                                        //       ),
                                        //     ));
                                      }
                                    } else if (_resource.data.status ==
                                        "Riding Client Not Available") {
                                      print(
                                          ".abcd......Riding Client Not Available");
                                      showAnimatedDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        duration: Duration(seconds: 2),
                                        animationType:
                                            DialogTransitionType.scale,
                                        builder: (BuildContext context) {
                                          return MobileNoDialog(
                                            width: constraints.maxWidth,
                                            height: constraints.maxHeight,
                                            // userEmail: user.email,
                                            //       userName: user.username,
                                            //       image: user.image,
                                            //       phoneNoController: widget
                                            //           .phoneNoController.text,
                                          );
                                        },
                                      );
                                      // Uuid uuid = Uuid();
                                      // var id = uuid.v4();
                                      // InsertRidingClientModel model =
                                      //     InsertRidingClientModel(
                                      //   ridingClientEmail: user.email,
                                      //   ridingClientImage: user.image,
                                      //   ridingClientNDId: user.id,
                                      //   ridingClientName: user.username,
                                      //   uUID: id,
                                      //   gender: widget.radioButtonVal,
                                      //   ridingClientPhoneNo:
                                      //       widget.phoneNoController.text,
                                      // );

                                      // PsResource<ApiResponse> _resource =
                                      //     await api.signUpRider(
                                      //         InsertRidingClientModel()
                                      //             .toMap(model));
                                      // if (_resource.data.status ==
                                      //     "Riding Client Inserted Successfully") {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => RiderInfo(
                                      //               userEmail: user.email,
                                      //               userName: user.username,
                                      //               image: user.image,
                                      //               phoneNoController: widget
                                      //                   .phoneNoController.text,
                                      //             )));
                                      //                               // setState(() {
                                      //                                 //   fetchData = false;
                                      //                                 // });
                                      //                                 // Navigator.push(
                                      //                                 //     context,
                                      //                                 //     MaterialPageRoute(
                                      //                                 //       builder: (context) =>
                                      //                                 //           EnterPhoneNumber(
                                      //                                 //         user: user,
                                      //                                 //       ),
                                      //                                 //     ));
                                      //                                 // showAnimatedDialog(
                                      //                                 //   context: context,
                                      //                                 //   barrierDismissible: true,
                                      //                                 //   duration: Duration(seconds: 2),
                                      //                                 //   animationType:
                                      //                                 //       DialogTransitionType.scale,
                                      //                                 //   builder: (BuildContext context) {
                                      //                                 //     return MobileNoDialog(
                                      //                                 //       width: constraints.maxWidth,
                                      //                                 //       height: constraints.maxHeight,
                                      //                                 //     );
                                      //                                 //   },
                                      //                                 // );
                                      //                               } else if (_resource.data.status ==
                                      //                                   "Email Already Exists") {
                                      //                                 // setState(() {
                                      //                                 //   fetchData = false;
                                      //                                 // });
                                      //                                 FlushBar.showSimpleFlushBar(
                                      //                                     "Email Already Exists", // ya status show hota ha///haan
                                      //                                     context,
                                      //                                     Colors.pink,
                                      //                                     Colors.white);
                                      //                               } else if (_resource.data.status ==
                                      //                                   "Riding Client Insertion Failed") {
                                      //                                 // setState(() {
                                      //                                 //   fetchData = false;
                                      //                                 // });
                                      //                                 FlushBar.showSimpleFlushBar(
                                      //                                     "Insertion failed",
                                      //                                     context,
                                      //                                     Colors.pink,
                                      //                                     Colors.white);
                                      //                               } else {
                                      //                                 //  Navigator.push(
                                      //                                 //     context,
                                      //                                 //     MaterialPageRoute(
                                      //                                 //       builder: (context) =>
                                      //                                 //           EnterPhoneNumber(
                                      //                                 //         user: user,
                                      //                                 //      ),
                                      //                                 //     ));
                                      //                               }
                                    }
                                  }
                                }).catchError((e) {
                                  print("$e");
                                });
                              },
                              child: Container(
                                height: constraints.maxHeight * 0.06,
                                width: constraints.maxWidth * 0.65,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: AppColors.whiteColor,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Image.asset(
                                      'images/google_logo.png',
                                      fit: BoxFit.cover,
                                      width: 25,
                                      height: 25,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      'Sign in with Google',
                                      style: AppTextStyles.heading2,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> setDataToSharedPreferances(RiderUser user) async {
    Commons.riderEmail = user.email;
    Commons.image = user.image;
    Commons.userName = user.username;
    print("--------------- Shared Preferrences ---------- ${user.email}");
    SharedPreferencesData.sharedPreferencesModel =
        await SharedPreferences.getInstance();
    SharedPreferencesData.sharedPreferencesModel
        .setString(Const.RIDER_EMAIL, user.email);
    SharedPreferencesData.sharedPreferencesModel
        .setString(Const.RiderUserName, user.username);
    SharedPreferencesData.sharedPreferencesModel
        .setString(Const.Riderimage, user.image);
  }
}
