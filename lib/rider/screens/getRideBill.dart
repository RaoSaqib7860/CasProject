import 'dart:math';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_smart_ride_cas/rider/bloc/getRidingRequestForClient/bloc/getRideBill/bloc/getridebill_bloc.dart';
import 'package:get_smart_ride_cas/rider/objects/getRideBill.dart';
import 'package:intl/intl.dart';

import 'package:get_smart_ride_cas/api/common/ps_resource.dart';
import 'package:get_smart_ride_cas/api/driver_api/driver_api_services.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_ride_bill.dart';
import 'package:get_smart_ride_cas/driver/home/screens/driver_all_ridig_list_page.dart';

class GetRideBillClass extends StatefulWidget {
  final int rideRequestId;
  GetRideBillClass({
    this.rideRequestId,
  });
  @override
  _GetRideBillClassState createState() => _GetRideBillClassState();
}

class _GetRideBillClassState extends State<GetRideBillClass> {
  ApiServices _api = ApiServices();
  // DriverRideBill billModel;
  // Future<PsResource<List<DriverRideBill>>> getRideBill(int rideId) async {
  //   PsResource<List<DriverRideBill>> _resource = await _api
  //       .getDriverRideBill(<String, dynamic>{'RidingRequestId': rideId});
  //   return _resource;
  // }

  bool isLoading = false;
  GetRideBill getRideBill;
  @override
  void initState() {
    BlocProvider.of<GetridebillBloc>(context)
        .add(GetRideBillInsertEvent(widget.rideRequestId));
    print("........RIDE REQUEST IDDD.....${widget.rideRequestId}");
    // isLoading = true;
    // getRideBill(widget.rideRequestId).then((value) {
    //   setState(() {
    //     isLoading = false;
    //     billModel = value.data[0];
    //   });
    // });
    super.initState();
  }

  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: ()async {
          print(".abc..... on willposcope of get ride bill");
          //Navigator.pop(context);
          return false;
        },
          child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: Center(child: Text("Invice")),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          child: Padding(
            padding: EdgeInsets.only(
                top: height * 0.05,
                bottom: 5.0,
                left: width * 0.05,
                right: width * 0.05),
            child: BlocBuilder<GetridebillBloc, GetridebillState>(
              builder: (BuildContext context, state) {
                if (state is GetridebillInitial) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is GetRideBillLoadedState) {
                  getRideBill = state.getRideBillList[0];
                  print(
                      "LOADED STATETE Listtt $getRideBill,....................");
                  return ListView(
                    children: [
                      // Container(
                      //   alignment: Alignment.center,
                      //   height: height * 0.06,
                      //   width: width,
                      //   decoration: BoxDecoration(
                      //       color: Colors.blue,
                      //       borderRadius: BorderRadius.all(Radius.circular(12)),
                      //       boxShadow: [
                      //         BoxShadow(
                      //             color: Color(0x20000000),
                      //             blurRadius: 10.0,
                      //             spreadRadius: 10.0,
                      //             offset: Offset(0, 3))
                      //       ]),
                      //   child: AutoSizeText(
                      //     "Ride Invice",
                      //     style: TextStyle(
                      //         fontSize: 25,
                      //         color: Colors.white,
                      //         fontWeight: FontWeight.bold),
                      //   ),
                      // ),

                      //
                      //
                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.01,
                            bottom: 5.0,
                            left: width * 0.02,
                            right: width * 0.02),
                        child: Container(
                          //  height: height * 0.08,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0x20000000),
                                    blurRadius: 10.0,
                                    spreadRadius: 10.0,
                                    offset: Offset(0, 0))
                              ]),
                          child: ListTile(
                            title: Text(
                              'Ride Request ID',
                            ),
                            trailing: Text(
                              '${getRideBill.rideRequestId}',
                            ),
                          ),
                        ),
                      ),
                      //
                      //
                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.01,
                            bottom: 5.0,
                            left: width * 0.02,
                            right: width * 0.02),
                        child: Container(
                          //  height: height * 0.08,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0x20000000),
                                    blurRadius: 10.0,
                                    spreadRadius: 10.0,
                                    offset: Offset(0, 0))
                              ]),
                          child: ListTile(
                            title: Text(
                              'Bill Time Date',
                            ),
                            trailing: Text(
                              '${getRideBill.billTimeDate}',
                            ),
                          ),
                        ),
                      ),
                      //
                      //
                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.01,
                            bottom: 5.0,
                            left: width * 0.02,
                            right: width * 0.02),
                        child: Container(
                          //  height: height * 0.08,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0x20000000),
                                    blurRadius: 10.0,
                                    spreadRadius: 10.0,
                                    offset: Offset(0, 0))
                              ]),
                          child: ListTile(
                            title: Text(
                              'Bill Total Amount',
                            ),
                            trailing: Text(
                              '${getRideBill.billTotalAmount}',
                            ),
                          ),
                        ),
                      ),
                      //
                      //
                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.01,
                            bottom: 5.0,
                            left: width * 0.02,
                            right: width * 0.02),
                        child: Container(
                          //  height: height * 0.08,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0x20000000),
                                    blurRadius: 10.0,
                                    spreadRadius: 10.0,
                                    offset: Offset(0, 0))
                              ]),
                          child: ListTile(
                            title: Text(
                              'Penalty Amount',
                            ),
                            trailing: Text(
                              '${getRideBill.penaltyAmount}',
                            ),
                          ),
                        ),
                      ),
                      //
                      //
                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.01,
                            bottom: 5.0,
                            left: width * 0.02,
                            right: width * 0.02),
                        child: Container(
                          //  height: height * 0.08,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0x20000000),
                                    blurRadius: 10.0,
                                    spreadRadius: 10.0,
                                    offset: Offset(0, 0))
                              ]),
                          child: ListTile(
                            title: Text(
                              'Rate CostPer KM',
                            ),
                            trailing: Text(
                              '${getRideBill.rateCostPerKM}',
                            ),
                          ),
                        ),
                      ),
                      //
                      //
                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.01,
                            bottom: 5.0,
                            left: width * 0.02,
                            right: width * 0.02),
                        child: Container(
                          //  height: height * 0.08,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0x20000000),
                                    blurRadius: 10.0,
                                    spreadRadius: 10.0,
                                    offset: Offset(0, 0))
                              ]),
                          child: ListTile(
                            title: Text(
                              'Ride Start Time',
                            ),
                            trailing: Text(
                              '${getRideBill.rideStartTime}',
                            ),
                          ),
                        ),
                      ),
                      //
                      //
                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.01,
                            bottom: 5.0,
                            left: width * 0.02,
                            right: width * 0.02),
                        child: Container(
                          //  height: height * 0.08,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0x20000000),
                                    blurRadius: 10.0,
                                    spreadRadius: 10.0,
                                    offset: Offset(0, 0))
                              ]),
                          child: ListTile(
                            title: Text(
                              'Actual M Traveled',
                            ),
                            trailing: Text(
                              '${getRideBill.actualMTraveled}',
                            ),
                          ),
                        ),
                      ),
                      //
                      //
                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.01,
                            bottom: 5.0,
                            left: width * 0.02,
                            right: width * 0.02),
                        child: Container(
                          //  height: height * 0.08,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0x20000000),
                                    blurRadius: 10.0,
                                    spreadRadius: 10.0,
                                    offset: Offset(0, 0))
                              ]),
                          child: ListTile(
                            title: Text(
                              'Current Ride Amount',
                            ),
                            trailing: Text(
                              '${getRideBill.currentRideAmount}',
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.01,
                            bottom: 5.0,
                            left: width * 0.02,
                            right: width * 0.02),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            if(Navigator.canPop(context)){
                              print(".abc..............canpop.....true");
                              Navigator.pop(context);
                            }
                            else{    print(".abc..............canpop.....false");}
                                
                            // Navigator.pushReplacement(context, MaterialPageRoute(
                            //   builder: (context) {
                            //     return DriverAllRidingRequestPage();
                            //   },
                            // ));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: height * 0.06,
                            //   width: width * 0.4,
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
                              " Check Out ",
                              style: TextStyle(color: Colors.white, fontSize: 17),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                } else
                  return Container();
              },
            ),
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
