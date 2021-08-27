import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get_smart_ride_cas/Commons/commons.dart';
import 'package:get_smart_ride_cas/Commons/constant.dart';
import 'package:get_smart_ride_cas/Commons/shared_preferences.dart';
import 'package:get_smart_ride_cas/api/common/ps_resource.dart';
import 'package:get_smart_ride_cas/api/rider_api/rider_api.dart';
import 'package:get_smart_ride_cas/api/rider_api/rider_api_services.dart';
import 'package:get_smart_ride_cas/app/theme/colors.dart';
import 'package:get_smart_ride_cas/rider/home/rider_home_screen.dart';
import 'package:get_smart_ride_cas/rider/objects/ApiResponse.dart';
import 'package:get_smart_ride_cas/rider/objects/insertion_of_riding_client.dart';
import 'package:get_smart_ride_cas/rider/objects/otp_response.dart';
import 'package:get_smart_ride_cas/rider/objects/ridingClientPhoneNumberForOtp.dart';
import 'package:get_smart_ride_cas/rider/screens/riderImageUpload.dart';
import 'package:get_smart_ride_cas/rider/screens/signup_screen.dart';
import 'package:get_smart_ride_cas/utils/utils.dart';
import 'package:get_smart_ride_cas/widgets/flush_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart';

class RiderInfoPageAfterOtp extends StatefulWidget {
  // String riderName;
  // String currentUserEmail;
  // final String riderImage;
  final TextEditingController phoneNumber;
  // static File image;
  // final String radioValue;
  int radioValue;
  RiderInfoPageAfterOtp({Key key, this.phoneNumber}) : super(key: key);

  @override
  _RiderInfoPageAfterOtpState createState() => _RiderInfoPageAfterOtpState();
}

class _RiderInfoPageAfterOtpState extends State<RiderInfoPageAfterOtp> {
  int _groupValue = 1;
  TextEditingController _controller = TextEditingController();
  TextEditingController _nameControllerFirstName = TextEditingController();
  TextEditingController _nameControllerLastName = TextEditingController();
  TextEditingController _phoneNoController = TextEditingController();

  TextStyle _textStyleBlueTheme = TextStyle(
    color: Colors.white,
  );
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextStyle _hintStyle;

  bool filledTextStyle = false;
  File imageUpload;
  Color iconColor = Colors.white;
  File image;
  bool _isVisible = true;
  String imageName;
  var outerInputBorderForTextField = OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide(color: Colors.white, width: 2),
  );

  bool textOpacity = false;
  @override
  void initState() {
    // if (widget.userName != null) {
    //   RiderInfo.riderEmail = widget.userEmail;
    // }
    //print("PHONE NO............${widget.phoneNoController}");
    super.initState();

    //method
  }

  final picker = ImagePicker();

  Future getImage() async {
    //
    print(" I M A G E...........  ");
    //isLoading = true;
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
        imageName = basename(image.path);
        return image;
      });
      // isLoading = false;

      print(" I M A G E...........  ${image.path.toString()}");
    } else {
      print("NO IMAGE SELECTED");

      //  return;
      //   ab check kra ab hwi hai change
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Align(
        alignment: Alignment.topCenter,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              //  crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.08,
                ),
                Text(
                  "Rider signup",
                  style: GoogleFonts.mina(fontSize: 20),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 8,
                  child: Container(
                    width: width * 0.35,
                    height: height * 0.18,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: Theme.of(context).accentColor, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                        ),
                      ],
                      image: DecorationImage(
                          image: image != null
                              ? FileImage(image)
                              : NetworkImage(
                                  "https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png"),
                          fit: BoxFit.cover),
                    ),
                    // child: Align(
                    //     alignment: Alignment.bottomRight,
                    //     child: InkWell(
                    //       onTap: () async {},
                    //       child: Icon(Icons.image, color: Colors.white),
                    //     )),
                    child: InkWell(
                        onTap: () async {
                          await getImage();
                          if (image != null) {
                            print(
                                "=========Image updaete method is Call =====");
                            print(
                                "Image is not null ===================${image.toString()}");
                            RiderApiServices api = RiderApiServices();
                            Utils.checkInternetConnectivity()
                                .then((value) async {
                              if (value == true) {
                                RiderImageUploadResponse _resource =
                                    await api.riderImageUpload(
                                        widget.phoneNumber.text, image);
                                print(
                                    " Response from server${_resource.status}");

                                if (_resource.status ==
                                    "File Uploaded Successfully") {
                                  // RiderUser user = RiderUser(image: image);
                                  // setDataToSharedPreferances(user);
                                  // RiderApiServices api = RiderApiServices();
                                  // Uuid uuid = Uuid();
                                  // var id = uuid.v4();
                                  // InsertRidingPhoneNoForOtp model =
                                  //     InsertRidingPhoneNoForOtp(
                                  //   uUID: id,
                                  //   ridingClientPhoneNo:
                                  //       widget.phoneNumber.text,
                                  // );
                                  // PsResource<Otp_Response> _resource = await api
                                  //     .loginClientPhoneNoAfterOTPVerify(
                                  //         InsertRidingPhoneNoForOtp()
                                  //             .toMap(model));
                                  //  image = Commons.image;
                                  FlushBar.showSimpleFlushBar(
                                      "file uploaded successfully",
                                      context,
                                      Colors.green,
                                      Colors.white);
                                  // setState(() {
                                  //   isLoading = false;
                                  //   //    ProfileCard();
                                  // });

                                  //

                                }
                              } else {
                                FlushBar.showSimpleFlushBar("check connection",
                                    context, Colors.red, Colors.white);
                              }
                            });
                          } else {
                            FlushBar.showSimpleFlushBar("Select Image", context,
                                Colors.red, Colors.white);
                          }
                        },
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: Icon(Icons.image))),
                  ),
                ),
                SizedBox(height: height * 0.03),
                Container(
                  width: width * 0.8,
                  height: height * 0.09,
                  child: TextFormField(
                    validator: MultiValidator([
                      RequiredValidator(errorText: "enter first name"),
                    ]),
                    controller: _nameControllerFirstName,
                    decoration: InputDecoration(
                      hintText: 'Firstname',
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.mainColor),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.mainColor),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.03),
                Container(
                  width: width * 0.8,
                  //    height: height * 0.09,
                  child: TextFormField(
                    validator: MultiValidator([
                      RequiredValidator(errorText: "enter last name"),
                    ]),
                    controller: _nameControllerLastName,
                    decoration: InputDecoration(
                      hintText: 'Lastname',
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.mainColor),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.mainColor),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.03),
                Container(
                  width: width * 0.8,
                  //  height: height * 0.09,
                  child: TextFormField(
                    readOnly: true,
                    controller: widget.phoneNumber,
                    decoration: InputDecoration(
                      hintText: 'phonenumber',
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.mainColor),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.mainColor),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                _myRadioButton(
                  title: "female",
                  color: AppColors.mainColor,
                  value: 0,
                  onChanged: (newValue) =>
                      setState(() => _groupValue = newValue),
                ),
                _myRadioButton(
                  title: "male",
                  value: 1,
                  onChanged: (newValue) =>
                      setState(() => _groupValue = newValue),
                ),
                _nameControllerFirstName.text.length != 0 &&
                        _nameControllerLastName.text.length != 0
                    ? InkWell(
                        onTap: () async {
                          Uuid uuid = Uuid();
                          var id = uuid.v4();
                          RiderApiServices api = RiderApiServices();
                          InsertRidingClientModel model =
                              InsertRidingClientModel(
                            ridingClientEmail: widget.phoneNumber.text,
                            ridingClientImage: " ",
                            ridingClientNDId: id,
                            ridingClientName: _nameControllerFirstName.text +
                                " " +
                                _nameControllerLastName.text,
                            uUID: id,
                            gender: _groupValue,
                            ridingClientPhoneNo: widget.phoneNumber.text,
                          );
                          if (image != null) {
                            PsResource<ApiResponse> _resource =
                                await api.signUpRider(
                                    InsertRidingClientModel().toMap(model));
                            if (_resource.data.status ==
                                "Riding Client Inserted Successfully") {
                              Utils.checkInternetConnectivity()
                                  .then((value) async {
                                if (value == true) {
                                  RiderImageUploadResponse _resource =
                                      await api.riderImageUpload(
                                          widget.phoneNumber.text, image);
                                  print(
                                      " Response from server${_resource.status}");
                                }
                              });
                              RiderUser user = RiderUser(
                                  //    email: "a",
                                  id: id,
                                  image:
                                      "${RiderApi.baseUrl + image.path.toString()}",
                                  phoneNo: widget.phoneNumber.text,
                                  username: _nameControllerFirstName.text +
                                      _nameControllerLastName.text);
                              setDataToSharedPreferances(user);
                              // print(
                              //     "image in shared preferences........................................$image");

                              print(
                                  "image in shared preferences Commonss........................................${Commons.image}");
                              if (formKey.currentState.validate() &&
                                  image != null) {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return SignupScreen();
                                }));
                   FlushBar.showSimpleFlushBar(
                                 "this user is registered now,do mobile no login to proceed", // ya status show hota ha///haan
                                  context,
                                  Colors.green,
                                  Colors.white);               
                              }
                            } else if (_resource.data.status ==
                                'Phone Number Already Exists') {
                              FlushBar.showSimpleFlushBar(
                                  "The phone no you entered is already registered for another account", // ya status show hota ha///haan
                                  context,
                                  Colors.red,
                                  Colors.white);
                            } else if (_resource.data.status ==
                                "Email Already Exists") {
                              // setState(() {
                              //   fetchData = false;
                              // });
                              FlushBar.showSimpleFlushBar(
                                  "Email Already Exists",
                                  context,
                                  Colors.pink,
                                  Colors.white);
                            } else if (_resource.data.status ==
                                "Riding Client Insertion Failed") {
                              // setState(() {
                              //   fetchData = false;
                              // });
                              FlushBar.showSimpleFlushBar("Insertion failed",
                                  context, Colors.pink, Colors.white);
                            }
                          } else {
                            FlushBar.showSimpleFlushBar("please add image",
                                context, Colors.red, Colors.white);
                          }

                          //  RiderApiServices api = RiderApiServices();
                          // Utils.checkInternetConnectivity().then((value) async {
                          //   if (value == true) {
                          //     RiderImageUploadResponse _resource =
                          //         await api.riderImageUpload(Commons.riderEmail,
                          //             RiderInfoPageAfterOtp.image);
                          //     print(" Response from server${_resource.status}");

                          //   }

                          // });
                        },
                        child: Container(
                          width: width * 0.8,
                          height: height * 0.07,
                          decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                              child: Text(
                            "Done",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
    // );
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

  Widget _myRadioButton(
      {String title, int value, Function onChanged, Color color}) {
    return RadioListTile(
      value: value,
      activeColor: color,
      groupValue: _groupValue,
      onChanged: onChanged,
      title: Text(title),
    );
  }
}
