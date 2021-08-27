import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get_smart_ride_cas/api/driver_api/driver_api_services.dart';
import 'package:get_smart_ride_cas/driver/constant/ps_constants.dart';
import 'package:get_smart_ride_cas/utils/utils.dart';
import 'package:get_smart_ride_cas/widgets/flush_bar.dart';

import 'package:get_smart_ride_cas/driver/home/screens/driver_FromToDay_Earning_detail.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_today_earnings.dart';
import 'package:intl/intl.dart';

class TotalDriverSalePage extends StatefulWidget {
  @override
  _TotalDriverSalePageState createState() => _TotalDriverSalePageState();
}

class _TotalDriverSalePageState extends State<TotalDriverSalePage> {
  var height, width;

  String selectedFromDate;

  String selectedToDate;

  ApiServices _api = ApiServices();

  List<DriverTodayEarning> dataList = List();
  bool isLoading = false;

  int totalRides = 0;
  double totalPenalty = 0, totalEarning = 0;
  _selectFromDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(), // Refer step 1
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
        initialEntryMode: DatePickerEntryMode.input);
    if (picked != null) {
      setState(() {
        selectedFromDate =
            DateFormat("MM/dd/yyyy").format(DateTime.parse(picked.toString()));
        print("--------Date Selected ---------$selectedFromDate");
      });

      return selectedFromDate;
    }
  }

  _selectToDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(), // Refer step 1
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
        initialEntryMode: DatePickerEntryMode.input);
    if (picked != null) {
      setState(() {
        selectedToDate =
            DateFormat("MM/dd/yyyy").format(DateTime.parse(picked.toString()));
        print("--------Date Selected ---------$selectedFromDate");
      });

      return selectedFromDate;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: height * 0.43,
              floating: true,
              pinned: false,
              snap: true,
              title: Text('Total Earning'),
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: Colors.lightBlue,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.13,
                        left: width * 0.09,
                        right: width * 0.09),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            _selectFromDate();
                          },
                          child: Container(
                            // height: height * 0.05,
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
                                selectedFromDate == null
                                    ? 'From Date'
                                    : ' From : $selectedFromDate',
                              ),
                              trailing: Icon(
                                Icons.calendar_today_outlined,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: height * 0.02),
                          child: InkWell(
                            onTap: () {
                              _selectToDate();
                            },
                            child: Container(
                              // height: height * 0.05,
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
                                  selectedToDate == null
                                      ? 'To Date'
                                      : ' To : $selectedToDate',
                                ),
                                trailing: Icon(
                                  Icons.calendar_today_outlined,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                        ),
                        //
                        //
                        //=========================== Submit Button ======================\\
                        //
                        //
                        Padding(
                          padding: EdgeInsets.only(
                            top: height * 0.025,
                            //  left: ,
                            right: width * 0.09,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.8),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                  ),
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            height: 45,
                            width: width * 0.84,
                            child: FlatButton(
                              onPressed: () async {
                                if (selectedFromDate == null ||
                                    selectedToDate == null) {
                                  FlushBar.showSimpleFlushBar("Select Date",
                                      context, Colors.pink, Colors.white);
                                } else {
                                  setState(() {
                                    isLoading = true;
                                    Utils.checkInternetConnectivity()
                                        .then((value) {
                                      if (value) {
                                        _api.getDriverFromToTotalEarning(<
                                            String, dynamic>{
                                          'Str1': DriverConst.str1,
                                          'Str2': DriverConst.str2,
                                          'Str3': DriverConst.str3,
                                          'FromDate':
                                              selectedFromDate.toString(),
                                          'ToDate': selectedToDate.toString()
                                        }).then((value) {
                                          dataList = value.data;
                                          if (value != null) {
                                            for (int i = 0;
                                                i < value.data.length;
                                                i++) {
                                              totalPenalty = totalPenalty +
                                                  value.data[i].penaltyAmount;

                                              totalEarning = totalEarning +
                                                  value.data[i].billTotalAmount;
                                              print(
                                                  "Total Earning$totalEarning");
                                            }
                                            totalRides = value.data.length;
                                          } else {}
                                          setState(() {
                                            isLoading = false;
                                          });
                                          print("Total Earning$totalEarning");
                                        });
                                      } else {
                                        FlushBar.showSimpleFlushBar(
                                            "Check Connectivity",
                                            context,
                                            Colors.pink,
                                            Colors.white);
                                      }
                                    });
                                  });
                                }
                              },
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                  color: Colors.lightBlue,
                                  fontSize: 21,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            //============== AppBar End Here =====================\\
            // isLoading == true
            //     ? SliverList(
            //         delegate: SliverChildListDelegate([
            //           Container(
            //             child: Center(
            //               child: CircularProgressIndicator(),
            //             ),
            //           )
            //         ]),
            //       )
            //     :
            SliverList(
              delegate: SliverChildListDelegate([showContainer()]),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(
                    top: height * 0.03,
                    left: width * 0.05,
                    right: width * 0.05),
                child: Container(
                  // height: height * 0.05,
                  decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x20000000),
                            blurRadius: 10.0,
                            spreadRadius: 10.0,
                            offset: Offset(0, 3))
                      ]),
                  child: ListTile(
                    title: Text(
                      'All Rides',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.surface),
                    ),
                  ),
                ),
              ),
            ),

            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return listItem(width, height, dataList[index]);
                },
                childCount: dataList.length,
              ),
            )

            // SliverToBoxAdapter(
            //   child: BlocBuilder<DriverfromtodayearningBloc,
            //       DriverfromToDayEarningState>(
            //     builder: (context, state) {
            //       if (state is DriverfromtodayearningInitial) {
            //         return Container(
            //           height: height,
            //           child: Center(
            //             child: CircularProgressIndicator(),
            //           ),
            //         );
            //       } else if (state is DriverFromTodayEarningLoadedState) {
            //         List<DriverTodayEarning> list = state.list.data;
            //         return SliverList(
            //           delegate: SliverChildBuilderDelegate(
            //             (context, index) {
            //               return listItem(width, height, list[index], index);
            //             },
            //             childCount: 9,
            //           ),
            //         );
            //       } else {
            //         return Container();
            //       }
            //     },
            //   ),
            // ),
          ],
        ),
        isLoading == true
            ? Container(
                height: height,
                color: Colors.lightBlue.withOpacity(0.6),
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                ),
              )
            : Container()
      ],
    ));
  }

  showContainer() {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(
            top: height * 0.0, left: width * 0.05, right: width * 0.05),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.02,
            ),

            //==================== Total Rides ===================\\

            Container(
              //  height: height * 0.08,
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
              child: ListTile(
                title: Text(
                  'Total Rides',
                ),
                trailing: CircleAvatar(
                  backgroundColor: Colors.lightBlue,
                  child: Text(
                    '$totalRides',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),

            //==================== End Total Rides ======================\\
            SizedBox(
              height: height * 0.015,
            ),
            //===================== Total Earn Today ======================\\
            Container(
              //  height: height * 0.08,
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
              child: ListTile(
                title: Text(
                  'Total Earning',
                ),
                trailing: Text(
                  'Rs/-${totalEarning.floor()}',
                  style: TextStyle(color: Colors.lightBlue),
                ),
              ),
            ),

            SizedBox(
              height: height * 0.015,
            ),
            //===================== Total Earn Today ======================\\
            Container(
              //  height: height * 0.08,
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
              child: ListTile(
                title: Text(
                  'Total Plenty ',
                ),
                trailing: Text(
                  'Rs/- ${totalPenalty.floor()}',
                  style: TextStyle(color: Colors.lightBlue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  listItem(double width, double height, DriverTodayEarning model) {
    return Padding(
      padding: EdgeInsets.only(
          top: height * 0.03, left: width * 0.05, right: width * 0.05),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return TotalSaleDetail(
                model: model,
              );
            },
          ));
        },
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
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: height * 0.015,
                    left: width * 0.04,
                    right: width * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Text("Ride ID: "),
                          Text(
                            "${model.rideRequestId}",
                            style: TextStyle(color: Colors.lightBlue),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Text("Time: "),
                          Text(
                            "${Utils.getTimeinformat(model.rideStartTime)}",
                            style: TextStyle(color: Colors.lightBlue),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: height * 0.01,
                  left: width * 0.04,
                  right: width * 0.04,
                ),
                child: Container(
                  width: width,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.blue,
                        size: 18,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: width * 0.03),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "${model.ridingClientName}",
                            //  style: TextStyle(color: Colors.green),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                  top: height * 0.01,
                  left: width * 0.04,
                  right: width * 0.04,
                ),
                child: Container(
                  width: width,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.phone_android,
                        color: Colors.blue,
                        size: 18,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: width * 0.03),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "${model.ridingClientPhoneNumber}",
                            //  style: TextStyle(color: Colors.green),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //
              Padding(
                padding: EdgeInsets.only(
                    top: height * 0.01,
                    left: width * 0.04,
                    right: width * 0.04,
                    bottom: height * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Text("Earn: "),
                          Text(
                            "${model.billTotalAmount}",
                            style: TextStyle(color: Colors.lightBlue),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Text("Plenty: "),
                          Text(
                            "Rs/- ${model.penaltyAmount}",
                            style: TextStyle(color: Colors.lightBlue),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.only(
              //       top: height * 0.01,
              //       left: width * 0.04,
              //       right: width * 0.04,
              //       bottom: height * 0.01),
              //   child: Container(
              //     width: width,
              //     alignment: Alignment.centerLeft,
              //     child: Row(
              //       children: [
              //         Text("Drive Status: "),
              //         Text(
              //           "${ridingStatusTitle(model.)}",
              //           style: TextStyle(color: Colors.green),
              //         )
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  ridingStatusTitle(int rideStatusId) {
    //   print("MyId....$_myId");
    if (rideStatusId == 1) {
      return "Pending";
    } else if (rideStatusId == 2) {
      return "Accepted";
    } else if (rideStatusId == 3) {
      return "Rejected";
    } else if (rideStatusId == 4) {
      return "Started";
    } else if (rideStatusId == 5) {
      return "Completed";
    }
  }
}
