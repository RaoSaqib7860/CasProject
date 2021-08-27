import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_smart_ride_cas/api/common/ps_resource.dart';
import 'package:get_smart_ride_cas/driver/home/screens/check_driver_image.dart';
import 'package:get_smart_ride_cas/driver/home/screens/check_driving_license.dart';
import 'package:get_smart_ride_cas/driver/home/screens/check_id_card.dart';
import 'package:get_smart_ride_cas/driver/home/screens/check_vehicle_info.dart';
import 'package:get_smart_ride_cas/driver/home/screens/driver_dashboard.dart';
import 'package:get_smart_ride_cas/driver/home/screens/driver_id_page.dart';
import 'package:get_smart_ride_cas/driver/home/screens/driver_image.dart';
import 'package:get_smart_ride_cas/driver/home/screens/driver_licence_page.dart';
import 'package:get_smart_ride_cas/driver/home/screens/vehicle_info_page.dart';
import 'package:get_smart_ride_cas/driver/repository/initial_requirements/bloc/driverinitialrequirements_bloc.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_login_reponse.dart';
import 'package:gradient_text/gradient_text.dart';

class DriverInitialRequirementPage extends StatefulWidget {
  @required
  final String phoneNo;
  @required
  final String password;

  DriverInitialRequirementPage({this.phoneNo, this.password});
  @override
  _DriverInitialRequirementPageState createState() =>
      _DriverInitialRequirementPageState();
}

class _DriverInitialRequirementPageState
    extends State<DriverInitialRequirementPage> {
  var height, width;

  String driverImage, driverLicense, driverIdCard, driverVehicle;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    BlocProvider.of<DriverinitialrequirementsBloc>(context)
        .add(InsertModel(map: <String, dynamic>{
      "PhoneNumber": "${widget.phoneNo}",
      "Password": "${widget.password}",
    }));
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;

    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
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
            Column(
              children: [
                ///=================== Create Account Text =================\\
                Padding(
                  padding: EdgeInsets.only(top: height * 0.1, left: 28),
                  child: Container(
                    width: width,
                    alignment: Alignment.centerLeft,
                    child: GradientText("Full fill the \nRequirements ",
                        gradient: LinearGradient(colors: [
                          Colors.white,
                          Colors.white,
                          Colors.white,
                        ]),
                        style: TextStyle(fontSize: 27),
                        textAlign: TextAlign.left),
                  ),
                ),
                Expanded(
                  child: Container(
                      //
                      //===================================== Bloc Implement Here =============================\\
                      //
                      //   color: Colors.white,
                      child: BlocBuilder<DriverinitialrequirementsBloc,
                          DriverInitialRequirementsState>(
                    builder: (context, state) {
                      if (state is DriverLoadingRequirementsState) {
                        print(
                            "----------------------------- initial state is call ----------------------");
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (state is DriverLoadRequirementsState) {
                        PsResource<DriverLoginResponse> model = state.resource;

                        print(
                            "----------------------------- loaded state is call ----------------------");

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //
                            //================= Driver Image  ===================\\
                            //

                            Padding(
                              padding: EdgeInsets.only(
                                  top: height * 0.04,
                                  bottom: 5.0,
                                  left: width * 0.08,
                                  right: width * 0.08),
                              child: Container(
                                //  height: height * 0.08,
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color(0x20000000),
                                          blurRadius: 10.0,
                                          spreadRadius: 10.0,
                                          offset: Offset(0, 3))
                                    ]),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) {
                                        return CheckDriverImageUploadPage(
                                          password: widget.password,
                                          phoneNo: widget.phoneNo,
                                        );
                                      },
                                    ));
                                  },
                                  title: Text(
                                    'Driver Image',
                                  ),
                                  trailing: model.data.driverImage.isEmpty ==
                                          true
                                      ? Icon(
                                          Icons.error_outline_outlined,
                                          color: Colors.red,
                                        )
                                      : Icon(
                                          Icons.check_circle_outline_rounded,
                                          color: Colors.blue,
                                        ),
                                ),
                              ),
                            ),
                            //================================= End Driver Image =======================\\\\\

                            //
                            //================= Driver ID Card ============\\
                            //

                            Padding(
                              padding: EdgeInsets.only(
                                  top: height * 0.04,
                                  bottom: 5.0,
                                  left: width * 0.08,
                                  right: width * 0.08),
                              child: Container(
                                //  height: height * 0.08,
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color(0x20000000),
                                          blurRadius: 10.0,
                                          spreadRadius: 10.0,
                                          offset: Offset(0, 3))
                                    ]),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) {
                                        return CheckDriverIDCardPage(
                                          password: widget.password,
                                          phoneNo: widget.phoneNo,
                                        );
                                      },
                                    ));
                                  },
                                  title: Text(
                                    'Driver ID Card',
                                  ),
                                  trailing: model.data.idCardImage.isEmpty ==
                                          true
                                      ? Icon(
                                          Icons.error_outline_outlined,
                                          color: Colors.red,
                                        )
                                      : Icon(
                                          Icons.check_circle_outline_rounded,
                                          color: Colors.blue,
                                        ),
                                ),
                              ),
                            ),
                            //================================= End Driver ID Card =======================\\\\\

                            //
                            //================= Driving Licence  ===================\\
                            //

                            Padding(
                              padding: EdgeInsets.only(
                                  top: height * 0.04,
                                  bottom: 5.0,
                                  left: width * 0.08,
                                  right: width * 0.08),
                              child: Container(
                                //  height: height * 0.08,
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color(0x20000000),
                                          blurRadius: 10.0,
                                          spreadRadius: 10.0,
                                          offset: Offset(0, 3))
                                    ]),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) {
                                        return CheckDriverLicenceCardPage(
                                          password: widget.password,
                                          phoneNo: widget.phoneNo,
                                        );
                                      },
                                    ));
                                  },
                                  title: Text(
                                    'Driving License',
                                  ),
                                  trailing: model.data.drivingLicence.isEmpty ==
                                          true
                                      ? Icon(
                                          Icons.error_outline_outlined,
                                          color: Colors.red,
                                        )
                                      : Icon(
                                          Icons.check_circle_outline_rounded,
                                          color: Colors.blue,
                                        ),
                                ),
                              ),
                            ),
                            //================================= End Driving Licence  =======================\\\\\

                            //
                            //================= Vehicle Info  ===================\\
                            //

                            Padding(
                              padding: EdgeInsets.only(
                                  top: height * 0.04,
                                  bottom: 5.0,
                                  left: width * 0.08,
                                  right: width * 0.08),
                              child: Container(
                                //  height: height * 0.08,
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color(0x20000000),
                                          blurRadius: 10.0,
                                          spreadRadius: 10.0,
                                          offset: Offset(0, 3))
                                    ]),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) {
                                        return CheckDriverVehicleInfoPage(
                                          password: widget.password,
                                          phoneNo: widget.phoneNo,
                                        );
                                      },
                                    ));
                                  },
                                  title: Text(
                                    'Driver Vehicle',
                                  ),
                                  trailing: model.data.vehicleNumber.isEmpty ==
                                          true
                                      ? Icon(
                                          Icons.error_outline_outlined,
                                          color: Colors.red,
                                        )
                                      : Icon(
                                          Icons.check_circle_outline_rounded,
                                          color: Colors.blue,
                                        ),
                                ),
                              ),
                            ),
                            //================================= End VehicleInfo =======================\\\\\

                            ///
                            ///========================== Button Next  ==========================\\\
                            ///
                            Padding(
                              padding: EdgeInsets.only(
                                  top: height * 0.08,
                                  left: 28,
                                  right: 28,
                                  bottom: height * 0.03),
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
                                        BorderRadius.all(Radius.circular(10))),
                                height: 45,
                                width: width * 0.84,
                                child: FlatButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return DriverDashboard();
                                      },
                                    ));
                                  },
                                  child: Text(
                                    "Next",
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
                        );
                      } else {
                        return null;
                      }
                    },
                  )),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
