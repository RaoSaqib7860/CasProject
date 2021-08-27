import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get_smart_ride_cas/app/theme/colors.dart';
import 'package:get_smart_ride_cas/app/theme/textStyles.dart';
import 'package:get_smart_ride_cas/rider/firebaseAuth/authentications.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../signup_screen.dart';

class SettingsCard extends StatefulWidget {
  @override
  _SettingsCardState createState() => _SettingsCardState();
}

class _SettingsCardState extends State<SettingsCard> {
  bool showPassword = false;
  final Auth _auth = Auth();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        height: constraints.maxHeight,
        width: constraints.maxWidth,
        color: AppColors.greyColor.withOpacity(0.5),
        child: FadeInLeft(
          animate: true,
          child: Card(
            color: AppColors.secondMainColor.withOpacity(0.5),
            margin: const EdgeInsets.only(
                left: 100, bottom: 185, top: 170, right: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
            child: Center(
              child: LayoutBuilder(
                builder: (context, constraints) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Container(
                    height: constraints.maxHeight,
                    width: constraints.maxWidth,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Center(
                        child: SettingsList(
                          physics: BouncingScrollPhysics(),
                          darkBackgroundColor:
                              AppColors.mainColor.withOpacity(0.5),
                          backgroundColor:
                              AppColors.secondMainColor.withOpacity(0.5),
                          sections: [
                            SettingsSection(
                              title: 'Settings',
                              titleTextStyle: AppTextStyles.heading2,
                              tiles: [
                                SettingsTile(
                                  title: 'Language',
                                  titleTextStyle: AppTextStyles.description1,
                                  subtitle: 'English',
                                  leading: Icon(
                                    Icons.language,
                                    color: AppColors.mainColor,
                                  ),
                                  onPressed: (BuildContext context) {},
                                ),
                                SettingsTile(
                                  title: 'Phone Number',
                                  titleTextStyle: AppTextStyles.description1,
                                  subtitle: '03047780110',
                                  leading: Icon(
                                    Icons.phone,
                                    color: AppColors.mainColor,
                                  ),
                                  onPressed: (BuildContext context) {},
                                ),
                                SettingsTile(
                                  title: 'Location',
                                  titleTextStyle: AppTextStyles.description1,
                                  subtitle: 'Bahawalpur',
                                  leading: Icon(
                                    Icons.location_on,
                                    color: AppColors.mainColor,
                                  ),
                                  onPressed: (BuildContext context) {},
                                ),
                                SettingsTile(
                                  title: 'Theme',
                                  titleTextStyle: AppTextStyles.description1,
                                  leading: Icon(
                                    Icons.filter_frames,
                                    color: AppColors.mainColor,
                                  ),
                                  onPressed: (BuildContext context) {},
                                ),
                                SettingsTile(
                                  title: 'Sign out',
                                  titleTextStyle: AppTextStyles.description1,
                                  leading: Icon(
                                    Icons.logout,
                                    color: AppColors.mainColor,
                                  ),
                                  onPressed: (context) {
                                    _auth.googleSignOut();
                                    setDataToSharedPreferances();
                                    Navigator.pushAndRemoveUntil(context,
                                        MaterialPageRoute(
                                      builder: (context) {
                                        return SignupScreen();
                                      },
                                    ), (route) => false);
                                  },
                                ),
                                SettingsTile(
                                  title: 'Terms of Services',
                                  titleTextStyle: AppTextStyles.description1,
                                  leading: Icon(
                                    Icons.privacy_tip,
                                    color: AppColors.mainColor,
                                  ),
                                  onPressed: (BuildContext context) {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> setDataToSharedPreferances() async {
    SharedPreferences model = await SharedPreferences.getInstance();
    model.clear();
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
                      color: Colors.grey,
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
