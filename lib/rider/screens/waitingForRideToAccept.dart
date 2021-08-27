import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_smart_ride_cas/api/rider_api/rider_api.dart';
import 'package:get_smart_ride_cas/app/theme/colors.dart';
import 'package:get_smart_ride_cas/chat/screen/chat_screen_ui.dart';
import 'package:get_smart_ride_cas/rider/bloc/getRidingRequestForClient/bloc/getDriverDataBloc/bloc/getdriverdata_bloc.dart';
import 'package:get_smart_ride_cas/rider/home/rider_home_screen.dart';
import 'package:get_smart_ride_cas/widgets/flush_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart ' as http;
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

int id;

class WaitingForRideToAcept extends StatefulWidget {
  const WaitingForRideToAcept({Key key}) : super(key: key);

  @override
  _WaitingForRideToAceptState createState() => _WaitingForRideToAceptState();
}

class _WaitingForRideToAceptState extends State<WaitingForRideToAcept> {
  AnimationController controller;
  Animation<Offset> offset;
  //List<GetDriverData> driverDataList;
//  List<DriverRidingRequestById> driverRidingRequestById;
  // @override
  // void initState() {
  //   // TODO: implement initState]
  //   if (ridingRequestId != null) {
  //     loadList(ridingRequestId);
  //     print("...............waitingForRideToAceeptId....$ridingRequestId");
  //   }

  //   super.initState();
  // }

  // Future<List<DriverRidingRequestById>> getListByRidingRequestId(
  //     int ridingRequestId) async {
  //   print(" Method is call  ");
  //   final http.Response response = await http.post(
  //       DriverApi.driverLatestBookingRequestById,
  //       body: jsonEncode(
  //           <String, String>{"RidingRequestId": ridingRequestId.toString()}),
  //       headers: <String, String>{
  //         "Content-type": "application/json; charset=utf-8"
  //       });

  //   /// {"RidingRequestId": ridingRequestId.toString()}

  //   print(" Response status code  ${response.statusCode}");
  //   if (response.statusCode == 200) {
  //     var output = jsonDecode(response.body);
  //     print(output.toString());
  //     print("success");
  //     return DriverRidingRequestById.fromMapList(output);
  //   } else {
  //     print("................${response.statusCode}");
  //     throw Exception('Failed to create .');
  //   }
  // }

  // void loadList(int ridingRequestId) async {
  //   print("in loaddddddddddddddd");
  //   driverRidingRequestById = await getListByRidingRequestId(ridingRequestId);
  //   print(driverRidingRequestById.length);

  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: height * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BlocBuilder<GetdriverdataBloc, GetdriverdataState>(
                    builder: (context, state) {
                  if (state is GetdriverdataInitial) {
                    return Container();
                  } else if (state is GetDriverDataLoadedState) {
                    driverDataList = state.driverDataList;
                    id = state.rideRequestID;
                  }
                  return driverDataList != null
                      ? Container(
                          //    color: Colors.red,
                          width: width,
                          // width: width * 0.9, height: height * 0.13
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              // shape: RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.circular(10)),
                              elevation: 5,
                              color: Colors.white,
                              child: Stack(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          // alignment: Alignment.centerLeft,
                                          width: width * 0.2,
                                          height: height * 0.1,
                                          margin: EdgeInsets.only(
                                              left: width * 0.03),
                                          decoration: BoxDecoration(
                                              //   color: Colors.red,
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      //"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvVh6uDMeL99aaZfFM91AV-1BtRnNASQAfMg&usqp=CAU",

                                                      "${RiderApi.baseUrl + driverDataList[0].image}"),
                                                  fit: BoxFit.fill))),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          AutoSizeText(
                                            //  "name",
                                            driverDataList[0].name,
                                            maxFontSize: 20,
                                            minFontSize: 10,
                                            maxLines: 1,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8, left: 8),
                                            child: AutoSizeText(
                                              //"phone no",
                                              driverDataList[0].phoneNumber,
                                              maxFontSize: 20,
                                              minFontSize: 10,
                                              maxLines: 1,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8, left: 8),
                                            child: AutoSizeText(
                                              //"vehicle no",
                                              driverDataList[0].vehicleNo,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8, left: 8),
                                            child: AutoSizeText(
                                              //"vehicle no",
                                              driverDataList[0].brand +
                                                  "-" +
                                                  driverDataList[0].color,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(height: 14),
                                            InkWell(
                                                onTap: () async {
                                                  _callNumber(driverDataList[0]
                                                      .phoneNumber
                                                      .toString());
                                                },
                                                child: Icon(Icons.phone)),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ChatScreen(
                                                              ridingRequestId:
                                                                  id,
                                                            )),
                                                  );
                                                },
                                                child: Icon(Icons.chat)),
                                          ],
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ))
                      : Container();
                }),
                Padding(
                    padding:
                        EdgeInsets.only(left: width * 0.02, top: height * 0.01),
                    child: rideAccepted == true
                        ? AnimatedTextKit(
                            repeatForever: true,
                            animatedTexts: [
                              TypewriterAnimatedText('Driver is on way',
                                  curve: Curves.easeInOut,
                                  speed: Duration(milliseconds: 100),
                                  textStyle: TextStyle(
                                      color: AppColors.mainColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              // TypewriterAnimatedText('Design first, then code'),
                              // TypewriterAnimatedText('Do not patch bugs out, rewrite them'),
                              // TypewriterAnimatedText('Do not test bugs out, design them out'),
                            ],
                            onTap: () {
                              print("Tap Event");
                            },
                          )
                        // : rideCompleted == true
                        //     ? AnimatedTextKit(
                        //         repeatForever: true,
                        //         animatedTexts: [
                        //           TypewriterAnimatedText(
                        //               'Driver completed the ride',
                        //               curve: Curves.easeInOut,
                        //               speed: Duration(milliseconds: 100),
                        //               textStyle: TextStyle(
                        //                   color: AppColors.mainColor,
                        //                   fontSize: 20,
                        //                   fontWeight: FontWeight.bold)),
                        //           // TypewriterAnimatedText('Design first, then code'),
                        //           // TypewriterAnimatedText('Do not patch bugs out, rewrite them'),
                        //           // TypewriterAnimatedText('Do not test bugs out, design them out'),
                        //         ],
                        //         onTap: () {
                        //           print("Tap Event");
                        //         },
                        //       )
                        // AutoSizeText(
                        //     "Driver is on way",
                        //     minFontSize: 10,
                        //     maxFontSize: 20,
                        //     style: GoogleFonts.andika(fontSize: 20),
                        //   )
                        : AnimatedTextKit(
                            repeatForever: true,
                            animatedTexts: [
                              TypewriterAnimatedText('Finding your driver',
                                  curve: Curves.easeInOut,
                                  speed: Duration(milliseconds: 100),
                                  textStyle: TextStyle(
                                      color: AppColors.mainColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ],
                            onTap: () {
                              print("Tap Event");
                            },
                          )),
                SizedBox(
                  height: height * 0.02,
                ),
                rideAccepted == true ? Container() : LinearProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        //  borderRadius: BorderRadius.all(Radius.circular(12)),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.mainColor.withOpacity(0.2),
                              blurRadius: 10.0,
                              spreadRadius: 10.0,
                              offset: Offset(0, 3))
                        ]),

                    // height: height * 0.2,
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
                            // color: Colors.orange,
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

                                    color: Colors.red,
                                  ),
                                ),
                                Icon(
                                  Icons.fiber_manual_record,
                                  size: 20,
                                  color: Colors.blue,
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
                                  child: FittedBox(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "From:",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        driverRidingRequestById != null
                                            ? Container(
                                                width: width * 0.73,
                                                child: AutoSizeText(
                                                  "${driverRidingRequestById[0].fromAddress}",
                                                  // "${model.fromAddress}",
                                                  maxLines: 2,
                                                  maxFontSize: 12,
                                                  minFontSize: 8,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12),
                                                )
                                                //driverAllRidingRequest

                                                )
                                            : Container()
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: height * 0.04),
                                  child: FittedBox(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "To:",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 7.0),
                                            child: driverRidingRequestById !=
                                                    null
                                                ? Container(
                                                    //  color: Colors.red,
                                                    width: width * 0.73,
                                                    child: AutoSizeText(
                                                      "${driverRidingRequestById[0].toAddress}",
                                                      //  "${model.toAddress}",
                                                      maxLines: 2,
                                                      maxFontSize: 12,
                                                      minFontSize: 8,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12),
                                                    ))
                                                : Container())
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // RideToFromScreen.vehicleList != null && flushbarIndex != null
                //     ? Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: AutoSizeText(
                //           "Riding Details",
                //           minFontSize: 10,
                //           maxFontSize: 15,
                //           style: GoogleFonts.andika(fontSize: 15),
                //         ),
                //       )
                //     : Container(),
                // RideToFromScreen.vehicleList != null && flushbarIndex != null
                //     ? Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Container(
                //             decoration: BoxDecoration(
                //                 color: Theme.of(context).colorScheme.surface,
                //                 //  borderRadius: BorderRadius.all(Radius.circular(12)),
                //                 boxShadow: [
                //                   BoxShadow(
                //                       color: Color(0x20000000),
                //                       blurRadius: 10.0,
                //                       spreadRadius: 10.0,
                //                       offset: Offset(0, 3))
                //                 ]),
                //             child: Stack(
                //               alignment: Alignment.center,
                //               children: [
                //                 Container(
                //                     // width: width * 0.85,
                //                     height: height * 0.14,
                //                     decoration: BoxDecoration(
                //                       // border: Border.all(
                //                       //     color: Color(0xff4ADEDE),
                //                       //     width: 1),
                //                       borderRadius:
                //                           BorderRadius.all(Radius.circular(12)),
                //                       // boxShadow: [
                //                       //   BoxShadow(
                //                       //       color: Color(0x20000000),
                //                       //       blurRadius: 3.0,
                //                       //       spreadRadius: 3.0,
                //                       //       offset: Offset(0, 3))
                //                       // ]
                //                     ),
                //                     child: Row(
                //                       mainAxisAlignment:
                //                           MainAxisAlignment.spaceEvenly,
                //                       children: [
                //                         SizedBox(
                //                           width: width * 0.34,
                //                           height: height * 0.1,
                //                           child: Image.network(
                //                             "${RiderApi.baseUrl}${RideToFromScreen.vehicleList[flushbarIndex].vTypeImage}",
                //                             fit: BoxFit.fill,
                //                           ),
                //                         ),
                //                         AutoSizeText(
                //                             "${RideToFromScreen.vehicleList[flushbarIndex].vTypeName}",
                //                             minFontSize: 8,
                //                             maxFontSize: 16,
                //                             maxLines: 2,
                //                             style: GoogleFonts.abel(
                //                               fontSize: 16,
                //                             ))
                //                       ],
                //                     )),
                //               ],
                //             )),
                //       )
                //     : Text("NO DETAILSSS"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _callNumber(String phoneNumber) async {
    String number = phoneNumber;
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  Future<bool> _willPopCallback() async {
    FlushBar.showSimpleFlushBar("can't move back while registering driver",
        context, Colors.pink, Colors.white);
    return true;
  }
}
