import 'dart:convert';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:clip_shadow/clip_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:get_smart_ride_cas/Commons/commons.dart';
import 'package:get_smart_ride_cas/api/rider_api/rider_api.dart';
import 'package:get_smart_ride_cas/driver/cliper.dart/bottom_rounded_cliper.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_Riding_List.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_all_riding_list.dart';
import 'package:get_smart_ride_cas/rider/bloc/getRidingRequestForClient/bloc/getPenaltyForClient/bloc/getpenalty_bloc.dart';
import 'package:get_smart_ride_cas/rider/home/rider_home_screen.dart';
import 'package:get_smart_ride_cas/rider/objects/penalty.dart';
import 'package:get_smart_ride_cas/rider/screens/penaltyDialogRider.dart';
import 'package:get_smart_ride_cas/utils/utils.dart';
import 'package:get_smart_ride_cas/widgets/flush_bar.dart';

class AcceptOrRejectRideDetails extends StatefulWidget {
  // final DriverAllRidingRequest model;
  final DriverRidingModel ridingModel;
  final timeForPenalty;
  // var requestStatus;
  AcceptOrRejectRideDetails({
    Key key,
    // this.model,
    this.ridingModel,
    this.timeForPenalty,
  }) : super(key: key);

  @override
  _AcceptOrRejectRideDetailsState createState() =>
      _AcceptOrRejectRideDetailsState();
}

class _AcceptOrRejectRideDetailsState extends State<AcceptOrRejectRideDetails> {
  var height, width;
  bool rejected;

//  TextStyle _textStyleHeading = TextStyle(color: Colors.grey, fontSize: 18);
//  TextStyle _textStyleText = TextStyle(fontSize: 18);
  // rejectRidingRequestAfterAccept(String str1, String str2, String str3,
  //     String str4, String rideRequestId, String penaltyAmount){

  //     }

  // List<String>
  DriverAllRidingRequest model;
  List<RiderPenalty> riderpenaltyList = List();
  var charges;

  int charge;
  Future<List<RiderPenalty>> getPenaltyListByRidingRequestId(
      int ridingRequestId) async {
    final http.Response response = await http.post(RiderApi.getPenaltyForRider,
        body: jsonEncode(
            <String, String>{"RidingRequestId": ridingRequestId.toString()}),
        headers: <String, String>{
          "Content-type": "application/json; charset=utf-8"
        });
    //{"RidingRequestId": ridingRequestId.toString()});
    if (response.statusCode == 200) {
      var output = jsonDecode(response.body);
      print(output.toString());
      print(response.statusCode);
      return RiderPenalty.fromMapList(output);
    } else {
      throw Exception('Failed to create .');
    }
  }

  Future loadPenaltyList(int ridingRequestId) async {
    riderpenaltyList = await getPenaltyListByRidingRequestId(ridingRequestId);
    print("legnth  is........... ${riderpenaltyList.length}");
    setState(() {});
  }

  @override
  void initState() {
    print(".............${widget.ridingModel.ridingRequestId}");
    loadPenaltyList(widget.ridingModel.ridingRequestId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    print("......penalty time..........${widget.ridingModel.penaltyAmount}");
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        //   color: Colors.blue,
        child: SingleChildScrollView(
          child: Column(
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
                padding:
                    EdgeInsets.only(left: width * 0.05, right: width * 0.05),
                child: Container(
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
                  height: height * 0.2,
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

                                  color: Colors.black,
                                ),
                              ),
                              Icon(
                                Icons.radio_button_unchecked,
                                size: 15,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "From:",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Container(
                                      width: width * 0.73,
                                      child: AutoSizeText(
                                        "${widget.ridingModel.fromAddress}",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: height * 0.04),
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "To:",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      Container(
                                        width: width * 0.73,
                                        child: AutoSizeText(
                                          "${widget.ridingModel.toAddress}",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(color: Colors.black),
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
                padding: EdgeInsets.all(8.0),
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
                              '${widget.ridingModel.ridingClientName}',
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
                              '${widget.ridingModel.ridingClientPhoneNumber}',
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
                              '${Utils.getTimeinformat(widget.ridingModel.requestTimeDate)}',
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
                                '${Utils.getDateFormat(widget.ridingModel.requestTimeDate)}',
                              ),
                              leading: Icon(
                                Icons.calendar_today_sharp,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        charges != null || widget.ridingModel.requestStatus == 3
                            ? Padding(
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
                                      '${charges == null ? 0 : charges.toString()}}',
                                    ),
                                    leading: Icon(
                                      Icons.calendar_today_sharp,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ),
                ),
              ),

              //======================== Buttons ========================\\
              widget.ridingModel.requestStatus == 3 ||
                      widget.ridingModel.requestStatus == 4 ||
                      widget.ridingModel.requestStatus == 5
                  ? Container()
                  : Padding(
                      padding: EdgeInsets.only(
                          top: height * 0.0,
                          left: width * 0.05,
                          right: width * 0.05),
                      child: InkWell(
                        onTap: () async {
                          if (RiderHomeScreen.hubConnection != null) {
                            RiderHomeScreen.hubConnection.invoke(
                                "RejectRidingRequestAfterAccept",
                                args: [
                                  "${Commons.riderEmail}",
                                  "${Commons.riderPhoneNO}",
                                  "",
                                  "RidingClient",
                                  "${widget.ridingModel.ridingRequestId}",
                                  "${riderpenaltyList[0].penaltyCharges}",
                                ]).catchError((e) {
                              print(
                                  "------------------ rejected Error ---------- $e");
                            });
                            Navigator.pop(context);
                          } else {
                            //   DriverDashboard.hubConnection.start();

                            FlushBar.showSimpleFlushBar("Server not Connected",
                                context, Colors.red, Colors.white);
                          }
                        },
                        child: InkWell(
                            onTap: () async {
                              rejected = true;
                              charges = await showGeneralDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  barrierLabel:
                                      MaterialLocalizations.of(context)
                                          .modalBarrierDismissLabel,
                                  barrierColor: Colors.black45,
                                  transitionDuration:
                                      const Duration(milliseconds: 200),
                                  pageBuilder: (BuildContext buildContext,
                                      Animation animation,
                                      Animation secondaryAnimation) {
                                    return BlocProvider<GetpenaltyBloc>(
                                      create: (context) => GetpenaltyBloc(),
                                      child: PenaltyDialogRider(
                                        ridingRequestId:
                                            widget.ridingModel.ridingRequestId,
                                        driverRidingModel: widget.ridingModel,
                                        riderPenaltyChargers:
                                            riderpenaltyList[0],
                                        timeForPenalty: widget.timeForPenalty,
                                      ),
                                    );
                                  });
                              setState(() {});

                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => BlocProvider<GetpenaltyBloc>(
                              //             create: (BuildContext context) =>
                              //                 GetpenaltyBloc(),
                              //             child: PenaltyDialogRider(
                              //               ridingRequestId:
                              //                   widget.ridingModel.ridingRequestId,
                              //             )

                              //             )));
                            },
                            child: rejected == true
                                ? Container()
                                : Container(
                                    alignment: Alignment.center,
                                    height: height * 0.06,
                                    width: width * 0.4,
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
                                      "Reject",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17),
                                    ),
                                  )),
                      ),
                    ),
              Padding(
                padding: EdgeInsets.only(
                    top: height * 0.0, left: width * 0.05, right: width * 0.05),
                child: InkWell(
                  onTap: () async {},
                  child: InkWell(
                      onTap: () async {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => BlocProvider<GetpenaltyBloc>(
                        //             create: (BuildContext context) =>
                        //                 GetpenaltyBloc(),
                        //             child: PenaltyDialogRider(
                        //               ridingRequestId:
                        //                   widget.ridingModel.ridingRequestId,
                        //             )

                        //             )));
                      },
                      child: widget.ridingModel.ridingRequestId == 5
                          ? Container(
                              alignment: Alignment.center,
                              height: height * 0.06,
                              width: width * 0.4,
                              decoration: BoxDecoration(
                                  color: Colors.red,
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
                                "Bill",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                            )
                          : Container()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
