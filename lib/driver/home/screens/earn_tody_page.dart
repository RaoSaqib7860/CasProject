import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get_smart_ride_cas/utils/utils.dart';

import 'package:get_smart_ride_cas/api/common/ps_resource.dart';
import 'package:get_smart_ride_cas/api/driver_api/driver_api_services.dart';
import 'package:get_smart_ride_cas/driver/constant/ps_constants.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_today_earnings.dart';
import 'package:get_smart_ride_cas/driver/home/screens/driver_FromToDay_Earning_detail.dart';

class DriverEarnTodayPage extends StatefulWidget {
  @override
  _DriverEarnTodayPageState createState() => _DriverEarnTodayPageState();
}

class _DriverEarnTodayPageState extends State<DriverEarnTodayPage> {
  var height, width;

  ApiServices _apiServices = ApiServices();

  int totalRides = 0;
  double earnToday = 0;
  double totalPenalty = 0;

  List<DriverTodayEarning> rideList = List();
  Future<PsResource<List<DriverTodayEarning>>> geEarnToday() async {
    PsResource<List<DriverTodayEarning>> _resource =
        await _apiServices.getDriverTodayEarning(<String, dynamic>{
      'Str1': DriverConst.str1,
      'Str2': DriverConst.str2,
      'Str3': DriverConst.str3,
    });

    return _resource;
  }

  bool isLoading = false;

  @override
  void initState() {
    isLoading = true;
    Utils.checkInternetConnectivity().then((value) {
      if (true) {
        geEarnToday().then((value) {
          if (value != null) {
            rideList = value.data;
            setState(() {
              isLoading = false;
              for (int i = 0; i < value.data.length; i++) {
                totalPenalty = totalPenalty + value.data[i].penaltyAmount;

                earnToday = earnToday + value.data[i].billTotalAmount;
              }
              totalRides = value.data.length;
            });
          }
        });
      }
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Today Earning"),
        titleSpacing: 0,
      ),
      body: isLoading == true
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              height: height,
              width: width,
              // color: Colors.blue,
              // decoration: BoxDecoration(
              //     image:
              //         DecorationImage(image: AssetImage("images/background12.jpg"))),
              child: Column(
                children: [
                  ///
                  ///======================= Today Earning =====================\\\
                  ///
                  Container(
                    height: height * 0.38,
                    color: Colors.blue,
                    // decoration: BoxDecoration(
                    //     color: Theme.of(context).colorScheme.surface,
                    //     borderRadius: BorderRadius.all(Radius.circular(12)),
                    //     boxShadow: [
                    //       BoxShadow(
                    //           color: Color(0x20000000),
                    //           blurRadius: 10.0,
                    //           spreadRadius: 10.0,
                    //           offset: Offset(0, 3))
                    //     ]),
                    // color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: height * 0.02,
                          left: width * 0.05,
                          right: width * 0.05),
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
                                'Earn Today',
                              ),
                              trailing: Text(
                                'Rs/- $earnToday',
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
                                'Today Plenty ',
                              ),
                              trailing: Text(
                                'Rs/- $totalPenalty',
                                style: TextStyle(color: Colors.lightBlue),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: height * 0.02,
                          )
                        ],
                      ),
                    ),
                  ),

                  // =======================  Rides List ======================= \\

                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          //  color: Colors.blue.withOpacity(0.7),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      height: height,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: rideList.length == null || rideList.length == 0
                            ? Container(
                                child: Center(
                                  child: Text("Today is no earning"),
                                ),
                              )
                            : ListView.builder(
                                itemCount: rideList.length,
                                itemBuilder: (context, index) {
                                  //===================== List Item =====================\\
                                  //

                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return TotalSaleDetail(
                                              model: rideList[index],
                                            );
                                          },
                                        ));
                                      },
                                      child: Container(
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
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: height * 0.02,
                                                  left: width * 0.04,
                                                  right: width * 0.04),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Text("Ride ID: "),
                                                        Text(
                                                          "${rideList[index].rideRequestId}",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .lightBlue),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Text("Time: "),
                                                        Text(
                                                          "${Utils.getTimeinformat(rideList[index].rideStartTime)}",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .lightBlue),
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
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.person,
                                                      color: Colors.blue,
                                                      size: 18,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: width * 0.03),
                                                      child: Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "${rideList[index].ridingClientName}",
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
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.phone_android,
                                                      color: Colors.blue,
                                                      size: 18,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: width * 0.03),
                                                      child: Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "${rideList[index].ridingClientPhoneNumber}",
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Text("Earn: "),
                                                        Text(
                                                          "Rs/- ${rideList[index].currentRideAmount}",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .lightBlue),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Text("Plenty: "),
                                                        Text(
                                                          "Rs/- ${rideList[index].penaltyAmount}",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .lightBlue),
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
                                            //           "${rideList[index].status}",
                                            //           style: TextStyle(
                                            //               color: Colors.green),
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
                                },
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
