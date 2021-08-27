import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get_smart_ride_cas/Commons/constant.dart';
import 'package:get_smart_ride_cas/Commons/shared_preferences.dart';
import 'package:get_smart_ride_cas/app/theme/colors.dart';
import 'package:get_smart_ride_cas/app/theme/textStyles.dart';
import 'package:get_smart_ride_cas/driver/home/screens/login_page.dart';
import 'package:get_smart_ride_cas/rider/screens/SmartDrawer/mobileNoDialog.dart';
import 'package:get_smart_ride_cas/rider/screens/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChooseAccountType extends StatefulWidget {
  final bool isActive;
  static String riderSignUp;
  const ChooseAccountType({Key key, this.isActive}) : super(key: key);

  @override
  _ChooseAccountTypeState createState() => _ChooseAccountTypeState();
}

class _ChooseAccountTypeState extends State<ChooseAccountType> {
  bool _isActive = false;
  @override
  void initState() {
    ChooseAccountType.riderSignUp = "Rider signUp";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      //  backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text('Choose profile type'),
        centerTitle: true,
        toolbarOpacity: 0.95,
        backgroundColor: AppColors.mainColor.withOpacity(0.85),
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => Column(
          //   alignment: Alignment.topCenter,
          children: [
            Flexible(
              flex: 30,
              child: Container(
                //  alignment: Alignment.topCenter,
                // width: constraints.maxWidth * 0.2,
                // height: constraints.maxHeight * 0.2,
                decoration: BoxDecoration(
                    //   shape: BoxShape.circle,
                    //   color: Colors.green,
                    image: DecorationImage(
                        image: AssetImage("images/gsrLogo.jpg"))),
              ),
            ),
            Flexible(
              flex: 70,
              child: Container(
                // color: Colors.red,
                //  margin: EdgeInsets.only(top: constraints.maxHeight * 0.08),
                height: constraints.maxHeight * 0.6,
                width: constraints.maxWidth,
                //color:Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.deferToChild,
                      onLongPress: () => Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text('dont hold it long'),
                          backgroundColor: AppColors.mainColor,
                          behavior: SnackBarBehavior.fixed,
                          elevation: 5,
                          duration: Duration(milliseconds: 500),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _isActive = !_isActive;
                        });

                        setDataToSharedPreferences("Rider");
                        // showAnimatedDialog(
                        //   context: context,
                        //   barrierDismissible: true,
                        //   duration: Duration(seconds: 2),
                        //   animationType: DialogTransitionType.scale,
                        //   builder: (BuildContext context) {
                        //     return MobileNoDialog(
                        //       width: constraints.maxWidth,
                        //       height: constraints.maxHeight,
                        //     );
                        //   },
                        // );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupScreen(),
                            ));
                      },
                      child: Card(
                        elevation: 5,
                        color: AppColors.greenColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Container(
                          height: constraints.maxHeight * 0.5,
                          width: constraints.maxWidth * 0.4,
                          decoration: BoxDecoration(
                            color: AppColors.secondMainColor.withOpacity(0.85),
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: AssetImage('images/GetSmartRideLogo.png'),
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('images/rider_signup.png'),
                                Divider(),
                                Text(
                                  'Rider',
                                  style: AppTextStyles.heading2.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: InkWell(
                        onTap: () {
                          setDataToSharedPreferences("Driver");
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return DriverLoginPage();
                            },
                          ));
                        },
                        child: Card(
                          elevation: 5,
                          color: AppColors.greenColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                            height: constraints.maxHeight * 0.5,
                            width: constraints.maxWidth * 0.4,
                            decoration: BoxDecoration(
                              color: AppColors.secondMainColor.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('images/driver_signup.png'),
                                  Divider(),
                                  Text(
                                    'Driver',
                                    style: AppTextStyles.heading2.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> setDataToSharedPreferences(String userType) async {
    SharedPreferencesData.sharedPreferencesModel =
        await SharedPreferences.getInstance();
    SharedPreferencesData.sharedPreferencesModel
        .setString(Const.USER_TYPE, userType);
    SharedPreferencesData.sharedPreferencesModel
        .setString(Const.APP_DESCRIPTION, "true");
  }
}
