import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:clip_shadow/clip_shadow.dart';
import 'package:flutter/material.dart';
import 'package:get_smart_ride_cas/driver/cliper.dart/bottom_rounded_cliper.dart';

class DriverCompletedRideDetailPage extends StatefulWidget {
  @override
  _DriverCompletedRideDetailPageState createState() =>
      _DriverCompletedRideDetailPageState();
}

class _DriverCompletedRideDetailPageState
    extends State<DriverCompletedRideDetailPage> {
  var height, width;

  TextStyle _textStyleHeading = TextStyle(color: Colors.grey, fontSize: 18);
  TextStyle _textStyleText = TextStyle(fontSize: 18);

  // List<String>

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        //   color: Colors.blue,
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
                              "Ride",
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
                              "Detail",
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

            Padding(
              padding: EdgeInsets.only(
                  top: height * 0.06, left: width * 0.05, right: width * 0.05),
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
                                      "Fraid Gate Bahawalpur near BVH Punjab, Pakistan",
                                      maxLines: 2,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "To:",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Container(
                                      width: width * 0.73,
                                      child: AutoSizeText(
                                        "Fraid Gate Bahawalpur near BVH Punjab, Pakistan",
                                        maxLines: 2,
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
              padding: EdgeInsets.only(top: height * 0.02),
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
                            'Mufazal Ahmad',
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
                            '03029831065',
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
                            '6:40 AM',
                          ),
                          leading: Icon(
                            Icons.timer,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      ////
                      ///
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
                            '12-2-2021',
                          ),
                          leading: Icon(
                            Icons.calendar_today_sharp,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
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
