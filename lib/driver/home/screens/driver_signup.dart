import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:uuid/uuid.dart';

import 'package:get_smart_ride_cas/api/common/ps_resource.dart';
import 'package:get_smart_ride_cas/api/common/ps_status.dart';
import 'package:get_smart_ride_cas/api/driver_api/driver_api_services.dart';
import 'package:get_smart_ride_cas/driver/constant/ps_constants.dart';
import 'package:get_smart_ride_cas/driver/home/screens/vehicle_info_page.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_signUp.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_signup_res.dart';
import 'package:get_smart_ride_cas/utils/utils.dart';
import 'package:get_smart_ride_cas/widgets/flush_bar.dart';

class DriverSignUpPage extends StatefulWidget {
  final TextEditingController phoneNoController;
  DriverSignUpPage({
    Key key,
    this.phoneNoController,
  }) : super(key: key);
  @override
  _DriverSignUpPageState createState() => _DriverSignUpPageState();
}

class _DriverSignUpPageState extends State<DriverSignUpPage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //============ Text Controllers ==========\\
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  // TextEditingController _phoneNoController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _conformPasswordController = TextEditingController();
  TextEditingController _idCardNOController = TextEditingController();
  TextEditingController _cityController = TextEditingController();

  TextStyle _textStyleBlueTheme = TextStyle(
    color: Colors.white,
  );

  TextStyle _hintStyle;

  bool filledTextStyle = false;

  Color iconColor = Colors.white;

  bool _isVisible = true;

  var outerInputBorderForTextField = OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide(color: Colors.white, width: 2),
  );

  bool textOpacity = false;

  var height, width;

  //=============== Gender Method ==============\\

  String radioValue = "male";

  int gender = 1;

  genderMethod(value) {
    if (value == 'male') {
      setState(() {
        print("male \n");
        radioValue = "male";
        gender = 1;
      });
    } else {
      setState(() {
        radioValue = "female";
        gender = 0;

        print("female \n");
      });
    }
  }

////// gmail authentication  by  Haseeb/////
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 0), () {
      setState(() {
        textOpacity = true;
      });
    });

    super.initState();
  }

  List<TranscationItem> list = List();

  @override
  Widget build(BuildContext context) {
    _hintStyle = TextStyle(
      color: Theme.of(context).colorScheme.surface,
    );

    ///
    ///

    ///
    ///
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          child: Stack(
            children: [
              Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("images/background13.jpg"),
                  ),
                ),
                //6,9,11,13
                // ============================== Blured Image =============================== \\
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: Container(
                    color: Colors.blue.withOpacity(0.5),
                  ),
                ),
              ),
              Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ///=================== Create Account Text =================\\
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.1, left: 28),
                        child: Container(
                          width: width,
                          alignment: Alignment.centerLeft,
                          child: GradientText("Create \nYour Account ",
                              gradient: LinearGradient(colors: [
                                Colors.white,
                                Colors.white,
                                Colors.white,
                              ]),
                              style: TextStyle(fontSize: 27),
                              textAlign: TextAlign.left),
                        ),
                      ),

                      ///
                      ///=============================== Driver Data ===========================\\\
                      ///

                      ///================= Name ===================\\\
                      ///
                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.05, left: 28, right: 28),
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
                              controller: _nameController,
                              keyboardType: TextInputType.text,
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: "name is required"),
                              ]),
                              decoration: InputDecoration(
                                filled: filledTextStyle,
                                fillColor: Colors.grey.withOpacity(0.6),
                                enabledBorder: outerInputBorderForTextField,
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
                                labelText: "Name",
                                labelStyle: _textStyleBlueTheme,
                                hintText: "name",
                                hintStyle: _hintStyle,
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: iconColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      ///================= Email ===================\\\
                      ///
                      Padding(
                        padding: EdgeInsets.only(top: 0, left: 28, right: 28),
                        child: AnimatedContainer(
                          curve: Curves.bounceOut,
                          duration: Duration(seconds: 3),
                          width: textOpacity == false
                              ? 0
                              : MediaQuery.of(context).size.width,
                          child: Container(
                            // color: Colors.grey,
                            height: height * 0.11,
                            child: TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              // validator: _emailController.text.length == 0 ||
                              //         _emailController.value == null
                              //     ? null
                              //     : validateEmail,
                              decoration: InputDecoration(
                                filled: filledTextStyle,
                                fillColor: Colors.grey.withOpacity(0.6),
                                enabledBorder: outerInputBorderForTextField,
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
                                labelText: "Email",
                                labelStyle: _textStyleBlueTheme,
                                hintText: "email",

                                hintStyle: _hintStyle,
                                prefixIcon: Icon(
                                  Icons.mail,
                                  color: iconColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      ///================= Phone Number ===================\\\
                      ///
                      Padding(
                        padding: EdgeInsets.only(top: 0, left: 28, right: 28),
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
                              controller: widget.phoneNoController,
                              keyboardType: TextInputType.phone,

                              readOnly: true,
                              // validator: widget.phoneNoController.text ==
                              //         widget.phoneNoController.text
                              //     ? null
                              //     : validateNo,
                              // MultiValidator([
                              //   RequiredValidator(
                              //       errorText: "Phone NO is required"),
                              // ]),
                              decoration: InputDecoration(
                                filled: filledTextStyle,
                                fillColor: Colors.grey.withOpacity(0.6),
                                enabledBorder: outerInputBorderForTextField,
                                //  focusColor: Colors.grey,
                                focusColor: Colors.grey,
                                //   enabledBorder: OutlineInputBorder(
                                //     borderSide:
                                //         BorderSide(color: Colors.grey, width: 2),
                                //    ),
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

                                hintStyle: _hintStyle,
                                prefixIcon: Icon(
                                  Icons.phone_android,
                                  color: iconColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      ///================= Password ===================\\\
                      ///
                      Padding(
                        padding: EdgeInsets.only(top: 0, left: 28, right: 28),
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
                              controller: _passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: _isVisible ? true : false,
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: "Password is Required"),
                              ]),
                              decoration: InputDecoration(
                                filled: filledTextStyle,
                                fillColor: Colors.grey.withOpacity(0.6),
                                enabledBorder: outerInputBorderForTextField,
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
                                labelText: "Password",
                                labelStyle: _textStyleBlueTheme,
                                hintText: "Password",
                                suffixIcon: InkWell(
                                  child: Icon(
                                    _isVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.white,
                                  ),
                                  onTap: () {
                                    print('visibility---------------------');
                                    _isVisible
                                        ? _isVisible = false
                                        : _isVisible = true;
                                    setState(() {});
                                  },
                                ),
                                hintStyle: _hintStyle,
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: iconColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      ///================= Conform Password ===================\\\
                      ///
                      Padding(
                        padding: EdgeInsets.only(top: 0, left: 28, right: 28),
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
                              controller: _conformPasswordController,
                              keyboardType: TextInputType.text,
                              obscureText: _isVisible ? true : false,
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: "Confirm Password is Required"),
                              ]),
                              decoration: InputDecoration(
                                filled: filledTextStyle,
                                fillColor: Colors.grey.withOpacity(0.6),
                                enabledBorder: outerInputBorderForTextField,
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
                                labelText: "Confirm Password",
                                labelStyle: _textStyleBlueTheme,
                                hintText: "Confirm Password",
                                // suffixIcon: InkWell(
                                //   child: Icon(
                                //     _isVisible
                                //         ? Icons.visibility_off
                                //         : Icons.visibility,
                                //     color: Colors.white,
                                //   ),
                                //   onTap: () {
                                //     print('visibility---------------------');
                                //     _isVisible
                                //         ? _isVisible = false
                                //         : _isVisible = true;
                                //     setState(() {});
                                //   },
                                // ),
                                hintStyle: _hintStyle,
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: iconColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      //================================ ID Card NO =============================\\

                      ///
                      Padding(
                        padding: EdgeInsets.only(top: 0, left: 28, right: 28),
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
                              controller: _idCardNOController,
                              keyboardType: TextInputType.phone,
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: "id card nO is Required"),
                              ]),
                              decoration: InputDecoration(
                                filled: filledTextStyle,
                                fillColor: Colors.grey.withOpacity(0.6),
                                enabledBorder: outerInputBorderForTextField,
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
                                labelText: "ID Card NO",
                                labelStyle: _textStyleBlueTheme,
                                hintText: "id card nO",

                                hintStyle: _hintStyle,
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: iconColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // //==============================  Gender =============================\\
                      //
                      // Padding(
                      //   padding: EdgeInsets.only(
                      //     left: width * 0.1,
                      //     right: 40,
                      //   ),
                      //   child: Row(
                      //     children: <Widget>[
                      //       Text(
                      //         'Gender',
                      //         style: TextStyle(fontSize: 17, color: iconColor),
                      //       ),
                      //       Radio(
                      //         value: 'male',
                      //         groupValue: radioValue,
                      //         hoverColor: Colors.grey,
                      //         focusColor: Colors.grey,
                      //         onChanged: (value) => genderMethod(value),
                      //         activeColor: iconColor,
                      //       ),
                      //       Text(
                      //         'Male',
                      //         style: TextStyle(color: iconColor),
                      //       ),
                      //       Radio(
                      //         value: 'female',
                      //         groupValue: radioValue,
                      //         onChanged: (value) => genderMethod(value),
                      //         activeColor: iconColor,
                      //       ),
                      //       Text(
                      //         'Female',
                      //         style: TextStyle(color: iconColor),
                      //       ),
                      //     ],
                      //   ),
                      // ),

                      ///
                      /// ================= Button Next ================== \\\
                      ///
                      Padding(
                        padding: EdgeInsets.only(
                          top: height * 0.0,
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
                                    colors: [iconColor, iconColor, iconColor],
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
                                  if (_passwordController.text ==
                                      _conformPasswordController.text) {
                                    Uuid uuid = Uuid();
                                    var id = uuid.v4();
                                    DriverSignUp model = DriverSignUp(
                                        email:
                                            "${_emailController.text.length == 0 ? widget.phoneNoController.text : _emailController.text}",
                                        name: "${_nameController.text}",
                                        password: "${_passwordController.text}",
                                        phoneNumber:
                                            "${widget.phoneNoController.text}",
                                        idCardNumber:
                                            "${_idCardNOController.text}",
                                        city: "${DriverConst.driver_city_name}",
                                        uuid: "$id",
                                        latitude: DriverConst.driverLatitude,
                                        longitude: DriverConst.driverLongitude);
                                    ApiServices api = ApiServices();

                                    Utils.checkInternetConnectivity()
                                        .then((value) async {
                                      print(
                                          " ============== method is called ===========value$value ");
                                      if (value == true) {
                                        PsResource<DriverSignUpResponse>
                                            _resource = await api.driverSignUP(
                                                model.toMap(model)
                                                //           <String, dynamic>{
                                                //   "UUID":
                                                //       "ashd-fhfdfdsaasahf-yurtwew-4675546",
                                                //   "Name": "ali",
                                                //   "Email": " ",
                                                //   "PhoneNumber": "03001111111",
                                                //   "Password": "12345678",
                                                //   "IdCardNumber": "3620175534278",
                                                //   "Latitude": 29.3544,
                                                //   "Longitude": 71.6911,
                                                //   "City": "Bahawalpur",
                                                // }
                                                );

                                        if (_resource.status ==
                                            PsStatus.SUCCESS) {
                                          if (_resource.data.status ==
                                              "Driver Inserted Successfully") {
                                            print(
                                                "${_resource.data.str1}...${_resource.data.str2}...${_resource.data.str3}....${_resource.data.str4}");
                                            DriverConst.str1 =
                                                _resource.data.str1;

                                            DriverConst.str2 =
                                                _resource.data.str2;

                                            DriverConst.str3 =
                                                _resource.data.str3;

                                            DriverConst.str4 =
                                                _resource.data.str4;

                                            DriverConst.driverlogin = false;
                                            FlushBar.showSimpleFlushBar(
                                                "Driver Inserted Successfully",
                                                context,
                                                Colors.pink,
                                                Colors.white);
                                            return Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DriverVehicleInfoPage(),
                                                ));
                                          } else if (_resource.data.status ==
                                              "Service Not Availble in your City") {
                                            FlushBar.showSimpleFlushBar(
                                                "Service Not Availble in your City",
                                                context,
                                                Colors.pink,
                                                Colors.white);
                                          } else if (_resource.data.status ==
                                              "Phone Number Already Exists") {
                                            FlushBar.showSimpleFlushBar(
                                                "Phone Number Already Exists",
                                                context,
                                                Colors.pink,
                                                Colors.white);
                                          } else if (_resource.data.status ==
                                              "Email Already Exists") {
                                            FlushBar.showSimpleFlushBar(
                                                "Email Already Exists",
                                                context,
                                                Colors.pink,
                                                Colors.white);
                                          }
                                        } else {
                                          if (_resource.errorCode ==
                                              DriverConst.ERROR_CODE_10001) {
                                            FlushBar.showSimpleFlushBar(
                                                "Have no Record",
                                                context,
                                                Colors.pink,
                                                Colors.white);
                                          }
                                        }
                                      } else {
                                        FlushBar.showSimpleFlushBar(
                                            "Check Internet",
                                            context,
                                            Colors.pink,
                                            Colors.white);
                                      }
                                    });
                                  } else {
                                    FlushBar.showSimpleFlushBar(
                                        "password must match",
                                        context,
                                        Colors.pink,
                                        Colors.white);
                                  }
                                } else {}
                              },
                              child: Text(
                                "Next",
                                style: TextStyle(
                                  color: Colors.lightBlue,
                                  fontSize: 21,
                                ),
                                textAlign: TextAlign.center,
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
      ),
    );
  }

  String validateEmail(String value) {
    String patttern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(patttern);
    // if (value.length == 0) {
    //   return 'Please enter an e-mail!';
    // }
    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid e-mail!';
    }
    return null;
  }

  String validateNo(String val) {
    return "enter opt verified no";
  }
}

class TranscationItem {
  String title;
  Icon icon;
  TranscationItem({this.title, this.icon});
}
