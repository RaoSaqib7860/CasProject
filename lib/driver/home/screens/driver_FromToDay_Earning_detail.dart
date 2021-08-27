import 'package:flutter/material.dart';

import 'package:get_smart_ride_cas/driver/view_object/driver_today_earnings.dart';
import 'package:intl/intl.dart';
import 'package:clip_shadow/clip_shadow.dart';
import 'package:get_smart_ride_cas/driver/cliper.dart/bottom_rounded_cliper.dart';
import 'package:get_smart_ride_cas/utils/utils.dart';

class TotalSaleDetail extends StatefulWidget {
  DriverTodayEarning model;
  TotalSaleDetail({
    this.model,
  });
  @override
  _TotalSaleDetailState createState() => _TotalSaleDetailState();
}

class _TotalSaleDetailState extends State<TotalSaleDetail> {
  var height, width;

  TextStyle _textStyleHeading = TextStyle(color: Colors.grey, fontSize: 18);
  TextStyle _textStyleforTrialing = TextStyle(color: Colors.lightBlue);

  // List<String>

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text("Ride Detail"),
        backgroundColor: Colors.lightBlue,
      ),
      body: Container(
        child: ListView(
          children: [
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
                  // child: Padding(
                  //   padding: EdgeInsets.only(left: width * 0.08),
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Padding(
                  //         padding: EdgeInsets.only(top: height * 0.1),
                  //         child: Container(
                  //           child: Text(
                  //             "Ride",
                  //             style: TextStyle(
                  //                 fontSize: 26,
                  //                 color: Colors.white,
                  //                 fontWeight: FontWeight.bold),
                  //           ),
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: EdgeInsets.only(top: height * 0.02),
                  //         child: Container(
                  //           child: Text(
                  //             "Detai",
                  //             style: TextStyle(
                  //                 fontSize: 29,
                  //                 color: Colors.white,
                  //                 fontWeight: FontWeight.bold),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ),
              ),
            ),

            //===================== End Image Clipper ========================\\

            Padding(
              padding: EdgeInsets.only(
                  top: height * 0.01,
                  bottom: 5.0,
                  left: width * 0.05,
                  right: width * 0.05),
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
                    '${widget.model.rideRequestId}',
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
                  left: width * 0.05,
                  right: width * 0.05),
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
                    'Name',
                  ),
                  trailing: Text(
                    '${widget.model.ridingClientName}',
                    style: _textStyleforTrialing,
                  ),
                ),
              ),
            ),
            //
            //
            //
            //
            Padding(
              padding: EdgeInsets.only(
                  top: height * 0.01,
                  bottom: 5.0,
                  left: width * 0.05,
                  right: width * 0.05),
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
                    'Phone NO',
                  ),
                  trailing: Text(
                    '${widget.model.ridingClientPhoneNumber}',
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
                  left: width * 0.05,
                  right: width * 0.05),
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
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${Utils.getDateFormat(widget.model.billTimeDate)}',
                        style: _textStyleforTrialing,
                      ),
                      Text(
                        '${Utils.getTimeinformat(widget.model.billTimeDate)}',
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
                  left: width * 0.05,
                  right: width * 0.05),
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
                    '${widget.model.billTotalAmount}',
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
                  left: width * 0.05,
                  right: width * 0.05),
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
                    '${widget.model.penaltyAmount}',
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
                  left: width * 0.05,
                  right: width * 0.05),
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
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${Utils.getDateFormat(widget.model.rideStartTime)}',
                        style: _textStyleforTrialing,
                      ),
                      Text(
                        '${Utils.getTimeinformat(widget.model.rideStartTime)}',
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
                  left: width * 0.05,
                  right: width * 0.05),
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
                    'Ride End Time',
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${Utils.getDateFormat(widget.model.rideEndTime)}',
                        style: _textStyleforTrialing,
                      ),
                      Text(
                        '${Utils.getTimeinformat(widget.model.rideEndTime)}',
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
                  bottom: height * 0.03,
                  left: width * 0.05,
                  right: width * 0.05),
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
                    'Current Ride Ammount',
                  ),
                  trailing: Text(
                    '${widget.model.currentRideAmount}',
                    style: _textStyleforTrialing,
                  ),
                ),
              ),
            ),
            //
          ],
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
