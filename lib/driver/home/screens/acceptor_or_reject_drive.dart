import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:clip_shadow/clip_shadow.dart';
import 'package:flutter/material.dart';
import 'package:get_smart_ride_cas/Commons/hub_connection.dart';
import 'package:get_smart_ride_cas/api/driver_api/driver_api_services.dart';
import 'package:get_smart_ride_cas/driver/cliper.dart/bottom_rounded_cliper.dart';
import 'package:get_smart_ride_cas/driver/constant/ps_constants.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_all_riding_list.dart';
import 'package:get_smart_ride_cas/utils/utils.dart';
import 'package:get_smart_ride_cas/widgets/penalty_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_smart_ride_cas/driver/bloc/getdriverridelist_bloc.dart';
import 'package:get_smart_ride_cas/widgets/flush_bar.dart';
import 'package:get_smart_ride_cas/driver/home/screens/driver_ride.dart';
import 'package:get_smart_ride_cas/driver/home/screens/driver_ride_bill_detail.dart';
import 'package:geolocator/geolocator.dart';

import 'package:intl/intl.dart';
import 'package:get_smart_ride_cas/widgets/bill_dialog.dart';

Position driverStartRidePosition;

class DriverAcceptOrRejectDrive extends StatefulWidget {
  final DriverAllRidingRequest model;
  final riderequestID;
  final List<DriverAllRidingRequest> rideList;
  const DriverAcceptOrRejectDrive(
      {this.model, this.rideList, this.riderequestID});

  @override
  _DriverAcceptOrRejectDriveState createState() =>
      _DriverAcceptOrRejectDriveState();
}

class _DriverAcceptOrRejectDriveState extends State<DriverAcceptOrRejectDrive> {
  var height, width;

  // TextStyle _textStyleHeading = TextStyle(color: Colors.grey, fontSize: 18);
  // TextStyle _textStyleText = TextStyle(fontSize: 18);

  // List<String>
  DriverAllRidingRequest model;

  List<DriverAllRidingRequest> rideList = List();

  ApiServices _api = ApiServices();

  bool acceptedRide = false;

  bool isLoading = true;

  Future<bool> getAcceptedRequest() async {
    for (int i = 0; i < widget.rideList.length; i++) {
      if (widget.rideList[i].myId == widget.rideList[i].acceptDriverId) {
        if (widget.rideList[i].requestStatus == 2 ||
            widget.rideList[i].requestStatus == 4) {
          acceptedRide = true;
        }
      }
    }
  }

  getCurrentModel(List<DriverAllRidingRequest> list) {
    DriverAllRidingRequest model = DriverAllRidingRequest();
    for (int i = 0; i < list.length; i++) {
      if (widget.riderequestID == list[i].ridingRequestId) {
        model = list[i];
        print(
            "===============Model Request ID =============...${widget.riderequestID}");
      }
    }
    return model;
  }

  @override
  void initState() {
    print("STR 1........................${DriverConst.str1}");
    print("STR 2........................${DriverConst.str2}");
    print("STR 3........................${DriverConst.str3}");
    print("STR 4........................${DriverConst.str4}");
    print(
        "RIDE REQUEST ID........................${widget.model.ridingRequestId}");
    isLoading = true;

    _api.getDriverAllRidingList(<String, dynamic>{
      'Str1': DriverConst.str1,
      'Str2': DriverConst.str2,
      'Str3': DriverConst.str3
    }).then((value) {
      isLoading = false;
      setState(() {
        model = getCurrentModel(value.data);
      });
    });
    getAcceptedRequest().then((value) {
      // setState(() {
      //   isLoading = false;
      // });
    });
    //  model = widget.model;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    // print(
    //     "......................  Penalty Charges apply to rider .................. ${model.penaltyAmount}");
    return Scaffold(
      body: isLoading == true
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              height: height,
              width: width,
              //   color: Colors.blue,
              child: ListView(
                children: [
                  //====================== Image Clipper ======================\\
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
                      height: height * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        image: DecorationImage(
                            image: AssetImage("images/taxi_service.jpg"),
                            fit: BoxFit.fill),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0x20000000),
                              blurRadius: 10.0,
                              spreadRadius: 10.0,
                              offset: Offset(0, 3))
                        ],
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Container(
                        width: width,
                        color: Colors.blue.withOpacity(0.8),
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
                                    "Latest",
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
                                    "Request",
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
                    ),
                  ),

                  //===================== End Image Clipper ========================\\

                  //
                  // ================== To && From Paths ================ \\
                  //

                  SizedBox(
                    height: height * 0.01,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: width * 0.05, right: width * 0.05),
                    child: Container(
                      padding: EdgeInsets.only(bottom:08),
                      decoration: BoxDecoration(
                        
                         color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0x20000000),
                                blurRadius: 10.0,
                                spreadRadius: 10.0,
                                offset: Offset(0, 3))
                          ]),
                     // height: height * 0.3,
                      // color: Colors.white,
                      child: Row(
                        children: [
                          //
                          //================== Vertical Destination Points =======================\\
                          //
                          Padding(
                            padding: EdgeInsets.only(
                              top: height * 0.03,
                              left: width * 0.05,
                            ),
                            child: Container(
                              //    color: Colors.orange,
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.fiber_manual_record,
                                    size: 20,
                                    color: Colors.blue,
                                  ),
                                  Container(
                                    height: height * 0.08,
                                    //  color: Colors.blue,
                                    child: VerticalDivider(
                                      thickness: 1.5,
                                      width: 10,

                                      //height: height * 0.1,

                                      color: Colors.red,
                                    ),
                                  ),
                                  Icon(
                                    Icons.fiber_manual_record,
                                    size: 20,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //
                          //==================== End Vertical Destination Points =======================\\
                          //

                          Padding(
                            padding: EdgeInsets.only(
                              top: height * 0.018,
                              left: width * 0.04,
                            ),
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "From:",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        Container(
                                          width: width * 0.73,
                                          child: AutoSizeText(
                                            "${model.fromAddress}",
                                            maxLines: 3,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: height * 0.04),
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "To:",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          Container(
                                            width: width * 0.73,
                                            child: AutoSizeText(
                                              "${model.toAddress}",
                                              maxLines: 3,
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  //==================== Rider Data Show Here =====================\\

                  Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.03,
                        left: width * 0.05,
                        right: width * 0.05),
                    child: Container(
                      width: width * 0.9,
                      decoration: BoxDecoration(
                          //    color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: EdgeInsets.only(left: width * 0.0),
                        child: Column(
                          //  mainAxisAlignment: MainAxisAlignment.,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              //  height: height * 0.08,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
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
                                title: Text(
                                  '${model.ridingClientName}',
                                ),
                                leading: Icon(
                                  Icons.person,
                                  color: Colors.blue,
                                ),
                              ),
                            ),

                            //
                            SizedBox(
                              height: height * 0.02,
                            ),
                            //
                            Container(
                              //  height: height * 0.08,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
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
                                title: Text(
                                  '${model.ridingClientPhoneNumber}',
                                ),
                                leading: Icon(
                                  Icons.phone,
                                  color: Colors.blue,
                                ),
                              ),
                            ),

                            //
                            SizedBox(
                              height: height * 0.02,
                            ),

                            Container(
                              //  height: height * 0.08,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
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
                                title: Text(
                                  '${Utils.getTimeinformat(model.requestTimeDate)}',
                                ),
                                leading: Icon(
                                  Icons.timer,
                                  color: Colors.blue,
                                ),
                              ),
                            ),

                            ////
                            ///
                            Padding(
                              padding: EdgeInsets.only(top: height * 0.02),
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
                                  title: Text(
                                    '${Utils.getDateFormat(model.requestTimeDate)}',
                                  ),
                                  leading: Icon(
                                    Icons.calendar_today_sharp,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ),

                            ////
                            ///
                            ///
                            model.penaltyAmount != null
                                ? Padding(
                                    padding:
                                        EdgeInsets.only(top: height * 0.02),
                                    child: Container(
                                      //  height: height * 0.08,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color(0x20000000),
                                                blurRadius: 10.0,
                                                spreadRadius: 10.0,
                                                offset: Offset(0, 3))
                                          ]),
                                      child: ListTile(
                                        title: Text(
                                          '${model.penaltyAmount == null ? '0.0' : model.penaltyAmount} Rs',
                                        ),
                                        leading: Image.asset(
                                          "images/penalty.png",
                                          color: Colors.blue,
                                        ),
                                        contentPadding:
                                            EdgeInsets.symmetric(horizontal: 5),
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //======================== Buttons ========================\\

                  Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.03,
                        left: width * 0.05,
                        right: width * 0.05,
                        bottom: height * 0.03),

                    //=================================== Accept Button =============================\\
                    //
                    //
                    child: Container(
                      child: model.requestStatus == 1
                          ? InkWell(
                              onTap: () {
                                Utils.checkInternetConnectivity().then((value) {
                                  if (value) {
                                    if (hubConnection != null) {
                                      print(
                                          " =========================Appected Ride======================   $acceptedRide");
                                      if (acceptedRide) {
                                        FlushBar.showSimpleFlushBar(
                                            "Complete Ride first then Accept other",
                                            context,
                                            Colors.red,
                                            Colors.white);
                                      } else {
                                      
                                        hubConnection.invoke(
                                            "AcceptRidingRequest",
                                            args: [
                                              "${DriverConst.str1}",
                                              "${DriverConst.str2}",
                                              "${DriverConst.str3}",
                                              "${DriverConst.str4}",
                                              "${widget.model.ridingRequestId}",
                                            ]).catchError((e) {
                                              print(".abc...........$e");
                                          print(
                                              ".abc...,,,,--rejected Error ---------- $e");
                                        });

                                        _api.getDriverAllRidingList(<String,
                                            dynamic>{
                                          'Str1': DriverConst.str1,
                                          'Str2': DriverConst.str2,
                                          'Str3': DriverConst.str3
                                        }).then((value) {
                                          isLoading = false;
                                          setState(() {
                                            model = getCurrentModel(value.data);
                                          });
                                        });
                                        getAcceptedRequest().then((value) {
                                          // setState(() {
                                          //   isLoading = false;
                                          // });
                                        });
                                        BlocProvider.of<GetdriverridelistBloc>(
                                                context)
                                            .add(GetAllDriverRideListEvent(
                                                map: <String, dynamic>{
                                              'Str1': DriverConst.str1,
                                              'Str2': DriverConst.str2,
                                              'Str3': DriverConst.str3
                                            }));

                                        //   Navigator.pop(context);
                                        // startRide();
                                      }
                                    } else {}
                                  } else {
                                    FlushBar.showSimpleFlushBar(
                                        "Check Internet Connection",
                                        context,
                                        Colors.red,
                                        Colors.white);
                                  }
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: height * 0.06,
                                // width: width * 0.4,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color(0x20000000),
                                          blurRadius: 10.0,
                                          spreadRadius: 10.0,
                                          offset: Offset(0, 3))
                                    ]),
                                child: Text(
                                  "Accept",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                ),
                              ),
                            )
                          : model.requestStatus == 2
                              ? Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    //=============================== Start  Ride Button ==============================\\
                                    InkWell(
                                      onTap: () {
                                        Utils.determinePosition().then((value) {
                                          driverStartRidePosition = value;
                                          startRide();
                                        });

                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return DriverDrivingMode(
                                              model: model,
                                            );
                                          },
                                        ));
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: height * 0.06,
                                        //   width: width * 0.4,
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Color(0x20000000),
                                                  blurRadius: 10.0,
                                                  spreadRadius: 10.0,
                                                  offset: Offset(0, 3))
                                            ]),
                                        child: Text(
                                          " Start Ride ",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17),
                                        ),
                                      ),
                                    ),

//
                                    //
                                    //=============================== Reject Ride Button ==============================\\
                                    //
                                    //
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: height * 0.02,
                                          bottom: height * 0.02),
                                      child: InkWell(
                                        onTap: () async {
                                          final requestDateTime =
                                              "${widget.model.requestTimeDate.replaceAll("T", " ")}";
                                          print(requestDateTime);
                                          final formatter =
                                              DateFormat("yyyy-MM-dd")
                                                  .add_Hms();
                                          final dateTime =
                                              formatter.parse(requestDateTime);
                                          //   print("Requested DateTime in String...");

                                          var now = DateTime.now();
                                          var difference =
                                              now.difference(dateTime);
                                          var second = difference.inSeconds;
                                          // DateFormat("ss").format(DateTime.parse(""));
                                          print(
                                              ".......... Time Difference ...${difference.toString()}..second..");
                                          if (second > 90) {
                                            var value = await showGeneralDialog(
                                                context: context,
                                                barrierDismissible: true,
                                                barrierLabel:
                                                    MaterialLocalizations.of(
                                                            context)
                                                        .modalBarrierDismissLabel,
                                                barrierColor: Colors.black45,
                                                transitionDuration:
                                                    const Duration(
                                                        milliseconds: 200),
                                                pageBuilder: (BuildContext
                                                        buildContext,
                                                    Animation animation,
                                                    Animation
                                                        secondaryAnimation) {
                                                  return PenaltyDialog(
                                                    ridingRequestId:
                                                        model.ridingRequestId,
                                                    model: model,
                                                  );
                                                });
                                            if (value != null) {
                                              _api.getDriverAllRidingList(<
                                                  String, dynamic>{
                                                'Str1': DriverConst.str1,
                                                'Str2': DriverConst.str2,
                                                'Str3': DriverConst.str3
                                              }).then((value) {
                                                isLoading = false;
                                                setState(() {
                                                  model = getCurrentModel(
                                                      value.data);
                                                });
                                              });
                                              getAcceptedRequest()
                                                  .then((value) {
                                                // setState(() {
                                                //   isLoading = false;
                                                // });
                                              });
                                              //  Navigator.pop(context);
                                            }
                                          } else {
                                            Utils.checkInternetConnectivity()
                                                .then((value) {
                                              if (value) {
                                                hubConnection.invoke(
                                                    "RejectRidingRequestAfterAccept",
                                                    args: [
                                                      "${DriverConst.str1}",
                                                      "${DriverConst.str2}",
                                                      "${DriverConst.str3}",
                                                      "${DriverConst.str4}",
                                                      "${widget.model.ridingRequestId}",
                                                      "0",
                                                    ]).catchError((e) {
                                                  print(
                                                      "------------------ rejected Error ---------- $e");
                                                });
                                              } else {
                                                FlushBar.showSimpleFlushBar(
                                                    "Check Internet Connection",
                                                    context,
                                                    Colors.red,
                                                    Colors.white);
                                              }
                                            });
                                          }
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: height * 0.06,
                                          //   width: width * 0.4,
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Color(0x20000000),
                                                    blurRadius: 10.0,
                                                    spreadRadius: 10.0,
                                                    offset: Offset(0, 3))
                                              ]),
                                          child: Text(
                                            "Reject Ride",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : model.requestStatus == 4
                                  ? InkWell(
                                      onTap: () {
                                        startRide();
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return DriverDrivingMode(
                                              model: model,
                                            );
                                          },
                                        ));
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: height * 0.06,
                                        //   width: width * 0.4,
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Color(0x20000000),
                                                  blurRadius: 10.0,
                                                  spreadRadius: 10.0,
                                                  offset: Offset(0, 3))
                                            ]),
                                        child: Text(
                                          " On Ride ",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17),
                                        ),
                                      ),
                                    )
                                  : model.requestStatus == 5
                                      ? Padding(
                                          padding: EdgeInsets.only(
                                              left: width * 0.2,
                                              right: width * 0.2),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                builder: (context) {
                                                  return DriverRideBillDetailPage(
                                                    rideRequestId:
                                                        model.ridingRequestId,
                                                  );
                                                },
                                              ));
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: height * 0.06,
                                              //   width: width * 0.4,
                                              decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(17)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color:
                                                            Color(0x20000000),
                                                        blurRadius: 10.0,
                                                        spreadRadius: 10.0,
                                                        offset: Offset(0, 3))
                                                  ]),
                                              child: Text(
                                                " Bill Detail ",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17),
                                              ),
                                            ),
                                          ),
                                        )

//
                                      : Container(),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  startRide() {
    Utils.determinePosition().then((value) {
      if (hubConnection != null) {
        hubConnection.invoke("StartRideAfterAccept", args: [
          "${DriverConst.str1}",
          "${DriverConst.str2}",
          "${DriverConst.str3}",
          "${DriverConst.str4}",
          "${widget.model.ridingRequestId}",
          "0",
        ]).catchError((e) {
          print("------------------ rejected Error ---------- $e");
        });
      }
    });
    _api.getDriverAllRidingList(<String, dynamic>{
      'Str1': DriverConst.str1,
      'Str2': DriverConst.str2,
      'Str3': DriverConst.str3
    }).then((value) {
      isLoading = false;
      setState(() {
        model = getCurrentModel(value.data);
      });
    });
    getAcceptedRequest().then((value) {
      // setState(() {
      //   isLoading = false;
      // });
    });
  }
}

/*
 Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                width: width * 0.9,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: EdgeInsets.only(left: width * 0.05),
                  child: Column(
                    //  mainAxisAlignment: MainAxisAlignment.,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "Name:",
                          style: _textStyleHeading,
                        ),
                      ),
                      Container(
                        child: Text(
                          "Mufazal Ahmad",
                          style: _textStyleText,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Container(
                        child: Text(
                          "Phone NO:",
                          style: _textStyleHeading,
                        ),
                      ),
                      Container(
                        child: Text(
                          "03029831065",
                          style: _textStyleText,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Container(
                        child: Text(
                          "Requested Date:",
                          style: _textStyleHeading,
                        ),
                      ),
                      Container(
                        child: Text(
                          "23-01-2021",
                          style: _textStyleText,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Container(
                        child: Text(
                          "Requested Time",
                          style: _textStyleHeading,
                        ),
                      ),
                      Container(
                        child: Text(
                          "6:45 AM",
                          style: _textStyleText,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
*/
