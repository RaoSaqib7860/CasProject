// import 'dart:ui';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:form_field_validator/form_field_validator.dart';
// import 'package:get_smart_ride_cas/Commons/constant.dart';
// import 'package:get_smart_ride_cas/Commons/shared_preferences.dart';
// import 'package:get_smart_ride_cas/api/common/ps_resource.dart';
// import 'package:get_smart_ride_cas/api/rider_api/rider_api_services.dart';
// import 'package:get_smart_ride_cas/app/theme/colors.dart';
// import 'package:get_smart_ride_cas/app/theme/textStyles.dart';
// import 'package:get_smart_ride_cas/rider/home/rider_home_screen.dart';
// import 'package:get_smart_ride_cas/rider/objects/ApiResponse.dart';
// import 'package:get_smart_ride_cas/rider/objects/insert_phone_no.dart';
// import 'package:get_smart_ride_cas/rider/screens/signup_screen.dart';
// import 'package:get_smart_ride_cas/utils/utils.dart';
// import 'package:get_smart_ride_cas/widgets/flush_bar.dart';
// import 'package:glassmorphism/glassmorphism.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:get_smart_ride_cas/Commons/commons.dart';

// class EnterPhoneNumber extends StatefulWidget {
//   final RiderUser user;
//   EnterPhoneNumber({
//     this.user,
//   });
//   @override
//   _EnterPhoneNumberState createState() => _EnterPhoneNumberState();
// }

// class _EnterPhoneNumberState extends State<EnterPhoneNumber> {
//   @override
//   Widget build(BuildContext context) {
//     final _phoneNumberTxt = TextEditingController();

//     return Scaffold(
//       backgroundColor: AppColors.whiteColor.withOpacity(0.85),
//       body: LayoutBuilder(
//         builder: (context, constraints) => Stack(
//           alignment: Alignment.center,
//           children: [
//             Container(
//               height: constraints.maxHeight,
//               width: constraints.maxWidth,
//               child: Image.asset(
//                 'images/loginnnnnn.png',
//                 fit: BoxFit.cover,
//                 filterQuality: FilterQuality.high,
//               ),
//             ),
//             Positioned(
//               top: constraints.maxHeight * 0.15,
//               child: Align(
//                 alignment: Alignment.topCenter,
//                 child: GlassmorphicContainer(
//                   height: constraints.maxHeight * 0.08,
//                   width: constraints.maxWidth * 0.9,
//                   borderRadius: 15,
//                   blur: 2,
//                   alignment: Alignment.center,
//                   border: 0,
//                   linearGradient: LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                       colors: [
//                         AppColors.secondMainColor.withOpacity(0.4),
//                         AppColors.mainColor.withOpacity(0.8),
//                       ],
//                       stops: [
//                         0.1,
//                         1,
//                       ]),
//                   borderGradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [
//                       AppColors.whiteColor.withOpacity(0.5),
//                       AppColors.whiteColor.withOpacity(0.5),
//                     ],
//                   ),
//                   child: Center(
//                     child: Text(
//                       "Travel makes one modest. ",
//                       style: AppTextStyles.heading3White,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: constraints.maxHeight * 0.05,
//               child: Align(
//                 alignment: Alignment.bottomCenter,
//                 child: GlassmorphicContainer(
//                   height: MediaQuery.of(context).size.height * 0.2,
//                   width: MediaQuery.of(context).size.width * 0.9,
//                   borderRadius: 15,
//                   blur: 1,
//                   alignment: Alignment.center,
//                   border: 0,
//                   linearGradient: LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                       colors: [
//                         AppColors.mainColor.withOpacity(0.78),
//                         AppColors.secondMainColor.withOpacity(0.6),
//                       ],
//                       stops: [
//                         0.1,
//                         1,
//                       ]),
//                   borderGradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [
//                       AppColors.greenColor.withOpacity(0.5),
//                       AppColors.greenColor.withOpacity(0.5),
//                     ],
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         GlassmorphicContainer(
//                           height: MediaQuery.of(context).size.height * 0.08,
//                           width: MediaQuery.of(context).size.width * 0.9,
//                           borderRadius: 25,
//                           blur: 5,
//                           alignment: Alignment.center,
//                           border: 0,
//                           linearGradient: LinearGradient(
//                               begin: Alignment.topLeft,
//                               end: Alignment.bottomRight,
//                               colors: [
//                                 AppColors.secondMainColor.withOpacity(0.0),
//                                 AppColors.mainColor.withOpacity(0.0),
//                               ],
//                               stops: [
//                                 0.1,
//                                 1,
//                               ]),
//                           borderGradient: LinearGradient(
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                             colors: [
//                               AppColors.greenColor.withOpacity(0.5),
//                               AppColors.greenColor.withOpacity(0.5),
//                             ],
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(5.0),
//                             child: TextFormField(
//                               controller: _phoneNumberTxt,
//                               validator: MultiValidator([
//                                 RequiredValidator(
//                                     errorText: 'Phone Number is required'),
//                                 PatternValidator(
//                                     r'^((+|00)?218|0?)?(9[0-9]{8})$',
//                                     errorText:
//                                         'phone number must start with +92')
//                               ]),
//                               decoration: InputDecoration(
//                                 contentPadding: const EdgeInsets.all(16.0),
//                                 prefixIcon: Container(
//                                   width: 65,
//                                   // padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
//                                   margin: const EdgeInsets.only(right: 12.0),
//                                   decoration: BoxDecoration(
//                                       color: AppColors.greyColor,
//                                       borderRadius: BorderRadius.only(
//                                           topLeft: Radius.circular(30.0),
//                                           bottomLeft: Radius.circular(30.0),
//                                           topRight: Radius.circular(30.0),
//                                           bottomRight: Radius.circular(10.0))),
//                                   child: Center(
//                                       child: Icon(Icons.phone_android,
//                                           size: 40,
//                                           color: AppColors.mainColor)),
//                                 ),
//                                 hintText: "Phone Number",
//                                 hintStyle: AppTextStyles.heading2.copyWith(
//                                     fontSize: 18,
//                                     color:
//                                         AppColors.whiteColor.withOpacity(0.8)),
//                                 border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(30.0),
//                                     borderSide: BorderSide.none),
//                                 filled: true,
//                                 fillColor: Colors.white.withOpacity(0.35),
//                               ),
//                             ),
//                           ),
//                         ),
//                         RaisedButton(
//                           elevation: 3,
//                           splashColor: AppColors.greenColor.withOpacity(0.5),
//                           color: AppColors.greyColor,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15)),
//                           onPressed: () {
//                             InsertingRidingClientPhoneNumber model =
//                                 InsertingRidingClientPhoneNumber(
//                                     ridingClientEmail: widget.user.email,
//                                     ridingClientPhoneNumber:
//                                         _phoneNumberTxt.text);

//                             Utils.checkInternetConnectivity()
//                                 .then((value) async {
//                               if (value == true) {
//                                 RiderApiServices _api = RiderApiServices();
//                                 PsResource<ApiResponse> _resource =
//                                     await _api.insertRiderPhoneNumber(
//                                         InsertingRidingClientPhoneNumber()
//                                             .toMap(model));

//                                 if (_resource.data.status ==
//                                     "Riding Client Phone Number Updated Successfully") {
//                                   if (_resource.data.id == 1) {
//                                     setDataToSharedPreferances(
//                                         widget.user, _phoneNumberTxt.text);
//                                     return Navigator.push(context,
//                                         MaterialPageRoute(
//                                       builder: (context) {
//                                         return RiderHomeScreen(
//                                           currentUserEmail: widget.user.email,
//                                           currentUserPhoneNumber:
//                                               _phoneNumberTxt.text,
//                                         );
//                                       },
//                                     ));
//                                   } else {
//                                     FlushBar.showSimpleFlushBar("Phone No not ",
//                                         context, Colors.pink, Colors.white);
//                                   }
//                                 } else if (_resource.data.status ==
//                                     "Phone Number Already Exists") {
//                                   FlushBar.showSimpleFlushBar(
//                                       "Phone Number Already Exists",
//                                       context,
//                                       Colors.pink,
//                                       Colors.white);
//                                 } else if (_resource.data.status ==
//                                     "Email Not Registed") {}
//                               } else {
//                                 FlushBar.showSimpleFlushBar(
//                                     "Check Connectivity",
//                                     context,
//                                     Colors.pink,
//                                     Colors.white);
//                               }
//                             });

//                             // print(_phoneNumberTxt.text);
//                             // InsertingRidingClientPhoneNumber(
//                             //   ridingClientEmail:
//                             //       gooogleSignIn.currentUser.email,
//                             //   ridingClientPhoneNumber: _phoneNumberTxt.text,
//                             // );

//                             // String email = gooogleSignIn.currentUser.email;
//                             // InsertingRidingClientPhoneNumber model2 =
//                             //     InsertingRidingClientPhoneNumber(
//                             //   ridingClientEmail: email,
//                             //   ridingClientPhoneNumber: _phoneNumberTxt.text,
//                             // );

//                             // userPhoneNumberPostMethod(model2).then((value) {
//                             //   print("........ statusOfuserMobile ........${value.status}");

//                             //   print("........ ID3 ........${value.id}");
//                             // });
//                             // googleSignIn()
//                             //     .whenComplete(() => Navigator.pushReplacement(
//                             //         context,
//                             //         MaterialPageRoute(
//                             //           builder: (context) => V2homeScreen(
//                             //             currentUserPhoneNumber:
//                             //                 _phoneNumberTxt.text,
//                             //             currentUserEmail:
//                             //                 gooogleSignIn.currentUser.email,
//                             //           ),
//                             //         )));
//                           },

//                           // onPressed: () => googleSignIn().whenComplete(
//                           //   () => Navigator.pushReplacement(
//                           //     context,
//                           //     MaterialPageRoute(
//                           //       builder: (context) => V2homeScreen(),
//                           //     ),
//                           //   ),
//                           // ),
//                           child: Text(
//                             "Confirm",
//                             style: AppTextStyles.heading1,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> setDataToSharedPreferances(
//       RiderUser user, String phoneNo) async {
//     Commons.riderEmail = user.email;
//     Commons.riderPhoneNO = phoneNo;

//     SharedPreferencesData.sharedPreferencesModel =
//         await SharedPreferences.getInstance();
//     SharedPreferencesData.sharedPreferencesModel
//         .setString(Const.RIDER_EMAIL, user.email);
//     SharedPreferencesData.sharedPreferencesModel
//         .setString(Const.RIDER_PHONE_NO, phoneNo);
//   }
// }

// // Route _routeToHomeScreen() {
// //   return PageRouteBuilder(
// //     fullscreenDialog: true,
// //     transitionDuration: Duration(milliseconds: 250),
// //     pageBuilder: (context, animation, secondaryAnimation) => SignupScreen(),
// //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
// //       var offsetAnimation = animation;
// //
// //       return SharedAxisTransition(
// //           animation: offsetAnimation,
// //           secondaryAnimation: secondaryAnimation,
// //           fillColor: AppColors.mainColor,
// //           child: SignupScreen(),
// //           transitionType: SharedAxisTransitionType.vertical);
// //
// //       //   FadeTransition(
// //       //   opacity: offsetAnimation,
// //       //   child: child,
// //       // );
// //     },
// //   );
// // }
