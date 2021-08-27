import 'dart:async';
import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_smart_ride_cas/Commons/constant.dart';
import 'package:get_smart_ride_cas/Commons/hub_connection.dart';
import 'package:get_smart_ride_cas/chat/chat_controller.dart';
import 'package:get_smart_ride_cas/chat/models/message_model.dart';
import 'package:get_smart_ride_cas/chat/models/user_model.dart';
import 'package:get_smart_ride_cas/driver/bloc/getdriverridelist_bloc.dart';
import 'package:get_smart_ride_cas/driver/constant/ps_constants.dart';
import 'package:get_smart_ride_cas/driver/home/drawer/drawer.dart';
import 'package:get_smart_ride_cas/driver/home/screens/confirmed_ride_page.dart';
import 'package:get_smart_ride_cas/driver/home/screens/driver_all_ridig_list_page.dart';
import 'package:get_smart_ride_cas/driver/home/screens/earn_tody_page.dart';
import 'package:get_smart_ride_cas/driver/home/screens/driver_FromToDay_Earning.dart';
import 'package:get_smart_ride_cas/rider/home/myController.dart';
import 'package:get_smart_ride_cas/rider/screens/SmartDrawer/totalRides.dart';
import 'package:get_smart_ride_cas/utils/utils.dart';
import 'package:get_smart_ride_cas/wave/config.dart';
import 'package:get_smart_ride_cas/wave/wave.dart';
import 'package:get_smart_ride_cas/widgets/bill_dialog.dart';
import 'package:get_smart_ride_cas/widgets/exit_app_dialog.dart';
import 'package:get_smart_ride_cas/widgets/flush_bar.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DriverDashboard extends StatefulWidget {
  @override
  _DriverDashboardState createState() => _DriverDashboardState();
}

class _DriverDashboardState extends State<DriverDashboard> {
  //
  var height, width;
  //
  //
  List<String> sliderImageList = List();

//   final serverUrl =
//       "http://182.176.112.99:35055/ChatHub?Str1=${DriverConst.str1}&Str2=${DriverConst.str2}&Str3=${DriverConst.str3}&Str4=${DriverConst.str4}";
//   final hubProtLogger = Logger("SignalR - hub");

// //    If youn want to also to log out transport messages:

//   final transportProtLogger = Logger("SignalR - transport");

  var connectivityResult;

  Timer timer, timer2;

  Future selectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    // await Navigator.push(
    //   context,
    //   MaterialPageRoute<void>(builder: (context) => ),
    // );
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return RiderAllRidesListPage();
    }));
  }

  @override
  void initState() {
    print(".abc init........STR 1..........................${Const.STR1}");
    Utils.initializeNotification(selectNotification);

    if (MyController.to.isConectionStarted == false) {
      print(".abc.............creating server connection 1st time");
      createServerConnection();
    }
    serverMsg();
    checkConnectivity().then((value) {
      print("");
      if (value == true) {
        startServerConnection();
      } else {
        print(".abc...........else");
      }
    });

    timer = Timer.periodic(Duration(seconds: 45), (timer) {
      if (hubConnection.state == HubConnectionState.disconnected) {
        checkConnectivity().then((value) {
          if (value == true) {
            //   startServerConnection();
          } else {
            FlushBar.showSimpleFlushBar(
                "Check Connection ", context, Colors.red, Colors.white);
          }
        });
      } else if (hubConnection.state == HubConnectionState.connected) {
        getlocation();
      }
    });

    timer2 = Timer.periodic(Duration(seconds: 18), (timer) {
      if (hubConnection.state == HubConnectionState.disconnected) {
        checkConnectivity().then((value) {
          if (value == true) {
            startServerConnection();
          } else {
            FlushBar.showSimpleFlushBar(
                "Check Connection ", context, Colors.red, Colors.white);
          }
        });
      }
    });

    // TODO: implement initState
    super.initState();
  }

  Future<bool> checkConnectivity() async {
    bool isConnected = await Utils.checkInternetConnectivity();
    return isConnected;
  }

  // createServerConnection() {
  //   print("methode start now");
  //   Logger.root.level = Level.ALL;
  //   Logger.root.onRecord.listen((LogRecord rec) {
  //     print('${rec.level.name}: ${rec.time}: ${rec.message}');
  //   });

  //   // If you want only to log out the message for the higer level hub protocol:
  //   // final hubProtLogger = Logger("SignalR - hub");
  //   // If youn want to also to log out transport messages:
  //   // final transportProtLogger = Logger("SignalR - transport");
  //   final httpOptions = new HttpConnectionOptions(
  //       logging: (Level, message) => print(" Hub Connection Msg : $message"));

  //   DriverDashboard.hubConnection =
  //       HubConnectionBuilder().withUrl(serverUrl, httpOptions).build();
  //   serverMsg();
  //   // .configure Logging(hubProtLogger)
  //   ///
  // }

  // startServerConnection() async {
  //   await DriverDashboard.hubConnection.start().then((value) {
  //     print("--------------- Connection Start -------------");
  //     FlushBar.showSimpleFlushBar(
  //         "Server Connected", context, Colors.blue, Colors.white);
  //   }).catchError((e) {
  //     FlushBar.showSimpleFlushBar("$e", context, Colors.blue, Colors.white);
  //   });
  // }

  // onCloseServerConnection() async {
  //   DriverDashboard.hubConnection.onclose((error) {
  //     print("-------------------Connection is Closed --------------");

  //     FlushBar.showSimpleFlushBar(
  //         "Server Connection Close", context, Colors.red, Colors.white);
  //   });
  // }

  serverMsg() async {
    hubConnection.on("ReceiveMessage", _handleDriverProvidedFunction);
  }

  _handleDriverProvidedFunction(List<Object> list) {
    print(".abc.........driver.....handler");
    String serverMessageForDriver = list[0].toString();

    // Fluttertoast.showToast(
    //   msg: serverMessageForDriver.toString(),
    //   toastLength: Toast.LENGTH_LONG,
    //   gravity: ToastGravity.BOTTOM,
    //   backgroundColor: Colors.blue[900],
    // );


    var splitServerMessagePattern = serverMessageForDriver.split(",");

    var serverMessageName = splitServerMessagePattern;

    // print(".abc....servermsg...length......${serverMessageName.length}");
    // print(".abc....servermsg...length......${serverMessageName[1]}");
    if (serverMessageName[0].toString() == "[NewRidingRequest") {
      print(".abc..............new riding rques");
      BlocProvider.of<GetdriverridelistBloc>(context).add(
          GetAllDriverRideListEvent(map: <String, dynamic>{
        'Str1': DriverConst.str1,
        'Str2': DriverConst.str2,
        'Str3': DriverConst.str3
      }));
      FlushBar.showSimpleFlushBar(
          "New Request is coming", context, Colors.blue, Colors.white);
      Utils.showNotification("New Booking Arrive ", "");
    } else if (serverMessageName[0].toString() == "[AcceptRidingRequest") {
      print(".abc.....@@@.........*********");
      print(".abc........Request triger.........");
      print(".abc............${serverMessageName[1]}");
      print(".abc............${serverMessageName[2]}");
      if (serverMessageName[1].toString() == " Alread Accepted by You") {
        FlushBar.showSimpleFlushBar(
            "Already Accepted by You", context, Colors.red, Colors.white);
      } else if (serverMessageName[serverMessageName.length >= 4 ? 3 : 0]
              .toString() ==
          " Request Accepted Successfully") {
        print(".abc..............req accept succesful");
        FlushBar.showSimpleFlushBar(" Request Accepted Successfully", context,
            Colors.blue, Colors.white);
      } else if (serverMessageName[1].toString() ==
          " Allowed Accept Time has been Passed") {
        print(".abc.....@@@@@@@@@@");
        FlushBar.showSimpleFlushBar("Allowed Accept Time has been Passed",
            context, Colors.red, Colors.white);
      }
    } else if (splitServerMessagePattern[0].toString() == "[ChattMessages") {
      String messagename = splitServerMessagePattern[1].toString();
      String ridingClient = splitServerMessagePattern[2].toString();
      String mName = messagename.replaceFirst(" ", "");
      String client = ridingClient.replaceFirst(" ", "").replaceAll("]", "");

      ChatController.to
          .sendMsg(Message(text: mName, sender: User(name: client)));
    } else if (serverMessageName[0].toString() == "[CompleteRideAfterAccept") {
      print(".abc..............complete ride after accept");
      List idList = serverMessageName[1].toString().split(':');
      int id = int.parse(idList[1]);
      print(" =========== Bill Ride ID----------$id");
      FlushBar.showSimpleFlushBar(
          "Ride Complete Succesfully", context, Colors.green, Colors.white);
      BlocProvider.of<GetdriverridelistBloc>(context).add(
          GetAllDriverRideListEvent(map: <String, dynamic>{
        'Str1': DriverConst.str1,
        'Str2': DriverConst.str2,
        'Str3': DriverConst.str3
      }));
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return BillDialog(
            rideRequestId: id,
          );
        },
      ));
    } else if (serverMessageName[0].toString() == "[StartRideAfterAccept") {
      print(".abc..............start after accept");
      FlushBar.showSimpleFlushBar(
          "Ride start", context, Colors.orange, Colors.white);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    var boxHeight = height * 0.15;
    var boxWidth = width * 1;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          title: Text("Home"),
        ),
        drawer: MYDrawer(),
        body: ZoomIn(
          duration: Duration(seconds: 2),
          child: Stack(
            children: [
              Container(
                height: height,
                width: width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //
                      //================= CoruselSlider ===================\\

                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.03,
                            left: width * 0.08,
                            right: width * 0.08),
                        child: Container(
                          height: height * 0.28,
                          width: width,
                          // color: Colors.white,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("images/slider_image1.jpg"),
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                          child: WaveWidget(
                            size: Size(double.infinity, double.infinity),
                            waveAmplitude: 0,
                            config: CustomConfig(
                              colors: [
                                Colors.blue,
                                Colors.lightBlue,
                                Colors.blue,
                                Colors.lightBlue,
                              ],
                              durations: [18000, 8000, 5000, 12000],
                              heightPercentages: [0.85, 0.86, 0.88, 0.90],
                              blur: MaskFilter.blur(BlurStyle.solid, 16.0),
                              //  gradientBegin: Alignment.bottomLeft,
                              //  gradientEnd: Alignment.topRight,
                            ),
                          ),
                        ),
                      ),

                      //
                      //
                      //================= Corusel Slider ===================\\
                      //
                      //================= Total Ride  Request ===================\\
                      //

                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.05,
                            bottom: 5.0,
                            left: width * 0.08,
                            right: width * 0.08),
                        child: Container(
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
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return DriverAllRidingRequestPage();
                                },
                              ));
                            },
                            title: Text(
                              'All Riding Request',
                            ),
                            trailing: Icon(
                              Icons.keyboard_arrow_right_sharp,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      //=================================End Total Request Text =======================\\\\\

                      //
                      //================= Confirm Ride  ===================\\
                      //

                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.02,
                            bottom: 5.0,
                            left: width * 0.08,
                            right: width * 0.08),
                        child: Container(
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
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return DriverConfirmRide();
                                  },
                                ));
                              },
                              title: Text(
                                'Confirmed Ride',
                              ),
                              trailing: Icon(
                                Icons.keyboard_arrow_right_sharp,
                                color: Colors.blue,
                              )),
                        ),
                      ),
                      //================================= End Confirmed ride =======================\\\\\

                      //==================== Total Sales =====================\\

                      Padding(
                        padding: EdgeInsets.only(top: height * 0.03),
                        child: Container(
                          height: height * 0.22,
                          width: width,
                          child: Row(
                            //    mainAxisAlignment: MainAxisAlignment.center,
                            //    crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: width / 2,
                                child: InkWell(
                                  onTap: () {
                                    return Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              TotalDriverSalePage(),
                                        ));
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: width * 0.07,
                                        right: width * 0.025),
                                    child: Center(
                                      child: Card(
                                        elevation: 8,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: Container(
                                          height: height * 0.22,
                                          width: width,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.lightBlue,
                                                  width: 2),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                  alignment: Alignment.center,
                                                  height: boxHeight,
                                                  width: boxWidth,
                                                  child: Image.asset(
                                                    "images/total_earn.png",
                                                    color: Colors.lightBlue,
                                                  )
                                                  // Lottie.asset(
                                                  //     "assets/sale.json"),
                                                  ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: height * 0.01),
                                                child: AutoSizeText(
                                                  "Total Earning",
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontSize: width * 0.035),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              //
                              //
                              //====================== Earn Today =====================\\
                              //
                              //
                              Container(
                                width: width / 2,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: width * 0.03, right: width * 0.07),
                                  child: Center(
                                    child: Card(
                                      elevation: 8,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: InkWell(
                                        onTap: () {
                                          // return Navigator.push(context,
                                          //     MaterialPageRoute(
                                          //   builder: (context) {
                                          //     return DriverEarnToday();
                                          //   },
                                          // ));
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DriverEarnTodayPage()));
                                        },
                                        child: Container(
                                          height: height * 0.22,
                                          width: width,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.lightBlue,
                                                  width: 2),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                  alignment: Alignment.center,
                                                  height: boxHeight,
                                                  width: boxWidth,
                                                  child: Image.asset(
                                                    "images/today_earn.png",
                                                    color: Colors.lightBlue,
                                                  )
                                                  // Lottie.asset(
                                                  //     "assets/money.json"),
                                                  ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: height * 0.01),
                                                child: AutoSizeText(
                                                  "Today Earning",
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontSize: width * 0.035),
                                                ),
                                              )
                                            ],
                                          ),
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

                      // //==================== Completed Payment =====================\\

                      // Padding(
                      //   padding: EdgeInsets.only(top: height * 0.03),
                      //   child: Container(
                      //     height: height * 0.22,
                      //     width: width,
                      //     child: Row(
                      //       //    mainAxisAlignment: MainAxisAlignment.center,
                      //       //    crossAxisAlignment: CrossAxisAlignment.center,
                      //       children: [
                      //         Container(
                      //           width: width / 2,
                      //           child: InkWell(
                      //             onTap: () {},
                      //             child: Padding(
                      //               padding: EdgeInsets.only(
                      //                   left: width * 0.07,
                      //                   right: width * 0.025),
                      //               child: Center(
                      //                 child: Card(
                      //                   elevation: 8,
                      //                   shape: RoundedRectangleBorder(
                      //                       borderRadius: BorderRadius.all(
                      //                           Radius.circular(10))),
                      //                   child: Container(
                      //                     height: height * 0.22,
                      //                     width: width,
                      //                     decoration: BoxDecoration(
                      //                         border: Border.all(
                      //                             color: Colors.blue, width: 2),
                      //                         borderRadius: BorderRadius.all(
                      //                             Radius.circular(10))),
                      //                     child: Column(
                      //                       mainAxisAlignment:
                      //                           MainAxisAlignment.center,
                      //                       children: [
                      //                         // Container(
                      //                         //     alignment: Alignment.center,
                      //                         //     height: boxHeight,
                      //                         //     width: boxWidth,
                      //                         //     child: Lottie.asset(
                      //                         //         "assets/sale.json")),
                      //                         Padding(
                      //                           padding: EdgeInsets.only(
                      //                               top: height * 0.01),
                      //                           child: AutoSizeText(
                      //                             "Total Sales",
                      //                             maxLines: 1,
                      //                             style: TextStyle(
                      //                                 fontSize: width * 0.035),
                      //                           ),
                      //                         )
                      //                       ],
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //         //
                      //         //
                      //         //====================== Received Payment =====================\\
                      //         //
                      //         //
                      //         Container(
                      //           width: width / 2,
                      //           child: InkWell(
                      //             // onTap: () {
                      //             //   Navigator.push(context, MaterialPageRoute(
                      //             //     builder: (context) {
                      //             //       return DriverEarnToday();
                      //             //     },
                      //             //   ));
                      //             // },
                      //             child: Padding(
                      //               padding: EdgeInsets.only(
                      //                   left: width * 0.03,
                      //                   right: width * 0.07),
                      //               child: Center(
                      //                 child: Card(
                      //                   elevation: 8,
                      //                   shape: RoundedRectangleBorder(
                      //                       borderRadius: BorderRadius.all(
                      //                           Radius.circular(10))),
                      //                   child: Container(
                      //                     height: height * 0.22,
                      //                     width: width,
                      //                     decoration: BoxDecoration(
                      //                         border: Border.all(
                      //                             color: Colors.blue, width: 2),
                      //                         borderRadius: BorderRadius.all(
                      //                             Radius.circular(10))),
                      //                     child: Column(
                      //                       mainAxisAlignment:
                      //                           MainAxisAlignment.center,
                      //                       children: [
                      //                         // Container(
                      //                         //     alignment: Alignment.center,
                      //                         //     height: boxHeight,
                      //                         //     width: boxWidth,
                      //                         //     child: Lottie.asset(
                      //                         //         "assets/money.json")),
                      //                         Padding(
                      //                           padding: EdgeInsets.only(
                      //                               top: height * 0.01),
                      //                           child: AutoSizeText(
                      //                             "Earn Today",
                      //                             maxLines: 1,
                      //                             style: TextStyle(
                      //                                 fontSize: width * 0.035),
                      //                           ),
                      //                         )
                      //                       ],
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      //=========================================================================\\

                      // Padding(
                      //   padding: EdgeInsets.only(
                      //       top: height * 0.03, bottom: height * 0.03),
                      //   child: Container(
                      //     height: height * 0.22,
                      //     width: width,
                      //     child: Row(
                      //       //    mainAxisAlignment: MainAxisAlignment.center,
                      //       //    crossAxisAlignment: CrossAxisAlignment.center,
                      //       children: [
                      //         //======================= Reject Ride  =======================\\
                      //         Container(
                      //           width: width / 2,
                      //           child: InkWell(
                      //             onTap: () {
                      //               Navigator.push(context, MaterialPageRoute(
                      //                 builder: (context) {
                      //                   return DriverRejectedRidesPage();
                      //                 },
                      //               ));
                      //             },
                      //             child: Padding(
                      //               padding: EdgeInsets.only(
                      //                   left: width * 0.07,
                      //                   right: width * 0.025),
                      //               child: Center(
                      //                 child: Card(
                      //                   elevation: 8,
                      //                   shape: RoundedRectangleBorder(
                      //                       borderRadius: BorderRadius.all(
                      //                           Radius.circular(10))),
                      //                   child: Container(
                      //                     height: height * 0.22,
                      //                     width: width,
                      //                     decoration: BoxDecoration(
                      //                         border: Border.all(
                      //                             color: Colors.blue, width: 2),
                      //                         borderRadius: BorderRadius.all(
                      //                             Radius.circular(10))),
                      //                     child: Column(
                      //                       mainAxisAlignment:
                      //                           MainAxisAlignment.center,
                      //                       children: [
                      //                         Container(
                      //                             alignment: Alignment.center,
                      //                             height: boxHeight,
                      //                             width: boxWidth,
                      //                             child: Padding(
                      //                               padding: EdgeInsets.all(22),
                      //                               child: Lottie.asset(
                      //                                   "assets/reject.json"),
                      //                             )),
                      //                         Padding(
                      //                           padding: EdgeInsets.only(
                      //                               top: height * 0.01),
                      //                           child: AutoSizeText(
                      //                             "Reject Rides",
                      //                             maxLines: 1,
                      //                             style: TextStyle(
                      //                                 fontSize: width * 0.035),
                      //                           ),
                      //                         )
                      //                       ],
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //         //
                      //         //
                      //         //====================== Completed Ride =====================\\

                      //         Container(
                      //           width: width / 2,
                      //           child: InkWell(
                      //             onTap: () {
                      //               Navigator.push(context, MaterialPageRoute(
                      //                 builder: (context) {
                      //                   return DriverCompletedRidesPage();
                      //                 },
                      //               ));
                      //             },
                      //             child: Padding(
                      //               padding: EdgeInsets.only(
                      //                   left: width * 0.03,
                      //                   right: width * 0.07),
                      //               child: Center(
                      //                 child: Card(
                      //                   elevation: 8,
                      //                   shape: RoundedRectangleBorder(
                      //                       borderRadius: BorderRadius.all(
                      //                           Radius.circular(10))),
                      //                   child: Container(
                      //                     height: height * 0.22,
                      //                     width: width,
                      //                     decoration: BoxDecoration(
                      //                         border: Border.all(
                      //                             color: Colors.blue, width: 2),
                      //                         borderRadius: BorderRadius.all(
                      //                             Radius.circular(10))),
                      //                     child: Column(
                      //                       mainAxisAlignment:
                      //                           MainAxisAlignment.center,
                      //                       children: [
                      //                         Container(
                      //                             alignment: Alignment.center,
                      //                             height: boxHeight,
                      //                             width: boxWidth,
                      //                             child: Lottie.asset(
                      //                                 "assets/check.json")),
                      //                         Padding(
                      //                           padding: EdgeInsets.only(
                      //                               top: height * 0.01),
                      //                           child: AutoSizeText(
                      //                             "Completed Ride",
                      //                             maxLines: 1,
                      //                             style: TextStyle(
                      //                                 fontSize: width * 0.035),
                      //                           ),
                      //                         )
                      //                       ],
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      //=========================================================================\\

                      //=========================================================================\\

                      //
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

  latestRequest() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: Color(0x20000000),
            blurRadius: 10.0,
            spreadRadius: 10.0,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: ExpansionTile(
        title: Text(
          "Latest Request",
          // style: new TextStyle(),
          textAlign: TextAlign.left,
        ),
        children: <Widget>[
          Container(
            height: height,
            child: ListView.builder(
              itemCount: 70,
              itemBuilder: (context, index) => Container(
                  alignment: Alignment.center, width: width, child: Text("Hi")),
            ),
          )
        ],
      ),
    );
  }

  void getlocation() async {
    // print("................location get.............");

    Utils.determinePosition().then((value) async {
      // print(
      //     "...................._current position ................${value.toString()}");

      try {
        // print(
        //     "Str1:${DriverConst.str1}......Str2:${DriverConst.str2}......Str3:${DriverConst.str3}......Str4:${DriverConst.str4}.......");

        if (hubConnection != null) {
          print("---------------UpdateDriverLocation-----------");
          hubConnection.invoke("UpdateDriverLocation", args: [
            "${DriverConst.str1}",
            "${DriverConst.str2}",
            "${DriverConst.str3}",
            "${DriverConst.str4}",
            "${value.latitude}",
            "${value.longitude}",
          ]).catchError((e) {
            // print(
            //     "------------------ Update Driver Location catch error ---------- $e");
          });
        } else {
          // print(
          //     "====================== Hub connection is null =================");
        }
      } catch (e) {
        print(e);
      }
    });
  }

  Future<bool> _onWillPop() {
    return showDialog<dynamic>(
            context: context,
            builder: (BuildContext context) {
              return ConfirmDialogView(
                  description: 'Do you really want to quit?',
                  leftButtonText: 'Cancel',
                  rightButtonText: 'OK',
                  onAgreeTap: () {
                    SystemNavigator.pop();
                  });
            }) ??
        false;
  }
}
/*

CarouselSlider(
                  options: CarouselOptions(
                    // disableCenter: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    enlargeCenterPage: true,
                    // enlargeStrategy: CenterPageEnlargeStrategy.height,
                    // enableInfiniteScroll: false,
                    initialPage: 2,
                    scrollDirection: Axis.horizontal,
                    viewportFraction: 0.8,
                  ),
                  items: sliderImageList
                      .map((item) => Container(
                            height: height * 0.2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                                image: DecorationImage(
                                    image: AssetImage(item), fit: BoxFit.fill)),
                            // child: Image.asset(item,
                            //     fit: BoxFit.fill, width: 1000),
                          ))
                      .toList(),
                ),
*/
