import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_smart_ride_cas/api/driver_api/driver_api_services.dart';
import 'package:get_smart_ride_cas/driver/bloc/getdriverridelist_bloc.dart';
import 'package:get_smart_ride_cas/driver/constant/ps_constants.dart';
import 'package:get_smart_ride_cas/driver/home/screens/acceptor_or_reject_drive.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_all_riding_list.dart';
import 'package:get_smart_ride_cas/utils/utils.dart';
import 'package:get_smart_ride_cas/widgets/custom_icon_decoration.dart';
import 'package:intl/intl.dart';

class DriverAllRidingRequestPage extends StatefulWidget {
  final String date;
  final String dayName;
  DriverAllRidingRequestPage({
    this.date,
    this.dayName,
  });

  @override
  _DriverAllRidingRequestPageState createState() =>
      _DriverAllRidingRequestPageState();
}

class _DriverAllRidingRequestPageState
    extends State<DriverAllRidingRequestPage> {
  PageController _pageController = PageController();
  double currentPage = 0;

  bool isSearching = false;
  List countries = [];
  List filteredCountries = [];
  bool isloading = false;

  //===================== Color ====================\\
  Color rejectAppointmentColor = Colors.red;
  Color pendingAppointmentColor = Colors.grey;
  Color acceptedAppoinmentColor = Colors.blue;
  Color completedAppointmentColor = Colors.green;
  Color urgentAppointmentColor = Colors.pink;

  //=================== End Color ====================\\

  ApiServices _apiServices = ApiServices();

  // List<DriverAllRidingRequest> _list = List();
  int _myId;

  @override
  void initState() {
    Utils.checkInternetConnectivity().then((value) async {
      if (value == true) {
        BlocProvider.of<GetdriverridelistBloc>(context).add(
            GetAllDriverRideListEvent(map: <String, dynamic>{
          'Str1': DriverConst.str1,
          'Str2': DriverConst.str2,
          'Str3': DriverConst.str3
        }));
        // PsResource<List<DriverAllRidingRequest>> _resource =
        //     await _apiServices.getDriverAllRidingList(<String, dynamic>{
        //   'Str1': DriverConst.str1.toString(),
        //   'Str2': DriverConst.str2.toString(),
        //   'Str3': DriverConst.str3.toString()
        // });

        // if (_resource != null) {
        //   setState(() {
        //     //  _list = _resource.data;
        //     isloading = false;
        //     // _myId = _list[0].myId;
        //   });
        // }
      } else {}
    });
    // TODO: implement initState
    super.initState();
  }

  var height;
  var width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
          // leading: Icon(
          //   Icons.arrow_back,
          //   color: Colors.white,
          // ),
          backgroundColor: Theme.of(context).accentColor,
          title: Text('Latest Request')),
      body: Stack(
        children: <Widget>[
          // Positioned(
          //   right: 5,
          //   child: Text(
          //     "9",
          //     style: TextStyle(fontSize: 150, color: Color(0x10000000)),
          //   ),
          // ),
          _mainContent(context),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _mainContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // SizedBox(height: 15),
        // Padding(
        //   padding: EdgeInsets.only(top: height * 0.01, left: 20, right: 20),
        //   child: Text(
        //     "Monday",
        //     style: TextStyle(
        //         fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
        //   ),
        // ),
        Expanded(child:
            //
            //================================ Bloc is Implement is Here ================================\\
            //
            BlocBuilder<GetdriverridelistBloc, GetDriverRideListState>(
          builder: (context, state) {
            if (state is GetDiverRideListInitialState) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is GetDriverRideListLoadedState) {
              List<DriverAllRidingRequest> _rideBlocList = state.resource;
              print("---------------Bloc List $_rideBlocList");
              return PageView(
                controller: _pageController,
                children: <Widget>[
                  SingleChildScrollView(
                    //  alignment: Alignment.topCenter,
                    child: ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _rideBlocList.length,
                      padding: const EdgeInsets.all(0),
                      // reverse: true,
                      itemBuilder: (context, index) {
                        //         _rideBlocList.insert(0, _rideBlocList[index]);
                        // final requestDateTime =
                        //     "${_list[index].requestTimeDate.replaceAll("T", " ")}";
                        // print(requestDateTime);
                        // final formatter = DateFormat("yyyy-MM-dd").add_Hms();
                        // final dateTime = formatter.parse(requestDateTime);
                        // //   print("Requested DateTime in String...");

                        // var now = DateTime.now();
                        // var difference = now.difference(dateTime);
                        // var second = difference.inSeconds;
                        // // DateFormat("ss").format(DateTime.parse(""));
                        // print(
                        //     ".......... Time Difference ...${difference.toString()}..second..");
                        // print(
                        //     ".....${_list[index].ridingRequestId}..Requested Status...${_list[index].requestStatus}..MyId...${_list[index].myId}..${_list[index].acceptDriverId}");
                        return Padding(
                          padding: const EdgeInsets.only(left: 24.0, right: 24),
                          child: Row(
                            children: <Widget>[
                              _lineStyle(
                                  context,
                                  20,
                                  index,
                                  _rideBlocList.length,
                                  _rideBlocList[index].requestStatus,
                                  _rideBlocList[index].myId,
                                  _rideBlocList[index].acceptDriverId),
                              _displayTime(Utils.getTimeinformat(
                                  _rideBlocList[index].requestTimeDate)),
                              _displayContent(_rideBlocList,
                                  _rideBlocList[index], index, context)
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            } else {
              return null;
            }
          },
        ))
      ],
    );
  }

  //////////////////////////////   Method Make for List Item   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
  ///
  ///
  ///

  Widget _displayContent(List<DriverAllRidingRequest> list,
      DriverAllRidingRequest model, int index, BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DriverAcceptOrRejectDrive(
                    model: model,
                    rideList: list,
                    riderequestID: model.ridingRequestId,
                  ),
                ));
          },
          child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.all(Radius.circular(12)),
                boxShadow: [
                  BoxShadow(
                      color: Color(0x20000000),
                      blurRadius: 5,
                      offset: Offset(0, 3))
                ]),
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //================================== Appointment status Color Container ================================\\
                    Container(
                      height: height * 0.005,
                      width: width * 0.07,
                      decoration: BoxDecoration(
                        color: ridingStatusColor(model.myId,
                            model.requestStatus, model.acceptDriverId),
                        borderRadius: BorderRadius.circular(15.0),
                        //  border: Border.all(color: Color(0xff4ADEDE), width: 2),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                            color: Color.fromRGBO(196, 196, 196, 1),
                          )
                        ],
                      ),
                    ),
                    //================================== End Appointment status Color Container ================================\\
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: AutoSizeText(
                            "${ridingStatusTitle(model.myId, model.requestStatus, model.acceptDriverId)}",
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 12,
                              color: ridingStatusColor(model.myId,
                                  model.requestStatus, model.acceptDriverId),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          child: AutoSizeText(
                            "${Utils.getDateFormat(model.requestTimeDate)}",
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    //================================= Row For Patient Name , AppointmentID , Call Button ==========================\\
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            //  color: Colors.blue,
                            // width: MediaQuery.of(context).size.width / 2.2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ////        patient Name      \\\\\\\

                                Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.person,
                                        size: 20,
                                        color: Colors.blue,
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: width * 0.02),
                                        child: AutoSizeText(
                                            "${model.ridingClientName}"),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(
                                  height: height * 0.01,
                                ),

                                Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.phone_android_rounded,
                                        size: 20,
                                        color: Colors.blue,
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: width * 0.02),
                                        child: AutoSizeText(
                                            "${model.ridingClientPhoneNumber}"),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Container(
                        //   //      color: Colors.blue,
                        //   child: Icon(
                        //     Icons.arrow_forward_ios,
                        //     size: 20,
                        //     color: Colors.grey,
                        //   ),
                        // )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _displayTime(String time) {
    return Container(
        width: 80,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "$time",
            //   style: TextStyle(),
          ),
        ));
  }

  Widget _lineStyle(BuildContext context, double iconSize, int index,
      int listLength, int status, int myId, acceptDriverId) {
    return Container(
      decoration: CustomIconDecoration(
          iconSize: iconSize,
          lineWidth: 1,
          firstData: index == 0 ?? true,
          lastData: index == listLength - 1 ?? true),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 3),
                    color: Color(0x20000000),
                    blurRadius: 5)
              ]),
          child: status == 1
              ? Icon(Icons.radio_button_unchecked,
                  size: iconSize, color: Colors.blue)
              : Icon(
                  Icons.fiber_manual_record,
                  size: iconSize,
                  color: ridingStatusColor(myId, status, acceptDriverId),
                )),
    );
  }

  Color ridingStatusColor(int myId, int rideStatusId, int acceptedDriverID) {
    if (rideStatusId == 1) {
      return Colors.grey;
    } else if (rideStatusId == 2) {
      if (myId == acceptedDriverID) {
        return Colors.blue;
      } else {
        return Colors.blue;
      }
    } else if (rideStatusId == 3) {
      return Colors.red;
    } else if (rideStatusId == 4) {
      return Colors.orange;
    } else if (rideStatusId == 5) {
      return Colors.green;
    } else {
      return Colors.blue;
    }
  }

  ridingStatusTitle(int myId, int rideStatusId, int acceptedDriverID) {
    //   print("MyId....$_myId");
    if (rideStatusId == 1) {
      return "Pending";
    } else if (rideStatusId == 2) {
      if (myId == acceptedDriverID) {
        return "Accepted";
      } else {
        return "Accepted by other";
      }
    } else if (rideStatusId == 3) {
      return "Rejected";
    } else if (rideStatusId == 4) {
      return "Started";
    } else if (rideStatusId == 5) {
      return "Completed";
    }
  }
}

/*
Container(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x20000000),
                        blurRadius: 5,
                        offset: Offset(0, 3))
                  ]),)
*/
