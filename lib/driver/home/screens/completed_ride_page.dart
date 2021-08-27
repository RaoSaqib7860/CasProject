import 'package:clip_shadow/clip_shadow.dart';
import 'package:flutter/material.dart';
import 'package:get_smart_ride_cas/driver/cliper.dart/bottom_rounded_cliper.dart';
import 'package:get_smart_ride_cas/driver/home/screens/reject_ride_detail.dart';

class DriverCompletedRidesPage extends StatefulWidget {
  @override
  _DriverCompletedRidesPageState createState() =>
      _DriverCompletedRidesPageState();
}

class _DriverCompletedRidesPageState extends State<DriverCompletedRidesPage> {
  var height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: Column(
          children: [
            //=============== Upper Image ==============\\

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
                child: Stack(
                  children: [
                    Container(
                      width: width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("images/background13.jpg"),
                              fit: BoxFit.cover)),
                    ),
                    Container(
                      width: width,
                      color: Colors.blue.withOpacity(0.6),
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
                                  "Rejected",
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
                                  "Driver Rides",
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
                  ],
                ),
              ),
            ),

            //==================== Total Rides ===================\\

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
                          offset: Offset(0, 3))
                    ]),
                child: ListTile(
                  title: Text(
                    'Total Rides',
                  ),
                  trailing: CircleAvatar(
                    backgroundColor: Colors.lightBlue,
                    child: Text(
                      '4',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),

            //==================== End Total Rides ======================\\

            //==================== List Show Here  ======================\\
            Expanded(
              child: Container(
                height: height,
                width: width,
                child: ListView.builder(
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return DriverRejectRideDetailPage();
                          },
                        ));
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.01,
                            bottom: 5.0,
                            left: width * 0.05,
                            right: width * 0.05),
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
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: height * 0.015,
                                      left: width * 0.04,
                                      right: width * 0.04),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Text("Ride ID: "),
                                            Text(
                                              "23",
                                              style: TextStyle(
                                                  color: Colors.lightBlue),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Text("Time: "),
                                            Text(
                                              "4:45 AM",
                                              style: TextStyle(
                                                  color: Colors.lightBlue),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                //
                                //============================= Image Container and Content Use Here =======================\\\
                                //

                                Padding(
                                  padding: EdgeInsets.only(
                                      top: height * 0.016,
                                      left: width * 0.04,
                                      right: width * 0.08,
                                      bottom: height * 0.016),
                                  child: Container(
                                    height: height * 0.1,
                                    width: width,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15.0),
                                      //  border: Border.all(color: Colors.blue, width: 2),
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //     offset: Offset(0.0, 0.0),
                                      //     blurRadius: 5.0,
                                      //     spreadRadius: 3.0,
                                      //     color: Color.fromRGBO(196, 196, 196, 1),
                                      //   )
                                      // ],
                                    ),
                                    //  color: Colors.blue,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        //================================ Image Container Use Here ========================\\\
                                        Container(
                                          width: width * 0.18,
                                          height: height * 0.1,
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.blue.withOpacity(0.7),
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              border: Border.all(
                                                  color: Colors.blue, width: 2),
                                              boxShadow: [
                                                BoxShadow(
                                                  offset: Offset(2, 2),
                                                  blurRadius: 10.0,
                                                  spreadRadius: 2.0,
                                                  color: Color.fromRGBO(
                                                      196, 196, 196, 1),
                                                )
                                              ],
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: AssetImage(
                                                      "images/rider.png"))),
                                        ),
                                        Expanded(
                                          child: Container(
                                            // color: Colors.red,
                                            height: height * 0.1,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: width * 0.03),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: height * 0.005),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.person,
                                                          size: 20,
                                                          color:
                                                              Colors.lightBlue,
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: width *
                                                                        0.02),
                                                            width: width,
                                                            child: Text(
                                                              "Mufazal Ahmad",
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style:
                                                                  TextStyle(),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: height * 0.005),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.phone_android,
                                                          size: 20,
                                                          color:
                                                              Colors.lightBlue,
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: width *
                                                                        0.02),
                                                            width: width,
                                                            child: Text(
                                                              "03006818913",
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style:
                                                                  TextStyle(),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: height * 0.005),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .calendar_today_rounded,
                                                          size: 20,
                                                          color:
                                                              Colors.lightBlue,
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: width *
                                                                        0.02),
                                                            width: width,
                                                            child: Text(
                                                              "12 / 12 / 2021",
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style:
                                                                  TextStyle(),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    );
                  },
                ),
              ),
            )

            //
            //============================= Image Container End Here ==============================\\
            //
          ],
        ),
      ),
    );
  }
}
