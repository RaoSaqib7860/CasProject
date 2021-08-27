import 'dart:async';
import 'package:get_smart_ride_cas/widgets/flush_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_smart_ride_cas/Commons/constant.dart';
import 'package:get_smart_ride_cas/Commons/hub_connection.dart';
import 'package:get_smart_ride_cas/chat/screen/chat_screen_driver.dart';
import 'package:get_smart_ride_cas/driver/constant/ps_constants.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_all_riding_list.dart';
import 'package:get_smart_ride_cas/utils/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math' as Math show cos, sqrt, sin, atan2, pi, asin;

List<LatLng> globalDistanceList = List();

class DriverDrivingMode extends StatefulWidget {
  final DriverAllRidingRequest model;
  const DriverDrivingMode({
    this.model,
  });
  @override
  _DriverDrivingModeState createState() => _DriverDrivingModeState();
}

class _DriverDrivingModeState extends State<DriverDrivingMode> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  Position _currentPosition;

  var height, width;

  double totalDistanceTravelByDriver;

// Define two position variables
  Position _northeastCoordinates;
  Position _southwestCoordinates;

  Position startCoordinates;
  Position destinationCoordinates;
  double totalDistance = 0.0;
  bool isLoadingFabButton;
//
//
  CameraPosition _center = CameraPosition(
    target: LatLng(30.3753, 69.3451),
  );

  _initialCameraPosition(CameraPosition position) {
    double lat, long;
    if (_currentPosition == null) {
      print(".abc....initial cam pos......if");
      // lat = 30.3753;
      // long = 69.3451;
      lat = 29.3829808;
          long= 71.7155015;
    } else {
      print(".abc....initial cam pos......else");
      print(".abc....initial cam pos......$_currentPosition");
      lat = _currentPosition.latitude;
      long = _currentPosition.longitude;
    }
    return CameraPosition(
      target: LatLng(lat, long),
      zoom: 12.0,
    );
  }

  //static LatLng _center = LatLng(-15.4630239974464, 28.363397732282127);
  // static LatLng _initialPosition;
  List<Marker> _markers = [];

//==================== Get Current Location ===================\\

  _getUserLocation() async {
    try {
      var position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      if (position == null) {
        print('.abc.driverride.......null.....unable to get location');
      } else {
        print('.abc.driverride............ get location done');

        _currentPosition = position;

        print('CURRENT POS: $_currentPosition');

        LatLng latLng = LatLng(position.latitude, position.longitude);
        final coordinates = new Coordinates(latLng.latitude, latLng.longitude);
        var addresses =
            await Geocoder.local.findAddressesFromCoordinates(coordinates);
        var first = addresses.first;
        setState(() {});
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 14,
            ),
          ),
        );
        setState(() {});
      }
    } catch (e) {
      print(".abc.driverride..........exception.....$e");
    }
  }

  _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  setNorthSouthCoordinates(Position start, Position destination) {
    print(".abc.driverride.........setNorthSoth");
// Calculating to check that
// southwest coordinate <= northeast coordinate
    if (startCoordinates.latitude <= destinationCoordinates.latitude) {
      _southwestCoordinates = start;
      _northeastCoordinates = destination;
    } else {
      _southwestCoordinates = destination;
      _northeastCoordinates = start;
    }
    print(".abc.driverride....setNorthSouth.....$_southwestCoordinates");
    print(".abc.driverride...setNorthSouth......$_northeastCoordinates");
  }

  MapType _currentMapType = MapType.normal;

//=================================================  Polylines Codes =======================================\\
// Object for PolylinePoints
  PolylinePoints polylinePoints;

// List of coordinates to join
  List<LatLng> polylineCoordinates = [];

// Map storing polylines created by connecting
// two points
  Set<Polyline> polylines = {};
  bool isLoadingMainUi = false;

// Method for retrieving the current location

  // Method for retrieving the address
// Create the polylines for showing the route between two places

  _createPolylines(Position start, Position destination) async {
    print(".abc.driverride.........._createPolylines..........");
    print(
        ".abc.driverride.........._createPolylines.....start..........$start");
    print(
        ".abc.driverride.........._createPolylines.....des..........$destination");
    // Initializing PolylinePoints
    polylinePoints = PolylinePoints();

    // Generating the list of coordinates to be used for
    // drawing the polylines
    PolylineResult result = await polylinePoints?.getRouteBetweenCoordinates(
      Const.MAP_KEY, // Google Maps API Key
      PointLatLng(start.latitude, start.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.transit,
    );
    print(".abc.driverride.........._createPolylines.....res..........$result");
    // Adding the coordinates to the list
    if (result.points.isNotEmpty) {
      print(".abc.driverride.........._createPolylines.....in if");
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    // Defining an ID
    PolylineId id = PolylineId('poly');

    // Initializing Polyline

    // Adding the polyline to the map

    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 5,
    );
    polylines.add(polyline);
    setState(() {});
  }

  @override
  void dispose() {
    isLoadingFabButton = false;
    mapController.dispose();
    super.dispose();
  }

  Timer timer;
  initStartMethods() async {
    await Future.delayed(Duration(seconds: 1));
    _getUserLocation();
    print(".abc...init.....${widget.model.fromLatitude}");
    print(".abc....init....${widget.model.fromLongitude}");
    print(".abc....init....${widget.model.toLatitude}");
    print(".abc....init....${widget.model.toLongitude}");
    startCoordinates = Position(
        latitude: widget.model.fromLatitude,
        longitude: widget.model.fromLongitude);
    destinationCoordinates = Position(
        latitude: widget.model.toLatitude, longitude: widget.model.toLongitude);
    print(".abc....init.st cord...$startCoordinates");
    print(".abc....init.des cord...$destinationCoordinates");
    await setNorthSouthCoordinates(startCoordinates, destinationCoordinates);

    setMapPins(startCoordinates, destinationCoordinates);

    await _createPolylines(startCoordinates, destinationCoordinates);
// Accommodate the two locations within the
// camera view of the map
    sendDriverLocationToClientTimer =
        Timer.periodic(Duration(seconds: 10), (timer) {
      sendLocationToClientRider();
      //  sendDriverLocationToClientTimer.cancel();
    });
  }

  @override
  void initState() {
    isLoadingMainUi = true;
    initStartMethods();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;

    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
        actions: [
          IconButton(
            icon: Icon(Icons.message),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return DriverChatScreen(
                    ridingRequestId: widget.model.ridingRequestId,
                  );
                },
              ));
            },
          )
        ],
      ),
      body: isLoadingMainUi == true
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              child: GoogleMap(
                markers: _markers != null ? Set<Marker>.from(_markers) : null,
                mapType: _currentMapType,
                initialCameraPosition: _initialCameraPosition(_center),
                indoorViewEnabled: true,
                onMapCreated: _onMapCreated,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: false,

                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                buildingsEnabled: true,
                trafficEnabled: true,

                compassEnabled: true,
                //  onTap: _onAddMarkerButtonPressed,
                mapToolbarEnabled: true,
                polylines: polylines,
                // liteModeEnabled: true,
              ),
            ),
      floatingActionButton: isLoadingFabButton == true
          ? CircularProgressIndicator()
          : FloatingActionButton(
              onPressed: () {
                rideCompleted();
                // Navigator.push(context, MaterialPageRoute(
                //   builder: (context) {
                //     return BillDialog(
                //       rideRequestId: widget.model.ridingRequestId,
                //     );
                //   },
                // ));
              },
              child: Icon(
                Icons.check_rounded,
              ),
            ),
    );
  }

  void setMapPins(Position start, Position destintion) {
    print(".abc.driverride..setMapPins........");
    print(".abc.driverride.......setMapPins...start..........$start");
    print(
        ".abc.driverride..........setMapPins.....destintion..........$destintion");

    // Start marker \\
    //
    _markers.add(Marker(
      markerId: MarkerId("Start Point"),
      position: LatLng(
        start.latitude,
        start.longitude,
      ),
      infoWindow: InfoWindow(
        title: 'Start',
        //  snippet: _startAddre\ss,
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));
    print(".abc.driverride..........setMapPins.....marker..........$_markers");
    // Destination marker \\
    //
    _markers.add(Marker(
      markerId: MarkerId("Destination Point"),
      position: LatLng(
        destintion.latitude,
        destintion.longitude,
      ),
      infoWindow: InfoWindow(
        title: 'Destination',
        //  snippet: _destinationAddress,
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));
    print(".abc.driverride..........setMapPins.....marker..........$_markers");
    isLoadingMainUi = false;
    setState(() {});
  }

  rideCompleted() async {
    sendDriverLocationToClientTimer.cancel();
    //  double m = calculateDistance(globalDistanceList);
    double m = getDistanceFromLatLonInKm(
        widget.model.fromLatitude,
        widget.model.fromLatitude,
        widget.model.toLatitude,
        widget.model.toLongitude);
    Utils.checkInternetConnectivity().then((value) {
      if (value) {
        if (hubConnection != null) {
          hubConnection.invoke("CompleteRideAfterAccept", args: [
            "${DriverConst.str1}",
            "${DriverConst.str2}",
            "${DriverConst.str3}",
            "${DriverConst.str4}",
            "${widget.model.ridingRequestId}",
            "${m.floor()}"
          ]).catchError((e) {
            // Fluttertoast.showToast(
            //   msg: e.toString(),
            //   toastLength: Toast.LENGTH_LONG,
            //   gravity: ToastGravity.BOTTOM,
            //   backgroundColor: Colors.blue[900],
            // );
            setState(() {
              isLoadingFabButton = false;
            });
            print(".abcd.....complete ride exception....line 380");
            print(".abcd..--------------- Ride Complete  Error ---------- $e");
          });
          setState(() {
            isLoadingFabButton = true;
          });
        } else {
          FlushBar.showSimpleFlushBar("Check Your Connection and try Again",
              context, Colors.red, Colors.white);
        }
      } else {
        FlushBar.showSimpleFlushBar("Check Your Connection and try Again",
            context, Colors.red, Colors.white);
      }
    });
  }

  sendLocationToClientRider() {
    Utils.determinePosition().then((value) {
      globalDistanceList.add(LatLng(value.latitude, value.longitude));
      if (hubConnection != null) {
        print([
          "${DriverConst.str1}",
          "${DriverConst.str2}",
          "${DriverConst.str3}",
          "${DriverConst.str4}",
          "${value.latitude}",
          "${value.longitude}",
          "${widget.model.ridingRequestId}",
        ]);

        hubConnection.invoke("SendLocationToClient", args: [
          // "${DriverConst.str1}",
          // "${DriverConst.str2}",
          // "${DriverConst.str3}",
          // "${DriverConst.str4}",
          "${value.latitude}",
          "${value.longitude}",
          "${widget.model.ridingRequestId}",
        ]).catchError((e) {
          print(".abc.driverride.........catch exception invoker");
          print("------------------ Send Driver Location Error ---------- $e");
        });
      }
    });
  }

  double getDistanceFromLatLonInKm(
      double lat1, double lon1, double lat2, double lon2) {
    var R = 6371; // Radius of the earth in km
    var dLat = deg2rad(lat2 - lat1); // deg2rad below
    var dLon = deg2rad(lon2 - lon1);
    var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
        Math.cos(deg2rad(lat1)) *
            Math.cos(deg2rad(lat2)) *
            Math.sin(dLon / 2) *
            Math.sin(dLon / 2);
    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    var d = R * c; // Distance in km
    return d;
  }

  double deg2rad(deg) {
    return deg * (Math.pi / 180);
  }

  Future getDistance(double pLat, double pLng) async {
    final double distance = Geolocator.distanceBetween(
        pLat, pLng, widget.model.fromLatitude, widget.model.fromLatitude);
    totalDistanceTravelByDriver = (distance * 0.000621);
    print('-------------my  distance $distance');
    double m = totalDistanceTravelByDriver;
    // print('${m.substring(0, 06)}');
    return m;
  }

  // double coordinateDistance(lat1, lon1, lat2, lon2) {
  //   var p = 0.017453292519943295;
  //   var c = cos;
  //   var a = 0.5 -
  //       c((lat2 - lat1) * p) / 2 +
  //       c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  //   return 12742 * asin(sqrt(a));
  // }

  double calculateDistance(List<LatLng> listLatlng) {
//         double totalDistance = 0.0;
//  for (var i = 0; i < listLatlng.length; i++) {
//       var p = 0.017453292519943295;
//       var c = cos;
//       var a = 0.5 -
//           c((listLatlng[i + 1].latitude - listLatlng[i].latitude) * p) / 2 +
//           c(listLatlng[i].latitude * p) *
//               c(listLatlng[i + 1].latitude * p) *
//               (1 - c((listLatlng[i + 1].longitude - listLatlng[i].longitude) * p)) /
//               2;
//       double distance = 12742 * asin(sqrt(a));
//       totalDistance += distance;
//       print('Distance is ${12742 * asin(sqrt(a))}');
//     }
//     print('Total distance is $totalDistance');
//     return totalDistance;
    // for (int i = 0; i < listLatlng.length - 1; i++) {
    //   totalDistance += coordinateDistance(
    //     listLatlng[i].latitude,
    //     listLatlng[i].longitude,
    //     listLatlng[i + 1].latitude,
    //     listLatlng[i + 1].longitude,
    //   );
    // }
    print('Total distance is $totalDistance');
    return totalDistance;
  }
}
