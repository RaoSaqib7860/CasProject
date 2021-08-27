import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:get_smart_ride_cas/Commons/commons.dart';
import 'package:get_smart_ride_cas/api/common/ps_resource.dart';
import 'package:get_smart_ride_cas/api/driver_api/driver_api_services.dart';
import 'package:get_smart_ride_cas/driver/constant/ps_constants.dart';
import 'package:get_smart_ride_cas/driver/home/screens/driver_dashboard.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_Riding_List.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_penalty.dart';
import 'package:get_smart_ride_cas/rider/bloc/getRidingRequestForClient/bloc/getPenaltyForClient/bloc/getpenalty_bloc.dart';
import 'package:get_smart_ride_cas/rider/home/rider_home_screen.dart';
import 'package:get_smart_ride_cas/rider/objects/penalty.dart';
import 'package:get_smart_ride_cas/utils/utils.dart';
import 'package:get_smart_ride_cas/widgets/flush_bar.dart';

class PenaltyDialogRider extends StatefulWidget {
  final int ridingRequestId;
  final DriverRidingModel driverRidingModel;
  final RiderPenalty riderPenaltyChargers;
  final timeForPenalty;
  PenaltyDialogRider(
      {Key key,
      this.ridingRequestId,
      this.driverRidingModel,
      this.riderPenaltyChargers,
      this.timeForPenalty})
      : super(key: key);
  @override
  _PenaltyDialogRiderState createState() => _PenaltyDialogRiderState();
}

class _PenaltyDialogRiderState extends State<PenaltyDialogRider> {
  ApiServices _api = ApiServices();
  List<RiderPenalty> riderPenaltyList;
  // Future<PsResource<List<DriverPenalty>>> getPenaltyPrice() async {
  //   // PsResource<List<DriverPenalty>> _resource = await _api.getDriverPenalty({
  //   //   "Str1": "${DriverConst.str1}",
  //   //   "Str2": "${DriverConst.str2}",
  //   //   "Str3": "${DriverConst.str3}"
  //   // });

  //   // print(_resource.data[0].responseTimeDuration);
  //   // return _resource;
  // }
  // rejectRidingRequestAfterAccept(String str1, String str2, String str3,
  //     String str4, String rideRequestId, String penaltyAmount) {
  //   if (RiderHomeScreen.hubConnection != null) {
  //     RiderHomeScreen.hubConnection
  //         .invoke("RejectRidingRequestAfterAccept", args: [
  //       "${Commons.riderEmail}",
  //       "${Commons.riderPhoneNO}",
  //       "",
  //       "RidingClient",
  //       "${widget.driverRidingModel.ridingRequestId}",
  //       "${widget.riderPenaltyChargers.penaltyCharges}",
  //     ]).catchError((e) {
  //       print("------------------ rejected Error ---------- $e");
  //     });
  //     Navigator.pop(context);
  //   }
  // }

  PsResource<List<DriverPenalty>> model;
  bool isLoading = false;
  @override
  void initState() {
    BlocProvider.of<GetpenaltyBloc>(context)
        .add(GetPenaltyInsertEvent(ridingRequestId: widget.ridingRequestId));

    //isLoading = true;
    // Utils.checkInternetConnectivity().then((value) {
    //   if (true) {
    //     getPenaltyPrice().then((value) {
    //       setState(() {
    //         isLoading = false;
    //         model = value;
    //       });
    //     });
    //   }
    // });

    // TODO: implement initState

    super.initState();
  }

  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Dialog(
      elevation: 8,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<GetpenaltyBloc, GetpenaltyState>(
          builder: (BuildContext context, state) {
            if (state is GetpenaltyInitial) {
              print("...............loading state");
              return CircularProgressIndicator();
            } else if (state is GetPenaltyLoadedState) {
              riderPenaltyList = state.riderPenaltyList;
              print("...............loaded state");
              return Container(
                //    decoration: BoxDecoration(color: Colors.blue),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Text(
                        "Reject Ride",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.lightBlue),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.02, right: width * 0.02),
                      child: Container(
                        child: AutoSizeText(
                          "if you Reject ride you have to pay penalty.",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.07,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.02, right: width * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            child: AutoSizeText(
                              "${(riderPenaltyList[0].penaltyCharges).toInt()}",
                              style:
                                  TextStyle(fontSize: 80, color: Colors.blue),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: height * 0.02),
                            child: Container(
                              child: AutoSizeText(
                                "Rs",
                                style: TextStyle(fontSize: 30),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.07,
                    ),
                    InkWell(
                      onTap: () {
                        if (widget.timeForPenalty > 90 &&
                            widget.driverRidingModel.requestStatus != 2) {
                          print("NO PENALTY..................");
                          //  Navigator.pop(context);

                          rejectRidingRequestAfterAccept(0);
                          // print("NO PENALTY..................");
                          // print(
                          //     "........NO PENALTY C H A R G E S......${state.riderPenaltyList[0].penaltyCharges}");
                        } else {
                          rejectRidingRequestAfterAccept(
                              state.riderPenaltyList[0].penaltyCharges);
                          print(
                              "........C H A R G E S......${state.riderPenaltyList[0].penaltyCharges}");
                        }

                        // if (RiderHomeScreen.hubConnection != null) {
                        //   RiderHomeScreen.hubConnection
                        //       .invoke("RejectRidingRequestAfterAccept", args: [
                        //     "${Commons.riderEmail}",
                        //     "${Commons.riderPhoneNO}",
                        //     "",
                        //     "RidingClient",
                        //     "${widget.ridingRequestId}",
                        //     "${state.riderPenaltyList[0].penaltyCharges}",
                        //   ]).catchError((e) {
                        //     print(
                        //         "------------------ rejected Error ---------- $e");
                        //   });
                        //   Navigator.pop(context);
                        //   FlushBar.showSimpleFlushBar("Reject  Successfullly",
                        //       context, Colors.red, Colors.white);
                        // } else {
                        //   //   DriverDashboard.hubConnection.start();

                        //   FlushBar.showSimpleFlushBar("Server not Connected",
                        //       context, Colors.red, Colors.white);
                        // }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: height * 0.06,
                        width: width * 0.5,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0x20000000),
                                  blurRadius: 10.0,
                                  spreadRadius: 10.0,
                                  offset: Offset(0, 3))
                            ]),
                        child: Text(
                          "Reject Ride",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                  ],
                ),
              );
            }
            return Text("aqsa");
          },
        ),
      ),
    );
  }

  rejectRidingRequestAfterAccept(var riderPenalty) {
    if (RiderHomeScreen.hubConnection != null) {
      RiderHomeScreen.hubConnection
          .invoke("RejectRidingRequestAfterAccept", args: [
        "${Commons.riderEmail}",
        "${Commons.riderPhoneNO}",
        "",
        "RidingClient",
        "${widget.ridingRequestId}",
        "$riderPenalty",
      ]).catchError((e) {
        print("------------------ rejected Error ---------- $e");
      });
      Navigator.pop(context, riderPenalty);
      FlushBar.showSimpleFlushBar(
          "Reject  Successfullly", context, Colors.red, Colors.white);
    } else {
      //   DriverDashboard.hubConnection.start();

      FlushBar.showSimpleFlushBar(
          "Server not Connected", context, Colors.red, Colors.white);
    }
  }

  getTimeinformat(String timeFromList) {
    var date = "$timeFromList";
    String time = DateFormat.jm().format(DateTime.parse(date));
    return time;
  }

  getDateFormat(String d) {
    String date = DateFormat('yyyy-MM-dd').format(DateTime.parse(d));
    return date;
  }
  //return date;
}

//   }
// }
