import 'dart:io';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:clip_shadow/clip_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_smart_ride_cas/api/driver_api/driver_api_services.dart';
import 'package:get_smart_ride_cas/driver/cliper.dart/bottom_rounded_cliper.dart';
import 'package:get_smart_ride_cas/driver/constant/ps_constants.dart';
import 'package:get_smart_ride_cas/driver/home/screens/login_page.dart';

import 'package:get_smart_ride_cas/driver/repository/initial_requirements/bloc/driverinitialrequirements_bloc.dart';
import 'package:get_smart_ride_cas/driver/view_object/driving_licence_res.dart';
import 'package:get_smart_ride_cas/widgets/flush_bar.dart';
import 'package:get_smart_ride_cas/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class CheckDriverLicenceCardPage extends StatefulWidget {
  String phoneNo;
  String password;
  CheckDriverLicenceCardPage({
    Key key,
    this.phoneNo,
    this.password,
  }) : super(key: key);
  @override
  _DriverLicenceCardPageState createState() => _DriverLicenceCardPageState();
}

class _DriverLicenceCardPageState extends State<CheckDriverLicenceCardPage> {
  var height, width;

  var picker = ImagePicker();
  File _image;
  String imageName;
  bool isLoading;

  ///
  ///================== Get Image from gallery ===================\\\
  ///
  ///

  Future _getImage() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);

        imageName = basename(_image.path);
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            height: height,
            width: width,
            child: Column(
              children: [
                //=============== Upper Image ==============\\

                ClipShadow(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0.0, 0.0),
                      blurRadius: 10.0,
                      spreadRadius: 10.0,
                      color: Colors.grey.withOpacity(0.8),
                    )
                  ],
                  clipper: MyCustomClipper(clipType: ClipType.bottom),
                  child: Container(
                    height: height * 0.31,
                    child: Stack(
                      children: [
                        Container(
                          width: width,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "images/driving_licence_bg.jpg"),
                                  fit: BoxFit.cover)),
                        ),
                        Container(
                          width: width,
                          color: Colors.blue.withOpacity(0.6),
                          child: Padding(
                            padding: EdgeInsets.only(left: width * 0.08),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: height * 0.1),
                                  child: Container(
                                    child: Text(
                                      "Choose Your",
                                      style: TextStyle(
                                          fontSize: 26,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: height * 0.02),
                                  child: Container(
                                    child: Text(
                                      "Driving Licence",
                                      style: TextStyle(
                                          fontSize: 29,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
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
                //============================= Image Container End Here ==============================\\

                Padding(
                  padding: EdgeInsets.only(
                      left: width * 0.06,
                      top: height * 0.02,
                      right: width * 0.06),
                  child: Container(
                    width: width,
                    child: AutoSizeText(
                      "Take a good quality picture of your Driving Licence Card to ensure that all the necessary information must come out from picture.",
                      maxLines: 3,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ),

                //================== Image Container Use Here =======================\\

                Padding(
                  padding: EdgeInsets.only(
                      top: height * 0.04,
                      left: width * 0.1,
                      right: width * 0.1),
                  child: Container(
                    height: height * 0.33,
                    width: width,
                    color: Colors.white,
                    child: _image == null
                        ? Image.asset("images/driving_licence.png")
                        : Image.file(
                            _image,
                            fit: BoxFit.fill,
                          ),
                  ),
                ),

                //==================== End Image Container =====================\\

                Expanded(
                    child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      /// ================= Button Next ================== \\\
                      ///
                      Padding(
                        padding: EdgeInsets.only(
                          top: height * 0.02,
                          left: 28,
                          right: 28,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.blue,
                                    Colors.lightBlue,
                                    Colors.blue,
                                  ],
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
                              setState(() {
                                isLoading = true;
                              });
                              if (_image != null) {
                                print("method is Call ");
                                ApiServices api = ApiServices();
                                Utils.checkInternetConnectivity()
                                    .then((value) async {
                                  if (value == true) {
                                    DrivingLicenceResponse _resource =
                                        await api.drivingLicenceUpload(
                                            DriverConst.str1,
                                            DriverConst.str2,
                                            DriverConst.str3,
                                            DriverConst.str4,
                                            _image);
                                    print(
                                        " Response from server${_resource.status}");

                                    if (_resource.status ==
                                        "File Uploaded Successfully") {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      FlushBar.showSimpleFlushBar(
                                          "File Upload Sucessfully ",
                                          context,
                                          Colors.red,
                                          Colors.white);
                                      print("........... Navigate ..........");

                                      Navigator.pushAndRemoveUntil(context,
                                          MaterialPageRoute(
                                        builder: (context) {
                                          return DriverLoginPage();
                                        },
                                      ), (route) => false);

                                      BlocProvider.of<
                                                  DriverinitialrequirementsBloc>(
                                              context)
                                          .add(InsertModel(
                                              map: <String, dynamic>{
                                            "PhoneNumber": "${widget.phoneNo}",
                                            "Password": "${widget.password}",
                                          }));
                                    }
                                  } else {
                                    print("Chect connection");
                                  }
                                });
                              } else {
                                FlushBar.showSimpleFlushBar("Select Image",
                                    context, Colors.red, Colors.white);
                              }
                            },
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 21,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),

                      ///
                      ///========================== Button PickImage Button ==========================\\\
                      ///
                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.02,
                            left: 28,
                            right: 28,
                            bottom: height * 0.02),
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.white,
                                    Colors.white,
                                    Colors.white,
                                  ],
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
                              _getImage();
                            },
                            child: Text(
                              " Select Photo",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 21,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ),
          isLoading == true
              ? Container(
                  color: Colors.white.withOpacity(0.4),
                  width: width,
                  height: height,
                  child: Center(child: CircularProgressIndicator()),
                )
              : Container()
        ],
      ),
    );
  }
}
