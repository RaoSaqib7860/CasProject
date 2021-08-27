// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_smart_ride_cas/api/rider_api/rider_api.dart';
// import 'package:get_smart_ride_cas/chat/screen/chat_screen_ui.dart';
// import 'package:get_smart_ride_cas/rider/bloc/getRidingRequestForClient/bloc/getDriverDataBloc/bloc/getdriverdata_bloc.dart';
// import 'package:get_smart_ride_cas/rider/home/rider_home_screen.dart';
// import 'package:get_smart_ride_cas/rider/objects/getDriverData.dart';
// import 'package:google_fonts/google_fonts.dart';

// int id;

// class DialogDriverDataAfterRideAccept extends StatefulWidget {
//   //final List<GetDriverData> driverDataList;
//   List<GetDriverData> driverDataList;
//   DialogDriverDataAfterRideAccept({Key key, this.driverDataList})
//       : super(key: key);
//   @override
//   _DialogDriverDataAfterRideAcceptState createState() =>
//       _DialogDriverDataAfterRideAcceptState();
// }

// class _DialogDriverDataAfterRideAcceptState
//     extends State<DialogDriverDataAfterRideAccept> {
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;

//     return Dialog(
//       backgroundColor: Colors.white.withOpacity(0.0),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       child: BlocBuilder<GetdriverdataBloc, GetdriverdataState>(
//         builder: (context, state) {
//           if (state is GetdriverdataInitial) {
//             return Container();
//           } else if (state is GetDriverDataLoadedState) {
//             driverDataList = state.driverDataList;
//             id = state.rideRequestID;
//             return Stack(
//               children: [
//                 Container(
//                   width: width * 0.8,
//                   height: height * 0.5, color: Colors.transparent,
//                   // color: Colors.orange,
//                   alignment:
//                       Alignment.bottomCenter, // where to position the child
//                   child: Container(
//                     width: width * 0.8,
//                     height: height * 0.4,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: Colors.white,
//                     ),
//                     child: Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Align(
//                               alignment: Alignment.bottomRight,
//                               child: InkWell(
//                                   onTap: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) => ChatScreen(
//                                                 ridingRequestId: id,
//                                               )),
//                                     );
//                                   },
//                                   child: Icon(Icons.chat, color: Colors.blue))),
//                         ),
//                         Align(
//                             alignment: Alignment.topRight,
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: InkWell(
//                                   onTap: () {
//                                     Navigator.push(context,
//                                         MaterialPageRoute(builder: (context) {
//                                       return RiderHomeScreen(
//                                         getDriverDataList: driverDataList,
//                                       );
//                                     }));
//                                   },
//                                   child: Icon(Icons.cancel_outlined,
//                                       color: Colors.blue)),
//                             )),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             AutoSizeText(
//                               //  "name",
//                               driverDataList[0].name,
//                               maxFontSize: 20,
//                               minFontSize: 10,
//                               maxLines: 1,
//                               style: GoogleFonts.alegreya(),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(top: 8, left: 8),
//                               child: AutoSizeText(
//                                   //"phone no",
//                                   driverDataList[0].phoneNumber,
//                                   maxFontSize: 20,
//                                   minFontSize: 10,
//                                   maxLines: 1,
//                                   style: GoogleFonts.alegreya()),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(top: 8, left: 8),
//                               child: AutoSizeText(
//                                   //"vehicle no",

//                                   driverDataList[0].vehicleNo,
//                                   style: GoogleFonts.alegreya()),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 Positioned(
//                   left: width * 0.25,
//                   child: Container(
//                     alignment: Alignment.topCenter,
//                     decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         //color: Colors.red,
//                         image: DecorationImage(
//                             image: NetworkImage(
//                                 "${RiderApi.baseUrl + driverDataList[0].image}"))),
//                     width: width * 0.25,
//                     height: height * 0.25,

//                     //    child:
//                   ),
//                 ),

// // Container(
// //             decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.red),
// //             width: width * 0.3,
// //             height: height * 0.3,

// //             //    child:
// //           ),
//                 // Container(
//                 //   decoration: BoxDecoration(
//                 //   //    shape: BoxShape.circle,
//                 //       borderRadius: BorderRadius.circular(20),
//                 //       image: DecorationImage(
//                 //           image: NetworkImage(
//                 //               "https://images.pexels.com/photos/556666/pexels-photo-556666.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"))),
//                 //   width: width * 0.2,
//                 //   height: height * 0.2,

//                 //   //    child:
//                 // ),
//               ],
//             );
//           }
//           return CircularProgressIndicator();
//         },
//       ),
//     );
//   }
// }
