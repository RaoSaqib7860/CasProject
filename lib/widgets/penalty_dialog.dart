import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get_smart_ride_cas/Commons/hub_connection.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_all_riding_list.dart';
import 'package:intl/intl.dart';

import 'package:get_smart_ride_cas/api/common/ps_resource.dart';
import 'package:get_smart_ride_cas/api/driver_api/driver_api_services.dart';
import 'package:get_smart_ride_cas/driver/constant/ps_constants.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_penalty.dart';
import 'package:get_smart_ride_cas/utils/utils.dart';
import 'package:get_smart_ride_cas/widgets/flush_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_smart_ride_cas/driver/bloc/getdriverridelist_bloc.dart';

class PenaltyDialog extends StatefulWidget {
  final int ridingRequestId;
  DriverAllRidingRequest model;
  PenaltyDialog({this.ridingRequestId, this.model});
  @override
  _PenaltyDialogState createState() => _PenaltyDialogState();
}

class _PenaltyDialogState extends State<PenaltyDialog> {
  ApiServices _api = ApiServices();
  Future<PsResource<List<DriverPenalty>>> getPenaltyPrice() async {
    PsResource<List<DriverPenalty>> _resource = await _api.getDriverPenalty({
      "Str1": "${DriverConst.str1}",
      "Str2": "${DriverConst.str2}",
      "Str3": "${DriverConst.str3}"
    });

    print(_resource.data[0].responseTimeDuration);
    return _resource;
  }

  PsResource<List<DriverPenalty>> model;
  bool isLoading = false;
  @override
  void initState() {
    isLoading = true;
    Utils.checkInternetConnectivity().then((value) {
      if (true) {
        getPenaltyPrice().then((value) {
          setState(() {
            isLoading = false;
            model = value;
          });
        });
      }
    });

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
      child: isLoading == true
          ? Container(
              height: height * 0.4,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
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
                              "${(model.data[0].penaltyCharges).toInt()}",
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
                        // final requestDateTime =
                        //     "${widget.model.requestTimeDate.replaceAll("T", " ")}";
                        // print(requestDateTime);
                        // final formatter = DateFormat("yyyy-MM-dd").add_Hms();
                        // final dateTime = formatter.parse(requestDateTime);
                        // //   print("Requested DateTime in String...");

                        // var now = DateTime.now();
                        // var difference = now.difference(dateTime);
                        // var second = difference.inSeconds;
                        // // DateFormat("ss").format(DateTime.parse(""));
                        // //

                        // print(
                        //     ".......... Time Difference ...${difference.toString()}..second..");
                        Utils.checkInternetConnectivity().then((value) {
                          if (value) {
                            if (hubConnection != null) {
                              hubConnection.invoke(
                                  "RejectRidingRequestAfterAccept",
                                  args: [
                                    "${DriverConst.str1}",
                                    "${DriverConst.str2}",
                                    "${DriverConst.str3}",
                                    "${DriverConst.str4}",
                                    "${widget.ridingRequestId}",
                                    "${model.data[0].penaltyCharges}",
                                  ]).catchError((e) {
                                print(
                                    "------------------ rejected Error ---------- $e");
                              });

                              FlushBar.showSimpleFlushBar(
                                  "Reject  Successfullly",
                                  context,
                                  Colors.red,
                                  Colors.white);
                              Utils.checkInternetConnectivity()
                                  .then((value) async {
                                if (value == true) {
                                  BlocProvider.of<GetdriverridelistBloc>(
                                          context)
                                      .add(GetAllDriverRideListEvent(
                                          map: <String, dynamic>{
                                        'Str1': DriverConst.str1,
                                        'Str2': DriverConst.str2,
                                        'Str3': DriverConst.str3
                                      }));
                                  // PsResource<List<DriverAllRidingRequest>> _resource =
                                  //     await _apiServices.getDriverAllRidingList(<String, dynamic>{
                                  //   'Str1': DriverConst.str1.toString(),
                                  //   'Str2': DriverConst.str2.toString(),
                                  //   'Str3': DriverConst.str3.toString()
                                  // });

                                  // if (_resource != null) {
                                  //   setState(() {
                                  //     //  _list = _resource.data;
                                  //     isloading = false;
                                  //     // _myId = _list[0].myId;
                                  //   });
                                  // }
                                } else {}
                              });
                            } else {
                              //   DriverDashboard.hubConnection.start();

                              FlushBar.showSimpleFlushBar(
                                  "Server not Connected",
                                  context,
                                  Colors.red,
                                  Colors.white);
                            }
                          } else {
                            FlushBar.showSimpleFlushBar(
                                "Check internet connection",
                                context,
                                Colors.red,
                                Colors.white);
                          }
                        });
                        Navigator.of(context).pop(["hi"]);
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
                      height: height * 0.02,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: height * 0.06,
                        width: width * 0.5,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0x20000000),
                                  blurRadius: 10.0,
                                  spreadRadius: 10.0,
                                  offset: Offset(0, 3))
                            ]),
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                  ],
                ),
              ),
            ),
    );
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
}
