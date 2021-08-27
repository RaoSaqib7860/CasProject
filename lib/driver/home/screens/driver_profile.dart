//import 'dart:html';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_smart_ride_cas/api/common/ps_resource.dart';
import 'package:get_smart_ride_cas/api/driver_api/driver_api.dart';
import 'package:get_smart_ride_cas/api/driver_api/driver_api_services.dart';
import 'package:get_smart_ride_cas/driver/constant/ps_constants.dart';
import 'package:get_smart_ride_cas/driver/home/drawer/drawer.dart';
import 'package:get_smart_ride_cas/driver/home/screens/driver_dashboard.dart';
import 'package:get_smart_ride_cas/driver/home/screens/update_driver_profile.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_image_upload_res.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_profile.dart';
import 'package:get_smart_ride_cas/utils/utils.dart';
import 'package:get_smart_ride_cas/widgets/flush_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:get_smart_ride_cas/driver/repository/driver_profile/bloc/driverprofile_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DriverProfilePage extends StatefulWidget {
  @override
  _DriverProfilePageState createState() => _DriverProfilePageState();
}

class _DriverProfilePageState extends State<DriverProfilePage> {
  bool connectivityError = false;

  TextStyle textStyle = TextStyle(fontSize: 17, color: Colors.grey);
  TextStyle textStyle2 = TextStyle(fontSize: 17, color: Colors.black);

  Color iconColor;
  Color appbarColor = Color(0xff4ADEDE);

  double textViewHeight;
  double textViewTopPadding;

  ///                         Get Data From Server Method                    \\\

  bool isLoading;
  File image;
  //bool isLoading;
  final picker = ImagePicker();
  // bool clickImage;
  PsResource<List<DriverProfileModel>> model;
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    // setState(() {
    if (pickedFile != null) {
      image = File(pickedFile.path);
      return image;
    } else {
      print("NO IMAGE SELECTED");

      //  return;
      //   ab check kra ab hwi hai change
    }
    //  });
  }

  @override
  void initState() {
    Utils.checkInternetConnectivity().then((value) {
      if (value) {
        BlocProvider.of<DriverprofileBloc>(context).add(DriverProfileSetEvent(
            map: <String, dynamic>{
              'Str1': DriverConst.str1,
              'Str2': DriverConst.str2,
              'Str3': DriverConst.str3
            }));
      } else {
        FlushBar.showSimpleFlushBar(
            "Check Connectivity", context, Colors.red, Colors.white);
      }
    });
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
              builder: (context) {
                return DriverDashboard();
              },
            ), (route) {
              return false;
            });
          },
        ),
        backgroundColor: Theme.of(context).accentColor,
        title: Text("Profile"),
      ),
      body: (isLoading == true)
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              height: height,
              //   color: Color(0xFF18B3B3),
              child: Padding(
                padding:
                    EdgeInsets.only(left: width * 0.07, right: width * 0.07),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: height * 0.05,
                              bottom: 10),

                          // yha bloc lgya ha \\aik min
                          child: BlocBuilder<DriverprofileBloc,
                              DriverProfileState>(
                            builder: (context, state) {
                              if (state is DriverProfileLoadedState) {
                                model = state.model;
                                return Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 0),
                                      child: Center(
                                        child: Stack(
                                          children: [
                                            Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              elevation: 8,
                                              child: Container(
                                                width: width * 0.35,
                                                height: height * 0.18,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                      width: 2),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 2,
                                                      blurRadius: 5,
                                                    ),
                                                  ],
                                                  image: DecorationImage(
                                                      image: model.data[0]
                                                                  .driverImage !=
                                                              null
                                                          ? NetworkImage(
                                                              "${DriverApi.baseUrL}${model.data[0].driverImage}")
                                                          : AssetImage(
                                                              "images/profile_vector.jpg",
                                                            ),
                                                      fit: BoxFit.cover),
                                                ),
                                                child: Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: InkWell(
                                                      onTap: () async {
                                                        //  clickImage = true;
                                                        //gallery sy image select krty hwa ai hai//
                                                        File image =
                                                            await getImage();

                                                        print(
                                                            "Image is not null ===================${image.path}");
                                                        if (image != null) {
                                                          isLoading = true;

                                                          print(
                                                              "=========Image updaete method is Call =====");
                                                          ApiServices api =
                                                              ApiServices();
                                                          Utils.checkInternetConnectivity()
                                                              .then(
                                                                  (value) async {
                                                            if (value == true) {
                                                              DriverImageUploadResponse
                                                                  _resource =
                                                                  await api.driverImageUpload(
                                                                      DriverConst
                                                                          .str1,
                                                                      DriverConst
                                                                          .str2,
                                                                      DriverConst
                                                                          .str3,
                                                                      DriverConst
                                                                          .str4,
                                                                      image);
                                                              print(
                                                                  " Response from server${_resource.status}");

                                                              if (_resource
                                                                      .status ==
                                                                  "File Uploaded Successfully") {
                                                                Utils.checkInternetConnectivity()
                                                                    .then(
                                                                        (value) {
                                                                  if (value) {
                                                                    isLoading =
                                                                        false;

                                                                    FlushBar.showSimpleFlushBar(
                                                                        "file uploaded successfully",
                                                                        context,
                                                                        Colors
                                                                            .green,
                                                                        Colors
                                                                            .white);

                                                                    BlocProvider.of<DriverprofileBloc>(
                                                                            context)
                                                                        .add(DriverProfileSetEvent(map: <
                                                                            String,
                                                                            dynamic>{
                                                                      'Str1': DriverConst
                                                                          .str1,
                                                                      'Str2': DriverConst
                                                                          .str2,
                                                                      'Str3':
                                                                          DriverConst
                                                                              .str3
                                                                    }));
                                                                  } else {
                                                                    FlushBar.showSimpleFlushBar(
                                                                        "Check Connectivity",
                                                                        context,
                                                                        Colors
                                                                            .red,
                                                                        Colors
                                                                            .white);
                                                                  }
                                                                });

                                                                // check kra isa \\krti
                                                              }
                                                            } else {
                                                              print(
                                                                  "Chect connection");
                                                            }
                                                          });
                                                        } else {
                                                          FlushBar
                                                              .showSimpleFlushBar(
                                                                  "Select Image",
                                                                  context,
                                                                  Colors.red,
                                                                  Colors.white);
                                                        }
                                                      },
                                                      child: Icon(Icons.image,
                                                          color: Colors.white),
                                                    )),
                                              ),
                                            ),
                                            // Align(
                                            //     alignment:
                                            //         Alignment.bottomRight,
                                            //     child: Icon(Icons.image))
                                          ],
                                        ),
                                      ),
                                    ),

                                    ///                Doctor Name      \\\
                                    ///
                                    ///
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: height * 0.1,
                                          left: paddingleft,
                                          right: paddingleft),
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        height: textViewHeight,
                                        child: FittedBox(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AutoSizeText(
                                                "Name",
                                                style: textStyle,
                                                maxLines: 1,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: width * 0.0,
                                                    top: width * 0.01),
                                                child: AutoSizeText(
                                                  "${model.data[0].name}",
                                                  style: textStyle2,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1,
                                    ),

                                    ///                             Email                        \\\\\\\

                                    model.data[0].email.contains("@")
                                        ? Padding(
                                            padding: EdgeInsets.only(
                                                top: height * 0.02,
                                                left: paddingleft,
                                                right: paddingleft),
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              height: textViewHeight,
                                              child: FittedBox(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    AutoSizeText(
                                                      "Email",
                                                      style: textStyle,
                                                      maxLines: 1,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: width * 0.0,
                                                          top: width * 0.01),
                                                      child: AutoSizeText(
                                                        "${model.data[0].email}",
                                                        style: textStyle2,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                    model.data[0].email.contains("@")
                                        ? Divider(
                                            thickness: 1,
                                          )
                                        : Container(),

                                    ///                            Phone Number                       \\\\\\\

                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: height * 0.01,
                                          left: paddingleft,
                                          right: paddingleft),
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        height: textViewHeight,
                                        child: FittedBox(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Phone",
                                                style: textStyle,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: width * 0.0,
                                                    top: width * 0.01),
                                                child: Text(
                                                  "${model.data[0].phoneNumber}",
                                                  style: textStyle2,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1,
                                    ),

                                    // ///                          Gender                       \\\\\\\

                                    // Padding(
                                    //   padding: EdgeInsets.only(
                                    //       top: y * 0.01,
                                    //       left: paddingleft,
                                    //       right: paddingleft),
                                    //   child: Container(
                                    //     alignment: Alignment.centerLeft,
                                    //     height: textViewHeight,
                                    //     child: Column(
                                    //       mainAxisAlignment:
                                    //           MainAxisAlignment.spaceAround,
                                    //       crossAxisAlignment:
                                    //           CrossAxisAlignment.start,
                                    //       children: [
                                    //         Text(
                                    //           "Gender",
                                    //           style: textStyle,
                                    //         ),
                                    //         Padding(
                                    //           padding: EdgeInsets.only(
                                    //               left: x * 0.0, top: x * 0.01),
                                    //           child: Text(
                                    //             "${(widget.model.gender == 1) ? "Male" : "Female"}",
                                    //             style: textStyle2,
                                    //           ),
                                    //         )
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
                                    // Divider(
                                    //   thickness: 1,
                                    // ),

                                    ///                        CNIC                       \\\\\\\

                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: height * 0.01,
                                          left: paddingleft,
                                          right: paddingleft),
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        height: textViewHeight,
                                        child: FittedBox(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "CNIC",
                                                style: textStyle,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: width * 0.0,
                                                    top: width * 0.01),
                                                child: Text(
                                                  "${model.data[0].idCardNumber}",
                                                  style: textStyle2,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1,
                                    ),

                                    // ///                         DOB                       \\\\\\\

                                    // Padding(
                                    //   padding: EdgeInsets.only(
                                    //       top: y * 0.01,
                                    //       left: paddingleft,
                                    //       right: paddingleft),
                                    //   child: Container(
                                    //     alignment: Alignment.centerLeft,
                                    //     height: textViewHeight,
                                    //     child: Column(
                                    //       mainAxisAlignment:
                                    //           MainAxisAlignment.spaceAround,
                                    //       crossAxisAlignment:
                                    //           CrossAxisAlignment.start,
                                    //       children: [
                                    //         Text(
                                    //           "Date of Birth",
                                    //           style: textStyle,
                                    //         ),
                                    //         Padding(
                                    //           padding: EdgeInsets.only(
                                    //               left: x * 0.0, top: x * 0.01),
                                    //           child: Text(
                                    //             "${getDateFormat(widget.model.dOB)}",
                                    //             style: textStyle2,
                                    //           ),
                                    //         )
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),

                                    // Divider(
                                    //   thickness: 1,
                                    // ),
                                  ],
                                );
                              }
                              return Container();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return DriverProfileUpdatePage(
                model: model.data,
              );
            },
          ));
        },
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }

  getDateFormat(String d) {
    String date = DateFormat('yyyy-MM-dd').format(DateTime.parse(d));
    return date;
  }
}

class Constants {
  static const String History = 'History';
//  static const String Settings = 'Settings';
//  static const String SignOut = 'Sign out';

  static const List<String> choices = <String>[History];
}
