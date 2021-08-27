import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get_smart_ride_cas/api/driver_api/driver_api_services.dart';
import 'package:get_smart_ride_cas/utils/utils.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_franchise.dart';
import 'package:get_smart_ride_cas/driver/constant/ps_constants.dart';
import 'package:get_smart_ride_cas/api/common/ps_resource.dart';
import 'package:get_smart_ride_cas/api/common/ps_status.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class DriverFranchiseScreen extends StatefulWidget {
  @override
  _DriverFranchiseScreenState createState() => _DriverFranchiseScreenState();
}

class _DriverFranchiseScreenState extends State<DriverFranchiseScreen> {
  ApiServices _apiServices = ApiServices();

  GoogleMapController mapController;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  List<Marker> _markers = [];

  Position position;
  bool isloading = false;

  DriverFranchiseResponse model = DriverFranchiseResponse();
  @override
  void initState() {
    isloading = true;

    Future.delayed(Duration(seconds: 2), () {
      Utils.checkInternetConnectivity().then((value) async {
        if (value) {
          PsResource<List<DriverFranchiseResponse>> _resource =
              await _apiServices.getDriverFranchise(<String, dynamic>{
            "Str1": "${DriverConst.str1}",
            "Str2": "${DriverConst.str2}",
            "Str3": "${DriverConst.str3}"
          });

          print(_resource.status == PsStatus.SUCCESS);
          if (_resource.status == PsStatus.SUCCESS) {
            setState(() {
              isloading = false;
              model = _resource.data[0];
              _markers.add(Marker(
                  markerId: MarkerId(
                      LatLng(model.latitude, model.longitude).toString()),
                  position: LatLng(model.latitude, model.longitude),
                  draggable: true,
                  // infoWindow: InfoWindow(
                  //   title: first.featureName,
                  //   snippet: first.addressLine,
                  // ),
                  onDragEnd: (drag) {
                    print("...................................$drag");
                  }));
            });
          }
        } else {}
      });
    });

    // TODO: implement initState
    super.initState();
  }

  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Frachise"),
        backgroundColor: Colors.lightBlue,
      ),
      body: isloading == true
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              height: height,
              width: width,
              child: ListView(
                children: [
                  //====================== Image Clipper ======================\\
                  Container(
                    height: height * 0.4,
                    child: GoogleMap(
                      markers: Set.from(_markers),
                      onMapCreated: _onMapCreated,
                      compassEnabled: true,
                      mapToolbarEnabled: true,
                      //   myLocationButtonEnabled: true,
                      // myLocationEnabled: true,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(model.latitude, model.longitude),
                        zoom: 12.0,
                      ),
                    ),
                  ),

                  //===================== End Image Clipper ========================\\

                  //==================== Rider Data Show Here =====================\\

                  Padding(
                    padding: EdgeInsets.only(
                        top: 20, left: 20, right: 20, bottom: 20),
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
                                  '${model.franchiseName}',
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
                                  '${model.email}',
                                ),
                                leading: Icon(
                                  Icons.email,
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
                                  '${model.phoneNumber}',
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
                            //
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
                                  '${model.address}',
                                ),
                                leading: Icon(
                                  Icons.home,
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
                                  '${model.cityName}',
                                ),
                                leading: Icon(
                                  Icons.business_sharp,
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
