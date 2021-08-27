import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gradient_text/gradient_text.dart';

import 'package:get_smart_ride_cas/api/common/ps_resource.dart';
import 'package:get_smart_ride_cas/api/common/ps_status.dart';
import 'package:get_smart_ride_cas/api/driver_api/driver_api_services.dart';
import 'package:get_smart_ride_cas/app/theme/colors.dart';
import 'package:get_smart_ride_cas/driver/constant/ps_constants.dart';
import 'package:get_smart_ride_cas/driver/home/screens/driver_profile.dart';
import 'package:get_smart_ride_cas/driver/repository/driver_profile/bloc/driverprofile_bloc.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_profile.dart';
import 'package:get_smart_ride_cas/rider/objects/ApiResponse.dart';
import 'package:get_smart_ride_cas/utils/utils.dart';
import 'package:get_smart_ride_cas/widgets/flush_bar.dart';

class DriverProfileUpdatePage extends StatefulWidget {
  List<DriverProfileModel> model;
  DriverProfileUpdatePage({
    Key key,
    this.model,
  }) : super(key: key);
  @override
  _DriverProfileUpdatePageState createState() =>
      _DriverProfileUpdatePageState();
}

class _DriverProfileUpdatePageState extends State<DriverProfileUpdatePage> {
  var height, width;

  //======================================
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  double textFieldHeight = 60;
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

  bool isLoading = false;

  //============ Text Controllers ==========\\
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  TextStyle _hintStyle;

  bool filledTextStyle = false;

  ApiServices _api = ApiServices();

  var outerInputBorderForTextField = OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide(color: Colors.lightBlue, width: 2),
  );
  String validateEmail(String value) {
    String patttern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(patttern);
    if (value.length == 0) {
      return 'Please enter an e-mail!';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter a valid e-mail!';
    }
    return null;
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 0), () {
      setState(() {
        textOpacity = true;
      });
    });
    print("........N  A   M    E...........${widget.model[0].name}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: AppColors.secondMainColor,
        title: Text("Update Profile"),
      ),
      body: Container(
        // alignment: Alignment.center,
        height: height,
        width: width,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //      crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ///================= Name ===================\\\
              ///
              // Padding(
              //   padding:
              //       EdgeInsets.only(top: height * 0.0, left: 28, right: 28),
              //   child: AnimatedContainer(
              //     curve: Curves.bounceOut,
              //     duration: Duration(seconds: 3),
              //     width: textOpacity == false
              //         ? 0
              //         : MediaQuery.of(context).size.width,
              //     child: Container(
              //       //   color: Colors.grey,
              //       //  height: height * 0.11,
              //       child: TextFormField(
              //         controller: _nameController,
              //         keyboardType: TextInputType.text,
              //         validator: MultiValidator([
              //           RequiredValidator(errorText: "name is required"),
              //         ]),
              //         decoration: InputDecoration(
              //           filled: filledTextStyle,
              //           fillColor: Colors.grey.withOpacity(0.6),
              //           enabledBorder: outerInputBorderForTextField,
              //           //  focusColor: Colors.grey,
              //           isDense: true,
              //           border: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(30),
              //             borderSide:
              //                 BorderSide(color: Colors.lightBlue, width: 2),
              //           ),
              //           focusedBorder: OutlineInputBorder(
              //               borderRadius: BorderRadius.circular(30),
              //               borderSide: BorderSide(color: iconColor, width: 2)),
              //           labelText: "Name",
              //           labelStyle: _textStyleBlueTheme,
              //           hintText: "name",
              //           hintStyle: _hintStyle,
              //           prefixIcon: Icon(
              //             Icons.person,
              //             color: iconColor,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),

              ///================= Email ===================\\\
              ///
              Padding(
                padding:
                    EdgeInsets.only(top: height * 0.05, left: 28, right: 28),
                child: AnimatedContainer(
                  curve: Curves.bounceOut,
                  duration: Duration(seconds: 3),
                  width: textOpacity == false
                      ? 0
                      : MediaQuery.of(context).size.width,
                  child: Container(
                    // color: Colors.grey,
                    // height: height * 0.11,
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: validateEmail,
                      decoration: InputDecoration(
                        filled: filledTextStyle,
                        fillColor: Colors.grey.withOpacity(0.6),
                        enabledBorder: outerInputBorderForTextField,
                        //  focusColor: Colors.grey,
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.grey, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: iconColor, width: 2)),
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

              //                                  Button Login                \\\

              Padding(
                padding: EdgeInsets.only(
                  top: height * 0.05,
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
                        color: Colors.lightBlue,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            spreadRadius: 2,
                            blurRadius: 4,
                          ),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    height: 45,
                    width: width * 0.84,
                    child: FlatButton(
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          Utils.checkInternetConnectivity().then((value) async {
                            if (value) {
                              PsResource<ApiResponse> _resource = await _api
                                  .updateDriverProfileData(<String, dynamic>{
                                "Name": widget.model[0].name,
                                "Email": _emailController.text.length == 0
                                    ? ""
                               : _emailController.text,
                                "Str1": DriverConst.str1,
                                "Str2": DriverConst.str2,
                                "Str3": DriverConst.str3
                              });

                              if (_resource.status == PsStatus.SUCCESS) {
                                //print("Profile is Update");
                                if (_resource.data.status ==
                                    "Updated Successfully") {
                                  BlocProvider.of<DriverprofileBloc>(context)
                                      .add(DriverProfileSetEvent(
                                          map: <String, dynamic>{
                                        'Str1': DriverConst.str1,
                                        'Str2': DriverConst.str2,
                                        'Str3': DriverConst.str3
                                      }));
                                  // } else {
                                  //   FlushBar.showSimpleFlushBar(
                                  //       "Check Connectivity",
                                  //       context,
                                  //       Colors.red,
                                  //       Colors.white);
                                  // }
                                  //  });
                                  FlushBar.showSimpleFlushBar(
                                      "Profile Update Succesfully",
                                      context,
                                      Colors.blue,
                                      Colors.white);
                                }
                              }
                            }
                          });
                        }
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return DriverProfilePage();
                        }));
                      },
                      child: Text(
                        "Update",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),

              ///               End Button Login              \\\
              ///
            ],
          ),
        ),
      ),
    );
  }
}
