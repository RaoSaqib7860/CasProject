import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get_smart_ride_cas/rider/screens/splash_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/route_manager.dart';
import 'package:get_smart_ride_cas/Commons/constant.dart';
import 'package:get_smart_ride_cas/api/driver_api/driver_api.dart';
import 'package:get_smart_ride_cas/api/rider_api/waiting_controller.dart';
import 'package:get_smart_ride_cas/chat/chat_controller.dart';
import 'package:get_smart_ride_cas/chat/models/message_model.dart';
import 'package:get_smart_ride_cas/chat/models/user_model.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_riding_request.dart';
import 'package:get_smart_ride_cas/rider/bloc/getRidingRequestForClient/bloc/getDistanceCostVehicleWise/bloc/getdistancecostvehiclewise_bloc.dart';
import 'package:get_smart_ride_cas/rider/home/myController.dart';
import 'package:get_smart_ride_cas/rider/screens/getRideBill.dart';
import 'package:get_smart_ride_cas/rider/screens/signup_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signalr_core/signalr_core.dart';

import 'package:get_smart_ride_cas/Commons/commons.dart';
import 'package:get_smart_ride_cas/api/rider_api/rider_api.dart';
import 'package:get_smart_ride_cas/app/theme/colors.dart';
import 'package:get_smart_ride_cas/app/theme/textStyles.dart';
import 'package:get_smart_ride_cas/rider/bloc/getRidingRequestForClient/bloc/getDriverDataBloc/bloc/getdriverdata_bloc.dart';
import 'package:get_smart_ride_cas/rider/bloc/getRidingRequestForClient/bloc/getridingrquestforclientbloc_bloc.dart';
import 'package:get_smart_ride_cas/rider/objects/getDriverData.dart';
import 'package:get_smart_ride_cas/rider/screens/Edit_profile_screen.dart';
import 'package:get_smart_ride_cas/rider/screens/RideToFromScreen.dart';

import 'package:get_smart_ride_cas/rider/screens/SmartDrawer/profile_card_screen.dart';
import 'package:get_smart_ride_cas/rider/screens/SmartDrawer/totalRides.dart';

import 'package:get_smart_ride_cas/rider/widgets/customWidgets/FoxyFabBtn.dart';
import 'package:get_smart_ride_cas/rider/widgets/customWidgets/collapsible_sidebar.dart';
import 'package:get_smart_ride_cas/rider/widgets/custom_drawer/slidebar/collapsible_item.dart';
import 'package:get_smart_ride_cas/utils/utils.dart';
import 'package:get_smart_ride_cas/rider/firebaseAuth/authentications.dart';
import 'package:get_smart_ride_cas/widgets/exit_app_dialog.dart';
import 'package:get_smart_ride_cas/widgets/flush_bar.dart';
import 'package:http/http.dart ' as http;
import 'package:get/get.dart';

var latitude;
var longitude;
var ridingRequestId;
//List<GetDriverData> driverDataList;
bool rideConfirm;
bool rideCompleted;
bool rideAccepted;
bool rideStarted;
List<DriverRidingRequestById> driverRidingRequestById;
List<GetDriverData> driverDataList;

class RiderHomeScreen extends StatefulWidget {
  final String currentUserPhoneNumber;
  static bool screen;
  final File imageForOtp;
  final String firstName;
  final String lastName;
  String riderName;
  String currentUserEmail;
  final String riderImage;
  final riderPhoneNo;
  static HubConnection hubConnection;
  double width;
  double height;
  List<GetDriverData> getDriverDataList;
  int id;
  int radioButton;
  RiderHomeScreen(
      {Key key,
      this.riderPhoneNo,
      this.radioButton,
      this.imageForOtp,
      this.currentUserPhoneNumber,
      this.currentUserEmail,
      this.riderName,
      this.width,
      this.id,
      this.riderImage,
      this.getDriverDataList,
      this.firstName,
      this.lastName,
      this.height})
      : super(key: key);
  @override
  _RiderHomeScreenState createState() => _RiderHomeScreenState();
}

class _RiderHomeScreenState extends State<RiderHomeScreen> {
  GoogleMapController mapController;
  var homeScreen = RiderHomeScreen();
  final LatLng _center = const LatLng(45.521563, -122.677433);

  get height => MediaQuery.of(context).size.height * 0.005;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<List<DriverRidingRequestById>> getListByRidingRequestId(
      int ridingRequestId) async {
    final http.Response response = await http.post(
        DriverApi.driverLatestBookingRequestById,
        body: jsonEncode(
            <String, String>{"RidingRequestId": ridingRequestId.toString()}),
        headers: <String, String>{
          "Content-type": "application/json; charset=utf-8"
        });

    /// {"RidingRequestId": ridingRequestId.toString()}

    if (response.statusCode == 200) {
      var output = jsonDecode(response.body);

      return DriverRidingRequestById.fromMapList(output);
    } else {
      throw Exception('Failed to create .');
    }
  }

  Future loadList(int ridingRequestId) async {
    driverRidingRequestById = await getListByRidingRequestId(ridingRequestId);

    setState(() {});
  }

  Dialog alert = Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        width: 100,
        height: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("waiting for driver to accept"),
            SizedBox(
              height: 15,
            ),
            CircularProgressIndicator()
          ],
        )
        //Text("AlertDialog")
        ),
    //   title: Text("AlertDialog"),
    //  content: Text("Waitng For  Your Driver"),
  );
  startTime() {
    dialog();
    var dur = Duration(seconds: 90);
    return Timer(dur, route);
  }

  dialog() {
    showAnimatedDialog(
        context: context,
        animationType: DialogTransitionType.scale,
        //   duration: Duration(seconds: 5),
        builder: (context) {
          /// if (driverDataList != null) {
          return WillPopScope(
            onWillPop: _willPopCallback,
            child: Dialog(
              child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  width: 100,
                  height: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("waiting for driver to accept"),
                      SizedBox(
                        height: 15,
                      ),
                      CircularProgressIndicator()
                    ],
                  )
                  //Text("AlertDialog")
                  ),
            ),
          );
          // }
          // return Container();
        });
  }

  route() {
    print(".abc........route");
    if (rideAccepted != true) {
      print(".abc........if route");
      Navigator.pop(context);
      Navigator.pop(context);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => RiderHomeScreen(),
      //   ),
      // );
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => RiderHomeScreen(),
      //     ),
      //     (route) => false);

      rideConfirm = false;
      FlushBar.showSimpleFlushBar("No driver available at the moment", context,
          Colors.red, Colors.white);
    }
  }

  Widget _tabOne() {
    return Scaffold(
      //  backgroundColor: AppColors.secondMainColor.withOpacity(0.2),
      body: Center(
        child: GoogleMap(
          onMapCreated: _onMapCreated,
          compassEnabled: true,
          mapToolbarEnabled: true,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          initialCameraPosition: CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 12.0,
          ),
        ),
      ),
    );
  }

  List<CollapsibleItem> _items;

  Widget _backgroundScreen;

  String dataFromPrevious;

  Position position;
  String driverId;

  // NetworkImage _avatarImg =
  // NetworkImage('https://www.w3schools.com/howto/img_avatar.png');
  List name;
  var connectivityResult;

  Timer _timer;

  createServerConnection() {
    MyController.to.isConectionStarted = true;
    print(".abc..................... create server");
    var email;
    if (widget.currentUserEmail != null) {
      email = widget.currentUserEmail;
    } else if (Commons.riderEmail != null) {
      email = Commons.riderEmail;
    } else {
      email = Commons.riderPhoneNO;
    }
    print(".abc.......email final..........$email.");

    final serverUrl =
        "${RiderApi.baseUrl}/ChatHub?Str1=$email&Str2=${widget.currentUserPhoneNumber != null ? widget.currentUserPhoneNumber : Commons.riderPhoneNO}&Str3=${""}&Str4=${"RidingClient"}";
    print(".abc........serv url.........$serverUrl.");
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((LogRecord rec) {});

    // If you want only to log out the message for the higer level hub protocol:
    // final hubProtLogger = Logger("SignalR - hub");
    // If youn want to also to log out transport messages:
    // final transportProtLogger = Logger("SignalR - transport");
    final httpOptions = HttpConnectionOptions(
      logMessageContent: true,
      logging: (Level, message) => null,
      // print(".abc......logging Hub Connection Msg : $message"),
    );

    RiderHomeScreen.hubConnection =
        HubConnectionBuilder().withUrl(serverUrl, httpOptions).build();
    serverMsg();
    // .configureLogging(hubProtLogger)
    ///
  }

  Future<bool> checkConnectivity() async {
    bool isConnected = await Utils.checkInternetConnectivity();
    return isConnected;
  }

  startServerConnection() async {
    print(".abc..................... start server");
    print(RiderHomeScreen.hubConnection.state);
    await RiderHomeScreen.hubConnection.start().then((value) {
      print(".abc--------------- Connection Start -------------");
      FlushBar.showSimpleFlushBar(
          "Server Connected", context, Colors.blue, Colors.white);
    }).catchError((e) {
      print(e);
      print(".abc.............Server Errors");
    });
  }

  onCloseServerConnection() async {
    print(".abc.............close server");
    RiderHomeScreen.hubConnection.onclose((error) {
      print("-------------------Connection is Closed --------------");
      FlushBar.showSimpleFlushBar(
          "Server Connection Close", context, Colors.red, Colors.white);
    });
  }

  serverMsg() {
    RiderHomeScreen.hubConnection
        .on("ReceiveMessage", _handleDriverProvidedFunction);
  }

  _handleDriverProvidedFunction(List<Object> list) async {
    print(".abc..............handler");
    String serverMessageForPatient = list[0].toString();
    print(
        ".abc......Msg From Server.......${serverMessageForPatient.toString()}");
    // Fluttertoast.showToast(
    //   msg: serverMessageForPatient.toString(),
    //   toastLength: Toast.LENGTH_LONG,
    //   gravity: ToastGravity.BOTTOM,
    //   backgroundColor: Colors.blue[900],
    // );
    var splitServerMessagePattern = serverMessageForPatient.split(",");
    if (splitServerMessagePattern[1].toString() ==
        " No Driver is Available Near by You]") {
      funForRideconfirmBackTofalse();
      FlushBar.showSimpleFlushBar("Driver is not available near you", context,
          Colors.red, Colors.white);
    } else if (splitServerMessagePattern[1].toString() ==
        " Registered Successfully") {
    } else if (splitServerMessagePattern[0].toString() ==
        "[RejectRidingRequestAfterAccept") {
      FlushBar.showSimpleFlushBar(
          "Reject Successfullly", context, Colors.red, Colors.white);
      // yeh islia kra o necha se botom sheet sheet ati use wapis index 2 pe
      // laka jatay
      funForRideconfirmBackTofalse();
      animateToNextPage(page: 0);
      BlocProvider.of<GetridingrquestforclientblocBloc>(context).add(
          GetRidingRequestForClientBlocEvent(
              Commons.riderEmail, Commons.riderPhoneNO, ""));
    } else if (splitServerMessagePattern[0].toString() ==
        "[StartRideAfterAccept") {
      FlushBar.showSimpleFlushBar(
          "START RIDE", context, Colors.orange, Colors.white);
      rideStarted = true;
      BlocProvider.of<GetridingrquestforclientblocBloc>(context).add(
          GetRidingRequestForClientBlocEvent(
              Commons.riderEmail, Commons.riderPhoneNO, ""));
      // setState(() {

      // });
    } else if (splitServerMessagePattern[0].toString() ==
        "[SendDriverLocationToClient") {
      FlushBar.showSimpleFlushBar(
          "Driver On the Way", context, Colors.blue, Colors.white);
      latitude = splitServerMessagePattern[1].toString();
      longitude = splitServerMessagePattern[2].toString();
      longitude = longitude.replaceAll("]", "");
      latitude = latitude.replaceAll(" ", "");
      setState(() {});
      // double.parse(latitude);
      // double.parse(longitude);
    } else if (splitServerMessagePattern[0].toString() ==
        "[CompleteRideAfterAccept") {
      List idList = splitServerMessagePattern[1].toString().split(':');
      int id = int.parse(idList[1]);

      FlushBar.showSimpleFlushBar(
          "Ride Complete Succesfully", context, Colors.green, Colors.white);
      rideCompleted = true;
      ChatController chatController = Get.put(ChatController());

      ChatController.to.listclear();

      //   BlocProvider<GetdriverdataBloc>(
      //   create: (context) => GetdriverdataBloc(),
      //   child: GetSmartRideApp(),
      // )
      // Navigator.of(context).pushReplacement(MaterialPageRoute(
      //       builder: (BuildContext context) =>GetRideBillClass(
      //             rideRequestId: id,
      //           )));

      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (_) => GetRideBillClass(
                  rideRequestId: id,
                )),
      );
    } else if (splitServerMessagePattern[0].toString() == "[ChattMessages") {
      String messagename = splitServerMessagePattern[1].toString();
      String ridingClient = splitServerMessagePattern[2].toString();
      String mName = messagename.replaceFirst(" ", "");
      String client = ridingClient.replaceFirst(" ", "");

      ChatController.to
          .sendMsg(Message(text: mName, sender: User(name: client)));
      FlushBar.showSimpleFlushBar(
          "$mName", context, Colors.green, Colors.white);
    } else if (splitServerMessagePattern[
                splitServerMessagePattern.length > 2 ? 2 : 0]
            .toString() ==
        " Request Inserted Successfully]") {
      print(".abc............mmmmmmmmmmmmm");
      animateToNextPage();
      WaitingController.to.driverwaitng(true);
      rideConfirm = true;
      if (driverRidingRequestById != null) {
        driverRidingRequestById = null;
        rideAccepted = false;
        //setState(() {});
      }
      startTime();
      FlushBar.showSimpleFlushBar(
          "Inserted successfully", context, Colors.blue, Colors.white);
      // if (driverDataList != null) {
      //   // setState(() {
      //   //   .driverDataList = null;
      //   // });
      BlocProvider.of<GetdriverdataBloc>(context)
          .add(GetdriverdataEmptyListEvent());

      if (driverDataList != null) {
        driverDataList = null;
        rideAccepted = false;
      }
    } else if (splitServerMessagePattern[
                splitServerMessagePattern.length > 3 ? 3 : 0]
            .toString() ==
        " Request Accepted Successfully]") {
      ridingRequestId = splitServerMessagePattern[1].toString().split(':');
      ridingRequestId = int.parse(ridingRequestId[1]);

      // driverRidingRequestById = null;
      //  if (ridingRequestId != null) {
      await loadList(ridingRequestId);

      rideAccepted = true;
      Navigator.pop(context);
      // Navigator.push(context, MaterialPageRoute(builder: (context) {
      //   return RiderHomeScreen();
      // }));
      funForRideconfirmBackTofalse();

      WaitingController.to.driverwaitng(false);

      //===============
      String rideRequestedID = splitServerMessagePattern[1].toString();

      String rideId = rideRequestedID.split(":").toString();

      List riderRideID = rideId.split(",");
      String b = riderRideID[1].replaceAll(" ", "").replaceAll("]", "");

//===========
      driverId = splitServerMessagePattern[2].toString();

      String id = driverId.split(":").toString();

      name = id.split(",");
      String a = name[1].replaceAll(" ", "").replaceAll("]", "");
      // print("id,,,,,,,,,,,${name[1].replaceAll(" ", "").replaceAll("]", "")}");

      FlushBar.showSimpleFlushBar(
          "Ride Accepted", context, Colors.blue, Colors.white);
      BlocProvider.of<GetridingrquestforclientblocBloc>(context).add(
          GetRidingRequestForClientBlocEvent(
              Commons.riderEmail, Commons.riderPhoneNO, ""));
      BlocProvider.of<GetdriverdataBloc>(context).add(GetdriverdataInsertEvent(
          driverId: int.parse(a), rideRequestId: int.parse(b)));
    } else {
      ///....... can be used above
      funForRideconfirmBackTofalse();
      //.................... email is not valid
      FlushBar.showSimpleFlushBar("Check your connection and try again",
          context, Colors.red, Colors.white);
    }

//Request Accepted Successfully]
    // if (splitServerMessagePattern[0].toString() == "UpdateDriverLocation") {}
  }

  Future<bool> _willPopCallback() async {
    FlushBar.showSimpleFlushBar(
        "request is processing", context, Colors.pink, Colors.white);
    return true;
  }

  bool isLoading = false;
  final Auth _auth = Auth();
  @override
  void dispose() {
    super.dispose();
    print(".abc................dispose of rider home screen");

  }

  //*************************************     init      */
  @override
  void initState() {
    print(".abc................init");
    //  print("RADIO BUTTON VALUE.......${widget.radioButton}");
    // BlocProvider<GetdriverdataBloc>(create: (context) => GetdriverdataBloc());
    isLoading = true;
    RiderHomeScreen.screen = true;
    if (MyController.to.isConectionStarted == false) {
      print(".abc.............my con ka check");
      createServerConnection();
    }

    checkConnectivity().then((value) {
      // print("");
      if (value == true) {
        if (RiderHomeScreen.hubConnection.state ==
            HubConnectionState.disconnected) {
          print(".abc...........disconnected check");

          /// ....ejaz
          startServerConnection();
        } else {
          print(".abc...........else");
        }
      }
    });

    _timer = Timer.periodic(Duration(seconds: 18), (timer) {
      if (RiderHomeScreen.hubConnection.state ==
          HubConnectionState.disconnected) {
        checkConnectivity().then((value) {
          if (value == true) {
            print(".abc......if..... 18 sec bad true hgya net");
            startServerConnection();
          } else {
            print(".abc......else..... 18 sec bad true hgya net");
            FlushBar.showSimpleFlushBar(
                "Check Connection", context, Colors.red, Colors.white);
          }
        });
      }
    });

    super.initState();
    print(".abc....longi..befor...$latitude");
    print(".abc......lati......befor..$longitude");

    // _items = _generateItems;
    //     _backgroundScreen = TabOne(
    //   latitude:latitude,
    //   longitude:longitude,
    // );

    _items = _generateItems;
    print(".abc........generate......${_items.length}");
    _backgroundScreen = TabOne(
      latitude: latitude == null ? 0 : double.parse(latitude),
      longitude: longitude == null ? 0 : double.parse(longitude),
    );
  }

  List<CollapsibleItem> get _generateItems {
    return [
      CollapsibleItem(
        text: 'New Ride',
        icon: Icons.directions_car,
        onPressed: () => setState(
          () => _backgroundScreen = TabOne(
            driverDataList: widget.getDriverDataList,
            //      latitude: double.parse(latitude),
            //      longitude: double.parse(longitude),
          ),
        ),
        isSelected: true,
      ),

      CollapsibleItem(
        text: 'All Rides',
        icon: Icons.directions_bus,
        onPressed: () => setState(() => _backgroundScreen = Stack(
              children: [
                RiderAllRidesListPage(),
              ],
            )),
      ),
      // CollapsibleItem(
      //   text: 'Completed',
      //   icon: Icons.done,
      //   onPressed: () => setState(() => _backgroundScreen = Stack(
      //         children: [
      //           CompletedRides(),
      //         ],
      //       )),
      // ),
      // CollapsibleItem(
      //   text: 'Cancelled',
      //   icon: Icons.cancel_outlined,
      //   onPressed: () =>
      //       setState(() => _backgroundScreen = CancelledRidesCard()),
      // ),
      CollapsibleItem(
        text: 'My Profile',
        icon: Icons.account_box_outlined,
        onPressed: () => setState(() => _backgroundScreen = ProfileCard(
              riderName: widget.riderName,
              riderEmail: widget.currentUserEmail,
              riderImage: widget.riderImage,
              imageForOtp: widget.imageForOtp,
              //firstName: widget.firstName,
              riderPhoneNo: widget.riderPhoneNo,
              //lastName: widget.lastName,
            )),
      ),
      // CollapsibleItem(
      //   text: 'Theme',
      //   icon: Icons.toggle_on_outlined,
      //   onPressed: () =>
      //       setState(() => _backgroundScreen = ChangeThemeModeCard()),
      // ),
      CollapsibleItem(
          text: 'Signout',
          // icon: Icons.settings_applications_outlined,
          icon: Icons.logout,
          //   onPressed: () => setState(() => _backgroundScreen = SettingsCard()),
          onPressed: () async {
            _auth.googleSignOut();
            setDataToSharedPreferances();
            print(".abc......pressed");
            await RiderHomeScreen.hubConnection.stop();
            _timer.cancel();
            print(".abc......pressed");
            print(".abc......${MyController.to.isConectionStarted}");
            MyController.to.isConectionStarted = false;
            print(".abc......${MyController.to.isConectionStarted}");
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
              builder: (context) {
                return SplashScreen();
                //  return SignupScreen();
              },
            ), (route) => false);
          }),
    ];
  }

  Future<void> setDataToSharedPreferances() async {
    SharedPreferences model = await SharedPreferences.getInstance();
    model.remove(Const.RIDER_EMAIL);
    model.remove(Const.RIDER_PHONE_NO);
    model.remove(Const.Riderimage);
    // model.clear();
  }

  void deleteSharedPrefValues() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.getKeys();
    for (String key in preferences.getKeys()) {
      if (key != Const.APP_DESCRIPTION) {
        preferences.remove(key);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
// WillPopScope(
//       onWillPop: _onWillPop,
    return Scaffold(
      backgroundColor: Colors.green,
      body: LayoutBuilder(
        builder: (context, constraints) => Container(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: CollapsibleSidebar(
            items: _items,

            // avatarImg: _avatarImg,
            height: constraints.maxHeight * 0.47,

            fitItemsToBottom: true,
            title: '',
            body: _body(size, context),
            backgroundColor: Colors.transparent,
            selectedTextColor: AppColors.whiteColor,
            selectedIconColor: AppColors.whiteColor,
            unselectedIconColor: AppColors.mainColor,
            unselectedTextColor: AppColors.mainColor,
            textStyle: AppTextStyles.heading2small,
            titleStyle: AppTextStyles.heading2small,
            toggleTitleStyle: AppTextStyles.heading2.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.whiteColor),
            //fitItemsToBottom: true,
            maxWidth: MediaQuery.of(context).size.width * 0.4,
            iconSize: 25,
            selectedIconBox: AppColors.mainColor,
          ),
        ),
      ),
      floatingActionButton: FabCircularMenu(
        fabElevation: 5,

        fabMargin: const EdgeInsets.all(0),

        fabCloseIcon: Image.asset(
          'images/car.jpg',
          // color: Colors.black,
        ),

        ringDiameter: MediaQuery.of(context).size.height * 0.4,
        ringWidth: MediaQuery.of(context).size.width * 0.2,
        ringColor: AppColors.mainColor.withOpacity(0.5),
        //fabColor: Colors.white,
        //fabOpenColor: AppColors.greenColor.withOpacity(0.01025),
        fabSize: MediaQuery.of(context).size.width * 0.24,
        animationCurve: Curves.easeIn,
        animationDuration: Duration(milliseconds: 800),
        alignment: Alignment.bottomCenter,
        fabChild: Image.asset('images/car_fab.png'),
        children: <Widget>[
          InkWell(
            onTap: () {
              checkConnectivity().then((value) {
                if (value == true) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_) =>
                            BlocProvider<GetdistancecostvehiclewiseBloc>(
                                create: (context) =>
                                    GetdistancecostvehiclewiseBloc(),
                                child: RideToFromScreen())),
                  );
                } else {
                  FlushBar.showSimpleFlushBar(
                      "Check Connection ", context, Colors.red, Colors.white);
                }
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.35,
              //height: 50,
              child: CircleAvatar(
                backgroundColor: AppColors.greyColor,
                radius: 35,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimatedTextKit(
                      animatedTexts: [
                        FadeAnimatedText(
                          'BOOK',
                          textStyle: AppTextStyles.heading2small,
                        ),
                        ScaleAnimatedText(
                          'NEW RIDE',
                          textStyle: AppTextStyles.heading2small,
                        ),
                      ],
                      isRepeatingAnimation: true,
                      repeatForever: true,
                    ),
                    Icon(
                      Icons.car_rental,
                      color: AppColors.mainColor,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => EditProfileMainScreen()),
              );
            },
            child: CircleAvatar(
              backgroundColor: AppColors.greyColor,
              radius: 35,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedTextKit(
                    animatedTexts: [
                      FadeAnimatedText(
                        'SEE',
                        textStyle: AppTextStyles.heading2small,
                      ),
                      ScaleAnimatedText(
                        'PROFILE',
                        textStyle: AppTextStyles.heading2small,
                      ),
                    ],
                    isRepeatingAnimation: true,
                    repeatForever: true,
                  ),
                  Icon(
                    Icons.account_box_outlined,
                    color: AppColors.mainColor,
                    size: 30,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> _onWillPop() {
    return showDialog<dynamic>(
            context: context,
            builder: (BuildContext context) {
              return ConfirmDialogView(
                  description: 'Do you really want to quit?',
                  leftButtonText: 'Cancel',
                  rightButtonText: 'OK',
                  onAgreeTap: () {
                    SystemNavigator.pop();
                  });
            }) ??
        false;
  }

  Widget _body(Size size, BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.blueGrey[50],
      child: Center(
        child: _backgroundScreen,
      ),
    );
  }
}

class TabOne extends StatefulWidget {
  final int driverId;
  final double latitude;
  final double longitude;
  final List<GetDriverData> driverDataList;
  const TabOne({
    Key key,
    this.driverDataList,
    this.driverId,
    this.latitude,
    this.longitude,
  }) : super(key: key);
  @override
  _TabOneState createState() => _TabOneState();
}

class _TabOneState extends State<TabOne> {
  GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Position position;
  bool isloading = false;

  List<Marker> _markers = [];

  Timer timer;

  @override
  void initState() {
    // TODO: implement initState
//BlocProvider.of<GetdriverdataBloc>(context).add(GetdriverdataInsertEvent(widget.driverId));

    super.initState();

    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (latitude != null && longitude != null) {}

      _markers = [];
      if (latitude != null && longitude != null) {
        addmarker();
      }
      // setState(() {});
    });
    // if (latitude != null && longitude != null) {

    ///  }
    // }
    // print("MAPP LATITUDE............${latitude}");
    // print("MAPP LONGITUDEE............${longitude}");
    isloading = true;
    Utils.determinePosition().then((value) {
      setState(() {
        isloading = false;
        position = value;
      });
    });
    //
  }

  addmarker() {
    if (latitude != null && longitude != null) {}
    if (mounted) {
      setState(() {
        //  if (latitude != null && longitude != null) {
        _markers.add(Marker(
            icon: BitmapDescriptor.defaultMarker,
            position: LatLng(double.parse(latitude), double.parse(longitude)),
            markerId: MarkerId(latitude.toString())));
        //  }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return isloading == true
        ? Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            backgroundColor: AppColors.secondMainColor.withOpacity(0.2),
            body: Column(
              children: [
                // driverDataList != null
                //     ? Flexible(
                //         flex: 20,
                //         fit: FlexFit.tight,
                //         child: Container(
                //             //   color: Colors.red,
                //             width: width,
                //             // width: width * 0.9, height: height * 0.13
                //             child: Padding(
                //               padding: const EdgeInsets.all(8.0),
                //               child: Card(
                //                 shape: RoundedRectangleBorder(
                //                     borderRadius: BorderRadius.circular(20)),
                //                 elevation: 5,
                //                 color: Colors.white,
                //                 child: Stack(
                //                   children: [
                //                     Row(
                //                       children: [
                //                         Container(
                //                             // alignment: Alignment.centerLeft,
                //                             width: width * 0.2,
                //                             height: height * 0.1,
                //                             margin: EdgeInsets.only(
                //                                 left: width * 0.03),
                //                             decoration: BoxDecoration(
                //                                 //   color: Colors.red,
                //                                 image: DecorationImage(
                //                                     image: NetworkImage(
                //                                         "${RiderApi.baseUrl + driverDataList[0].image}"),
                //                                     fit: BoxFit.fill))),
                //                         Column(
                //                           mainAxisAlignment:
                //                               MainAxisAlignment.center,
                //                           children: [
                //                             AutoSizeText(
                //                               driverDataList[0].name,
                //                               maxFontSize: 20,
                //                               minFontSize: 10,
                //                               maxLines: 1,
                //                               style: GoogleFonts.alegreya(),
                //                             ),
                //                             Padding(
                //                               padding: const EdgeInsets.only(
                //                                   top: 8, left: 8),
                //                               child: AutoSizeText(
                //                                   driverDataList[0].phoneNumber,
                //                                   maxFontSize: 20,
                //                                   minFontSize: 10,
                //                                   maxLines: 1,
                //                                   style:
                //                                       GoogleFonts.alegreya()),
                //                             ),
                //                             Padding(
                //                               padding: const EdgeInsets.only(
                //                                   top: 8, left: 8),
                //                               child: AutoSizeText(
                //                                   driverDataList[0].vehicleNo,
                //                                   style:
                //                                       GoogleFonts.alegreya()),
                //                             ),
                //                           ],
                //                         ),
                //                       ],
                //                     ),
                //                     Padding(
                //                       padding: const EdgeInsets.all(8.0),
                //                       child: Align(
                //                           alignment: Alignment.bottomRight,
                //                           child: InkWell(
                //                               onTap: () {
                //                                 // Navigator.push(
                //                                 //   context,
                //                                 //   MaterialPageRoute(
                //                                 //       builder: (context) =>
                //                                 //           ChatScreen(
                //                                 //             ridingRequestId: id,
                //                                 //           )),
                //                                 // );
                //                               },
                //                               child: Icon(Icons.chat))),
                //                     )
                //                   ],
                //                 ),
                //               ),
                //             )),
                //       )
                //     : Container(),

                // driverDataList != null
                //     ? Flexible(
                //         flex: 20,
                //         fit: FlexFit.tight,
                //         child: Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: InkWell(
                //               onTap: () {
                //                 dialog();
                //               },
                //               child: Container(
                //                   width: width,
                //                   color: Colors.red,
                //                   // width: 200,
                //                   // height: 200,
                //                   child: Icon(Icons.chat))),
                //         ),
                //       )
                //     : Container(),
                Flexible(
                  flex: 80,
                  fit: FlexFit.tight,
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    compassEnabled: true,
                    mapToolbarEnabled: true,
                    markers: Set<Marker>.from(_markers),
                    //   myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(position.latitude, position.longitude),
                      zoom: 12.0,
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  // dialog() {
  //   showAnimatedDialog(
  //       context: context,
  //       animationType: DialogTransitionType.scale,
  //       duration: Duration(seconds: 2),
  //       builder: (context) {
  //         /// if (driverDataList != null) {
  //         return DialogDriverDataAfterRideAccept(
  //             // driverDataList: driverDataList,
  //             );
  //         // }
  //         // return Container();
  //       });
  // }
}
