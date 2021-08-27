import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_smart_ride_cas/Commons/commons.dart';
import 'package:get_smart_ride_cas/api/common/ps_resource.dart';
import 'package:get_smart_ride_cas/api/rider_api/rider_api.dart';
import 'package:get_smart_ride_cas/api/rider_api/rider_api_services.dart';
import 'package:get_smart_ride_cas/api/rider_api/waiting_controller.dart';
import 'package:get_smart_ride_cas/app/theme/colors.dart';
import 'package:get_smart_ride_cas/app/theme/textStyles.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_vehicle_type_res.dart';
import 'package:get_smart_ride_cas/rider/bloc/getRidingRequestForClient/bloc/getDistanceCostVehicleWise/bloc/getdistancecostvehiclewise_bloc.dart';
import 'package:get_smart_ride_cas/rider/home/rider_home_screen.dart';
import 'package:get_smart_ride_cas/rider/objects/ApiResponse.dart';
import 'package:get_smart_ride_cas/rider/objects/GetDistanceCostVechicleVise.dart';
import 'package:get_smart_ride_cas/rider/screens/pageone.dart';
import 'package:get_smart_ride_cas/rider/screens/pagetwo.dart';
import 'package:get_smart_ride_cas/utils/utils.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get_smart_ride_cas/widgets/flush_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:uuid/uuid.dart';

import 'driverDataDialog.dart';
import 'waitingForRideToAccept.dart';

int flushbarIndex;
TextEditingController pickTextController = TextEditingController();

TextEditingController destinationTextController = TextEditingController();

class RideToFromScreen extends StatefulWidget {
  //static PageController controller = PageController();

  static List<DriverVehicleTypeResponse> vehicleList = List();

  @override
  _RideToFromScreenState createState() => _RideToFromScreenState();
}

Future<bool> checkConnectivity() async {
  bool isConnected = await Utils.checkInternetConnectivity();
  return isConnected;
}

animateToNextPage({int page = 1}) {
  controller.animateToPage(page,
      duration: Duration(seconds: 1), curve: Curves.easeIn);
}

Function funForRideconfirmBackTofalse;

PageController controller;

class _RideToFromScreenState extends State<RideToFromScreen> {
  bool isLoading = false;
  RiderApiServices _apiServices = RiderApiServices();
  int selectedVehicleID;
  int cityID;
  LatLng destinationlatlng;
  LatLng pickLatlng;
  bool isLocationSelected = false;
  String pickingAddress, destinationAddress;
  Position initialPosition;
  bool serviceAvailable = true;

  List<DistanceCostVehicleVise> _distanceCostVehicleViseList;
  List<DistanceCostVehicleVise> resourceList;
  bool show;
  // Text Controller \\

  getVehicleList() async {
    Utils.checkInternetConnectivity().then((value) {
      return Utils.getCityName().then((value) {
        print("${value.toString()}");

        return _apiServices.driverVehicleType(
            <String, dynamic>{"City": "$value"}).then((value) {
          setState(() {
            isLoading = false;
            RideToFromScreen.vehicleList = value.data;

            // selectedVehicleID = vehicleList[0].vehicleTypeId;
          });
        });
      });
    });
  }

  Future getCityIdByCityName() async {
    Utils.checkInternetConnectivity().then((value) {
      return Utils.getCityName().then((value) async {
        print("${value.toString()}");

        PsResource<ApiResponse> _resource =
            await _apiServices.getCityID(<String, dynamic>{"City": "$value"});

        if (_resource.data.status == "City Found") {
          print("City ID.......${_resource.data.id}");
          serviceAvailable = true;
          cityID = _resource.data.id;
        } else if (_resource.data.status == "City Cannot be Empty") {
          FlushBar.showSimpleFlushBar(
              "City Cannot be Empty", context, Colors.pink, Colors.white);
        } else if (_resource.data.status ==
            "Service Not Availble in your City") {
          FlushBar.showSimpleFlushBar("Service Not Availble in your City",
              context, Colors.pink, Colors.white);
          serviceAvailable = false;
        } else if (_resource.data.id == -1) {
          FlushBar.showSimpleFlushBar(
              "No city found for services", context, Colors.pink, Colors.white);
          return null;
        }
      });
    });
  }

  getCityID() async {
    return await getCityIdByCityName();
  }

  @override
  void initState() {
    try {
      print(".abc.......try block....init of ride to from");
      funForRideconfirmBackTofalse = () {
        setState(() {
          rideConfirm = false;
        });
      };
    } catch (e) {
      print(".abc.......catch block....init of ride to from");
    }

    controller = PageController();
    isLoading = true;

    Utils.determinePosition().then((value) {
      setState(() {
        initialPosition = value;
      });
    });
    getCityIdByCityName();
    getVehicleList();

    super.initState();
  }

  @override
  void dispose() {
    rideConfirm = false;
    // pickTextController.clear();
    //  destinationTextController.clear();
    super.dispose();
  }

  var height, width;

  @override
  Widget build(BuildContext context) {
    print("---------City ID.......$cityID");
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return GetBuilder<WaitingController>(builder: (obj) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        appBar: AppBar(
          title: Text('New ride'),
          backgroundColor: AppColors.mainColor,
          centerTitle: true,
        ),
        body: isLoading == true
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.orange,
                ),
              )
            : Container(
                child: LayoutBuilder(
                  builder: (context, constraints) => Container(
                    height: constraints.maxHeight,
                    width: constraints.maxWidth,
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: height * 0.03,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.mainColor.withOpacity(0.2),
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 15, right: 15, top: 5),
                                  child: TextFormField(
                                    controller: pickTextController,
                                    cursorColor: Theme.of(context).cursorColor,
                                    style: AppTextStyles.heading3
                                        .copyWith(fontSize: 16),
                                    decoration: InputDecoration(
                                      hintText: 'choose pick-up',
                                      icon: Icon(Icons.stop_circle_outlined,
                                          color: AppColors.mainColor),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            RaisedButton(
                              color: Colors.white,
                              onPressed: () {
                                show = true;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return PlacePicker(
                                        apiKey:
                                            "AIzaSyBXvYVU0pNpxXNc57vUu6NlkiVcLElrVGE",
                                        initialPosition: LatLng(
                                            initialPosition.latitude,
                                            initialPosition.longitude),
                                        useCurrentLocation: true,
                                        selectInitialPosition: true,

                                        //usePlaceDetailSearch: true,
                                        onPlacePicked: (result) {
                                          setState(() {
                                            print(
                                                "--------- Pick Location ------------ ${result.addressComponents.toString()}");
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        forceSearchOnZoomChanged: true,
                                        automaticallyImplyAppBarLeading: false,
                                        //  autocompleteLanguage: "ko",
                                        region: 'au',
                                        //  selectInitialPosition: true,
                                        selectedPlaceWidgetBuilder: (_,
                                            selectedPlace,
                                            state,
                                            isSearchBarFocused) {
                                          return isSearchBarFocused
                                              ? Container()
                                              : FloatingCard(
                                                  bottomPosition:
                                                      20, // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
                                                  leftPosition: 60,
                                                  rightPosition: 60,

                                                  //  width: 500,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                  child: state ==
                                                          SearchingState
                                                              .Searching
                                                      ? Center(
                                                          child:
                                                              CircularProgressIndicator())
                                                      : Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 30,
                                                                  right: 30),
                                                          child: Container(
                                                            child: RaisedButton(
                                                              color:
                                                                  Colors.blue,
                                                              child: Text(
                                                                "Done",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              onPressed: () {
                                                                // IMPORTANT: You MUST manage selectedPlace data yourself as using this build will not invoke onPlacePicker as
                                                                //            this will override default 'Select here' Button.

                                                                pickLatlng = LatLng(
                                                                    selectedPlace
                                                                        .geometry
                                                                        .location
                                                                        .lat,
                                                                    selectedPlace
                                                                        .geometry
                                                                        .location
                                                                        .lng);
                                                                pickingAddress =
                                                                    selectedPlace
                                                                        .formattedAddress;

                                                                pickTextController
                                                                        .text =
                                                                    selectedPlace
                                                                        .formattedAddress;
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                );
                                        },
                                        pinBuilder: (context, state) {
                                          if (state == PinState.Idle) {
                                            return Container(
                                              width: width * 0.1,
                                              height: height * 0.1,
                                              child: Image.asset(
                                                "images/gsrMapIcon.png",
                                              ),
                                            );
                                          } else {
                                            return Container(
                                              width: width * 0.1,
                                              height: height * 0.1,
                                              child: Image.asset(
                                                "images/gsrMapIcon.png",
                                              ),
                                            );
                                          }
                                        },
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Text("select from map"),
                            ),
                            SizedBox(height: height * 0.02),
                            //
                            //================================= destination Address ============================\\
                            //
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.mainColor.withOpacity(0.2),
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 15, right: 15, top: 5),
                                  child: TextFormField(
                                    controller: destinationTextController,
                                    cursorColor: Theme.of(context).cursorColor,
                                    style: AppTextStyles.heading3
                                        .copyWith(fontSize: 16),
                                    decoration: InputDecoration(
                                      hintText: 'Where to?',
                                      icon: Icon(Icons.location_on_outlined,
                                          color: Colors.red),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            RaisedButton(
                              color: Colors.white,
                              onPressed: () {
                                show = true;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return PlacePicker(
                                        apiKey:
                                            "AIzaSyBXvYVU0pNpxXNc57vUu6NlkiVcLElrVGE",
                                        initialPosition: LatLng(
                                            initialPosition.latitude,
                                            initialPosition.longitude),
                                        useCurrentLocation: true,
                                        selectInitialPosition: true,

                                        //usePlaceDetailSearch: true,
                                        onPlacePicked: (result) {
                                          setState(() {
                                            print(
                                                "--------- Pick Location ------------ ${result.addressComponents.toString()}");
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        forceSearchOnZoomChanged: true,
                                        automaticallyImplyAppBarLeading: false,
                                        //  autocompleteLanguage: "ko",
                                        region: 'au',
                                        //  selectInitialPosition: true,
                                        selectedPlaceWidgetBuilder: (_,
                                            selectedPlace,
                                            state,
                                            isSearchBarFocused) {
                                          return isSearchBarFocused
                                              ? Container()
                                              : FloatingCard(
                                                  bottomPosition:
                                                      20, // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
                                                  leftPosition: 60,
                                                  rightPosition: 60,

                                                  //  width: 500,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                  child: state ==
                                                          SearchingState
                                                              .Searching
                                                      ? Center(
                                                          child:
                                                              CircularProgressIndicator())
                                                      : Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 30,
                                                                  right: 30),
                                                          child: Container(
                                                            child: RaisedButton(
                                                              color:
                                                                  Colors.blue,
                                                              child: Text(
                                                                "Done",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              onPressed: () {
                                                                // IMPORTANT: You MUST manage selectedPlace data yourself as using this build will not invoke onPlacePicker as
                                                                //            this will override default 'Select here' Button.

                                                                destinationlatlng = LatLng(
                                                                    selectedPlace
                                                                        .geometry
                                                                        .location
                                                                        .lat,
                                                                    selectedPlace
                                                                        .geometry
                                                                        .location
                                                                        .lng);
                                                                destinationAddress =
                                                                    selectedPlace
                                                                        .formattedAddress;

                                                                destinationTextController
                                                                        .text =
                                                                    selectedPlace
                                                                        .formattedAddress;
                                                                isLocationSelected =
                                                                    true;
                                                                setState(() {});
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                );
                                        },
                                        pinBuilder: (context, state) {
                                          if (state == PinState.Idle) {
                                            return
                                                //Icon(Icons.favorite_border);

                                                Container(
                                              width: width * 0.1,
                                              height: height * 0.1,
                                              child: Image.asset(
                                                "images/gsrMapIcon.png",
                                              ),
                                            );
                                          } else {
                                            return Container(
                                                width: width * 0.1,
                                                height: height * 0.1,
                                                child: Image.asset(
                                                  "images/gsrMapIcon.png",
                                                ));
                                          }
                                        },
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Text("select from map"),
                            ),

                            //================================= Cost Kilo-meter Text =======================\\\\\
                          ],
                        ),
                        SlidingUpPanel(
                          minHeight: height * 0.17,
                          maxHeight: height * 0.8,
                          //renderPanelSheet: false,
                          // panel: _floatingPanel(),
                          collapsed: _floatingCollapsed(),
                          color: Colors.white,
                          //backdropEnabled: true,
                          margin: EdgeInsets.only(left: 2, right: 2),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                          panelBuilder: (ScrollController sc) => Stack(
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: width * 0.2,
                                    height: height * 0.01,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                  ),
                                ),
                              ),
                              PageView(
                                controller: controller,
                                scrollDirection: Axis.horizontal,
                                children: [
                                  slidingPanel(width, height),
                                  WaitingForRideToAcept()
                                ],
                              )
                              // slidingPanel(width, height)
                            ],
                          ),
                        ),
                        // _pickTextController.text.length == 0 &&
                        //         _destinationTextController.text.length == 0
                        //     ? Container()
                        //     :

                        /*      Align(
                    alignment: Alignment.bottomCenter,
                    child: Material(
                      shadowColor: Colors.black,
                      elevation: 0.9,
                      child: isLocationSelected == true
                          ? Container(
                              color: AppColors.mainColor.withOpacity(0.2),
                              height: height * 0.5,
                              child: slidingPanel(constraints.maxWidth,
                                  constraints.maxHeight))
                          : null,
                    ),
                  ) */
                      ],
                    ),
                  ),
                ),
              ),
      );
    });
  }

  slidingPanel(double width, double height) {
    return Column(
      children: [
        Flexible(
            flex: 20,
            child: Container(
              margin: EdgeInsets.only(top: height * 0.04),
              child: AutoSizeText(
                "Choose your ride",
                minFontSize: 20,
                maxFontSize: 25,
                style: GoogleFonts.abel(),
              ),
            )),
        Flexible(
          flex: 80,
          child: serviceAvailable == false
              ? Container(
                  height: height,
                  child: Center(
                    child: Text("Service not Available in your city"),
                  ),
                )
              : ListView.builder(
                  itemCount: RideToFromScreen.vehicleList.length,
                  //vehicleList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: InkWell(
                        onTap: () async {
                          selectedVehicleID =
                              RideToFromScreen.vehicleList[index].vehicleTypeId;
                          flushbarIndex = index;
                          //  flushbarIndex = selectedVehicleID;
                          BlocProvider.of<GetdistancecostvehiclewiseBloc>(
                                  context)
                              .add(GetdistancecostvehiclewiseInsertEvent(<
                                  String, dynamic>{
                            "VehicleTypeId": RideToFromScreen
                                .vehicleList[index].vehicleTypeId
                          }));
                          print(
                              "IDD.....IDD...${RideToFromScreen.vehicleList[index].vehicleTypeId}");

                          // PsResource<
                          //         List<DistanceCostVehicleVise>>
                          //     model = await _apiServices
                          //         .getDistanceCostVehicleVise(<
                          //             String, dynamic>{
                          //   "VehicleTypeId": selectedVehicleID
                          // });
                          // _distanceCostVehicleViseList =
                          //     model.data;
                          setState(() {
                            selectedVehicleID = RideToFromScreen
                                .vehicleList[index].vehicleTypeId;
                          });
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: width * 0.85,
                              height: height * 0.14,
                              decoration: BoxDecoration(
                                  color: selectedVehicleID ==
                                          RideToFromScreen
                                              .vehicleList[index].vehicleTypeId
                                      ? AppColors.mainColor.withOpacity(0.7)
                                      : Colors.white,
                                  // border: Border.all(
                                  //     color: Color(0xff4ADEDE),
                                  //     width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0x20000000),
                                        blurRadius: 3.0,
                                        spreadRadius: 3.0,
                                        offset: Offset(0, 3))
                                  ]),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: width * 0.34,
                                      height: height * 0.1,
                                      child: Image.network(
                                        "${RiderApi.baseUrl}${RideToFromScreen.vehicleList[index].vTypeImage}",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AutoSizeText(
                                        "${RideToFromScreen.vehicleList[index].vTypeName}",
                                        minFontSize: 8,
                                        maxFontSize: 16,
                                        maxLines: 2,
                                        style: GoogleFonts.abel(
                                          fontSize: 16,
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
        Container(
          margin: EdgeInsets.only(top: height * 0.03),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: width * 0.45,
                // height: height * 0.09,
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
                  onTap: () {},
                  title: AutoSizeText(
                    'Cost Per Km',
                    minFontSize: 8,
                    maxFontSize: 13,
                    maxLines: 2,
                  ),
                  trailing: BlocBuilder<GetdistancecostvehiclewiseBloc,
                      GetdistancecostvehiclewiseState>(
                    builder: (context, state) {
                      if (state is GetdistancecostvehiclewiseInitial) {
                        return Text("0");
                      } else if (state
                          is GetdistancecostvehiclewiseLoadedState) {
                        resourceList = state.resource.data;
                      }
                      return Text(
                        resourceList.length == null
                            ? "Rs/-  0"
                            : "${resourceList[0].costPerKM}",
                        style: TextStyle(color: Colors.black),
                      );
                    },
                  ),
                ),
              ),
              rideConfirm == true
                  ? RaisedButton(
                      color: AppColors.mainColor,
                      onPressed: () {},
                      child: Icon(Icons.check),
                    )
                  : RaisedButton(
                      color: AppColors.mainColor,
                      onPressed: () {
                        destinationTextController.clear();
                        pickTextController.clear();

                        destinationTextController.text = destinationAddress;
                        pickTextController.text = pickingAddress;

                        Uuid uuid = Uuid();
                        var id = uuid.v4();

                        if (pickTextController.text.isEmpty ||
                            destinationTextController.text.isEmpty ||
                            destinationlatlng == null ||
                            pickLatlng == null ||
                            cityID == null ||
                            selectedVehicleID == null) {
                          FlushBar.showSimpleFlushBar("fill the fields",
                              context, Colors.red, Colors.white);
                        } else {
                          checkConnectivity().then((value) {
                            if (value) {
                              setState(() {
                                rideConfirm = true;
                              });
                              destinationAddress =
                                  destinationAddress.replaceAll(",", "");

                              pickingAddress =
                                  pickingAddress.replaceAll(",", "");
                              if (RiderHomeScreen.hubConnection != null &&
                                  RiderHomeScreen.hubConnection.state ==
                                      HubConnectionState.connected) {
                                print(".abc....email....${Commons.riderEmail}");
                                print(
                                    ".abc...phone......${Commons.riderPhoneNO}");

                                RiderHomeScreen.hubConnection
                                    .invoke("CreateRidingRequest", args: [
                                  "${Commons.riderEmail ?? Commons.riderPhoneNO}",
                                  "${pickLatlng.latitude}",
                                  "${pickLatlng.longitude}",
                                  "${destinationlatlng.latitude}",
                                  "${destinationlatlng.longitude}",
                                  "$pickingAddress",
                                  "$destinationAddress",
                                  "$cityID",
                                  "$id",
                                  "$selectedVehicleID",
                                ]).catchError((e) {
                                  funForRideconfirmBackTofalse();
                                  FlushBar.showSimpleFlushBar(
                                      "your location is not in range of driver ",
                                      context,
                                      Colors.red,
                                      Colors.white);
                                  print(".abc.$e");
                                  print(
                                      ".abc.----------------- Update Driver Location catch error ---------- $e");
                                });
                              } else {
                                 funForRideconfirmBackTofalse();
                                FlushBar.showSimpleFlushBar(
                                    "You Are not connected to server",
                                    context,
                                    Colors.red,
                                    Colors.white);
                                print(
                                    "====================== Hub connection is null =================");
                              }
                            } else {
                               funForRideconfirmBackTofalse();
                              FlushBar.showSimpleFlushBar(
                                  "Check your connection and try again",
                                  context,
                                  Colors.red,
                                  Colors.white);
                            }
                          });

                          // controller.animateToPage(1,
                          //     duration: Duration(seconds: 1),
                          //     curve: Curves.easeIn);
                        }
                      },
                      child: Text(
                        "Confirm",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _floatingCollapsed() {
  return Container(
    decoration: BoxDecoration(
      color: AppColors.mainColor,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
    ),
    margin: const EdgeInsets.only(bottom: 35),
    child: Center(
      child: Text(
        "Choose your ride",
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}

Widget _floatingPanel() {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(24.0)),
        boxShadow: [
          BoxShadow(
            blurRadius: 20.0,
            color: Colors.grey,
          ),
        ]),
    margin: const EdgeInsets.all(24.0),
    child: Center(
      child: Text("This is the SlidingUpPanel when open"),
    ),
  );
}
