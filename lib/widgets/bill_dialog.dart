import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get_smart_ride_cas/driver/home/screens/driver_dashboard.dart';
import 'package:get_smart_ride_cas/utils/utils.dart';
import 'package:intl/intl.dart';

import 'package:get_smart_ride_cas/api/common/ps_resource.dart';
import 'package:get_smart_ride_cas/api/driver_api/driver_api_services.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_ride_bill.dart';
import 'package:get_smart_ride_cas/driver/home/screens/driver_all_ridig_list_page.dart';

class BillDialog extends StatefulWidget {
  final int rideRequestId;
  BillDialog({
    this.rideRequestId,
  });
  @override
  _BillDialogState createState() => _BillDialogState();
}

class _BillDialogState extends State<BillDialog> {
  ApiServices _api = ApiServices();
  DriverRideBill billModel;
  Future<PsResource<List<DriverRideBill>>> getRideBill(int rideId) async {
    PsResource<List<DriverRideBill>> _resource = await _api
        .getDriverRideBill(<String, dynamic>{'RidingRequestId': rideId});
    return _resource;
  }

  bool isLoading = false;
  TextStyle _textStyleforTrialing = TextStyle(color: Colors.lightBlue);

  @override
  void initState() {
    isLoading = true;
    getRideBill(widget.rideRequestId).then((value) {
      setState(() {
        isLoading = false;
        billModel = value.data[0];
      });
    });
    super.initState();
  }

  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          automaticallyImplyLeading: false,
          title: Center(child: Text("Ride Invice")),
        ),
        body: isLoading == true
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Container(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: height * 0.05,
                      bottom: 5.0,
                      left: width * 0.05,
                      right: width * 0.05),
                  child: ListView(
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
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
                              '${billModel.rideRequestId}',
                              style: _textStyleforTrialing,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
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
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${Utils.getDateFormat(billModel.billTimeDate)}',
                                  style: _textStyleforTrialing,
                                ),
                                Text(
                                  '${Utils.getTimeinformat(billModel.billTimeDate)}',
                                  style: _textStyleforTrialing,
                                ),
                              ],
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
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
                              '${billModel.billTotalAmount}',
                              style: _textStyleforTrialing,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
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
                              '${billModel.penaltyAmount}',
                              style: _textStyleforTrialing,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
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
                              '${billModel.rateCostPerKM}',
                              style: _textStyleforTrialing,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
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
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${Utils.getDateFormat(billModel.rideStartTime)}',
                                  style: _textStyleforTrialing,
                                ),
                                Text(
                                  '${Utils.getTimeinformat(billModel.rideStartTime)}',
                                  style: _textStyleforTrialing,
                                ),
                              ],
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
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
                              '${billModel.actualMTraveled}',
                              style: _textStyleforTrialing,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
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
                              '${billModel.currentRideAmount}',
                              style: _textStyleforTrialing,
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
                            Navigator.pop(context);
                            Navigator.pop(context);
                            // Navigator.pushAndRemoveUntil(context,
                            //     MaterialPageRoute(
                            //   builder: (context) {
                            //     return DriverDashboard();
                            //   },
                            // ), (route) => true);
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                          ),
                        ),
                      )
                    ],
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
