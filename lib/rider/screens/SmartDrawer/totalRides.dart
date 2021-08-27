import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_smart_ride_cas/Commons/commons.dart';
import 'package:get_smart_ride_cas/app/theme/colors.dart';
import 'package:get_smart_ride_cas/app/theme/textStyles.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_Riding_List.dart';
import 'package:get_smart_ride_cas/rider/bloc/getRidingRequestForClient/bloc/getridingrquestforclientbloc_bloc.dart';
import 'package:get_smart_ride_cas/rider/home/rider_home_screen.dart';
import 'package:get_smart_ride_cas/rider/screens/SmartDrawer/AcceptRejectRideDetails.dart';
import 'package:intl/intl.dart';

var difference;

class RiderAllRidesListPage extends StatefulWidget {
  @override
  _RiderAllRidesListPageState createState() => _RiderAllRidesListPageState();
}

class _RiderAllRidesListPageState extends State<RiderAllRidesListPage> {
  @override
  void initState() {
    BlocProvider.of<GetridingrquestforclientblocBloc>(context).add(
        GetRidingRequestForClientBlocEvent(
            Commons.riderEmail, Commons.riderPhoneNO, ""));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //var difference;
    List<DriverRidingModel> driverRidingList;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.width;
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        height: constraints.maxHeight,
        width: constraints.maxWidth,
        //   color: AppColors.greyColor.withOpacity(0.5),
        child: FadeInLeft(
          animate: true,
          child: Card(
            color: AppColors.secondMainColor.withOpacity(0.5),
            margin: const EdgeInsets.only(
                left: 70, bottom: 100, top: 100, right: 4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return RiderHomeScreen();
                          }));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 9.0),
                          child: Icon(Icons.arrow_back,
                              color: AppColors.mainColor),
                        )),
                    SizedBox(
                      width: width * 0.08,
                    ),
                    Card(
                      color: AppColors.mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: SizedBox(
                        height: constraints.maxHeight * 0.035,
                        width: constraints.maxWidth * 0.45,
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                'All Rides',
                                style: AppTextStyles.description1
                                    .copyWith(color: AppColors.whiteColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ridesListView(width, height, driverRidingList)
              ],
            ),
          ),
        ),
      ),
    );
  }

  ridesListView(
    double width,
    double height,
    List<DriverRidingModel> driverRidingList,
  ) {
    return Expanded(
      child: BlocBuilder<GetridingrquestforclientblocBloc,
          GetridingrquestforclientblocState>(
        builder: (context, state) {
          if (state is GetridingrquestforclientblocInitial) {
            return Center(child: CircularProgressIndicator());
          } else if (state is GetridingrquestforclientblocLoaded) {
            driverRidingList = state.driverRidingList;

            return Container(
                height: height,
                //  color: Colors.green,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.driverRidingList.length,
                      itemBuilder: (BuildContext context, int index) {
                        driverRidingList = state.driverRidingList;
                        // print(
                        //     "..........time.......${driverRidingList[index].requestTimeDate}");
                        final s =
                            "${driverRidingList[index].requestTimeDate.replaceAll("T", " ")}";
                        // print(s);
                        final formatter = DateFormat("yyyy-MM-dd").add_Hms();
                        //   print("..... formaterr ......${formatter.toString()}");
                        final dateTime = formatter.parse(s);
                        //    print("Date and Time${dateTime}");

                        var now = DateTime.now();
                        //   print(" Current time........${now}");
                        difference = now.difference(dateTime).inSeconds;
                        //   print("......difference.....$difference");
                        // var format = DateFormat("s");
                        // var second = format.parse("$difference").day;
                        // // DateFormat("ss").format(DateTime.parse("$difference"));
                        // print(
                        //     ".......... Time Difference ......${difference.toString()}.......Second ${second}");
                        //   print( ".....${driverRidingList[index].ridingRequestId}..Requested Status...${driverRidingList[index].requestStatus}..MyId...${driverRidingList[index].myId}..${driverRidingList[index].acceptDriverId}");

                        print("...........${state.driverRidingList.length}");
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AcceptOrRejectRideDetails(
                                          timeForPenalty: difference,
                                          ridingModel: driverRidingList[index],
                                        )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: width * 0.7,
                              // height: height * 0.3,
                              decoration: BoxDecoration(
                                //color: Colors.white,
                                color: AppColors.mainColor.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.driverRidingList[index]
                                          .ridingClientName,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                    Text(
                                        ridingStatusTitle(state
                                            .driverRidingList[index]
                                            .requestStatus),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15)),

                                    /*      state.driverRidingList[index].requestStatus==3?   Text(
                                        state.driverRidingList[index].rejectionBy
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15)):null
 state.driverRidingList[index].requestStatus==3?   Text(
                                        state.driverRidingList[index].rejectedTimeDate
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15)):null */
                                  ],
                                ),
                              ),
                              // padding: const EdgeInsets.all(5),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ));
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  ridingStatusTitle(int rideStatusId) {
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
/*class RiderAllRidesListPage extends StatefullWidget {
  List<DriverRidingList> driverRidingList;

 /* @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.width;
    BlocProvider.of<GetridingrquestforclientblocBloc>(context).add(
        GetRidingRequestForClientBlocEvent(
            Commons.riderEmail, Commons.riderPhoneNO, ""));
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        height: constraints.maxHeight,
        width: constraints.maxWidth,
        //   color: AppColors.greyColor.withOpacity(0.5),
        child: FadeInLeft(
          animate: true,
          child: Card(
            color: AppColors.secondMainColor.withOpacity(0.5),
            margin: const EdgeInsets.only(
                left: 70, bottom: 100, top: 100, right: 4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.02,
                ),
                Center(
                  child: Card(
                    color: AppColors.mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: SizedBox(
                      height: constraints.maxHeight * 0.035,
                      width: constraints.maxWidth * 0.45,
                      child: Center(
                        child: Text(
                          'Completed Rides',
                          style: AppTextStyles.description1
                              .copyWith(color: AppColors.whiteColor),
                        ),
                      ),
                    ),
                  ),
                ),
                ridesListView(width, height)
              ],
            ),
          ),
        ),
      ),
    );
  }

  ridesListView(double width, double height) {
    return Expanded(
      child: BlocBuilder<GetridingrquestforclientblocBloc,
          GetridingrquestforclientblocState>(
        builder: (context, state) {
          if (state is GetridingrquestforclientblocInitial) {
            return CircularProgressIndicator();
          } else if (state is GetridingrquestforclientblocLoaded) {
            driverRidingList = state.driverRidingList;
            return Container(
              height: height,
              // color: Colors.green,
              child: ListView.builder(
                itemCount: state.driverRidingList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: width * 0.7,
                          height: height * 0.3,
                          decoration: BoxDecoration(
                            //color: Colors.white,
                            color: AppColors.mainColor.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state
                                      .driverRidingList[index].ridingClientName,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                                Text(
                                    state.driverRidingList[index].requestStatus
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15)),
                              ],
                            ),
                          ),
                          // padding: const EdgeInsets.all(5),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  } */
} */
