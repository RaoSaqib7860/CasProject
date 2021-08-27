import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get_smart_ride_cas/Commons/commons.dart';
import 'package:get_smart_ride_cas/app/theme/colors.dart';
import 'package:get_smart_ride_cas/app/theme/textStyles.dart';
import 'package:get_smart_ride_cas/rider/screens/signup_screen.dart';

import 'SmartDrawer/profile_card_screen.dart';

class EditProfileMainScreen extends StatefulWidget {
  @override
  _EditProfileMainScreenState createState() => _EditProfileMainScreenState();
}

class _EditProfileMainScreenState extends State<EditProfileMainScreen> {
  bool showPassword = false;

  bool connectivityError = false;

  TextStyle textStyle = TextStyle(fontSize: 17, color: Colors.grey);
  TextStyle textStyle2 = TextStyle(fontSize: 17, color: Colors.black);

  Color iconColor;
  Color appbarColor = Color(0xff4ADEDE);

  double textViewHeight;
  double textViewTopPadding;
  var image;

  ///                         Get Data From Server Method                    \\\

  bool isLoading = false;
  @override
  void initState() {
    // image = Commons.image;
    print("USER NAME IN EDIT......................${Commons.userName}");
    print("PHONEEE NO IN EDIT......................${Commons.riderPhoneNO}");
    print("EMAILL NO IN EDIT......................${Commons.riderEmail}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    textViewHeight = height * 0.07;
    textViewTopPadding = 0.01;
    double paddingleft = width * 0;
    iconColor = Colors.red;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: AppColors.mainColor,
      ),
      body: Container(
        height: height,
        width: width,
        child: Padding(
          padding: EdgeInsets.only(left: width * 0.12, right: width * 0.12),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.1,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: width * 0.33,
                      height: height * 0.23,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        boxShadow: [
                          // BoxShadow(
                          //     spreadRadius: 2,
                          //     blurRadius: 10,
                          //     color: Colors.black.withOpacity(0.1),
                          //     offset: Offset(0, 10))
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image:
                              //  ProfileCard.image != null
                              //     ? FileImage(ProfileCard.image)
                              //     : loginByGmail == true
                              //         ? NetworkImage("${Commons.image}")
                              //         : SignupScreen.onOtpLoginForRider == true
                              //             ?
                              (Commons.image != null)
                                  ? NetworkImage("${Commons.image}")
                                  : NetworkImage(
                                      "https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png"),

                          // SignupScreen.onOtpLoginForRider == true
                          //     ? NetworkImage(
                          //         "${RiderApi.baseUrl + Commons.image}")
                          //     :
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //    buildTextField("Full Name",
              //        gooogleSignIn.currentUser.displayName, false),
              //     buildTextField(
              //         "E-mail", gooogleSignIn.currentUser.email, false),
              ///                Doctor Name      \\\
              ///
              ///
              Padding(
                padding: EdgeInsets.only(
                    top: height * 0.1, left: paddingleft, right: paddingleft),
                child: Container(
                  alignment: Alignment.centerLeft,
                  height: height * 0.1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        "Name",
                        style: textStyle,
                        maxLines: 1,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.0, top: width * 0.01),
                        child: AutoSizeText(
                          "${Commons.userName}",
                          maxFontSize: 15,
                          minFontSize: 10,
                          style: TextStyle(fontSize: 15),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                thickness: 1,
              ),

              ///                             Email                        \\\\\\\

              Commons.riderEmail == null
                  ? Padding(
                      padding: EdgeInsets.only(
                          top: height * 0.02,
                          left: paddingleft,
                          right: paddingleft),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: height * 0.1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              "Phone no",
                              style: textStyle,
                              maxLines: 1,
                            ),
                            SizedBox(height: height * 0.02),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: width * 0.0, top: height * 0.01),
                              child: AutoSizeText(
                                "${Commons.riderPhoneNO}",
                                maxFontSize: 15,
                                minFontSize: 10,
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(
                          top: height * 0.02,
                          left: paddingleft,
                          right: paddingleft),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: height * 0.1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              "Email",
                              style: textStyle,
                              maxLines: 1,
                            ),
                            SizedBox(height: height * 0.02),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: width * 0.0, top: height * 0.01),
                              child: AutoSizeText(
                                "${Commons.riderEmail}",
                                maxFontSize: 15,
                                minFontSize: 10,
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

              Divider(
                thickness: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: AppColors.mainColor,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: AppTextStyles.heading2small),
      ),
    );
  }
}
