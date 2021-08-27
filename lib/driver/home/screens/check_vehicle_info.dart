import 'package:clip_shadow/clip_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get_smart_ride_cas/api/common/ps_resource.dart';
import 'package:get_smart_ride_cas/api/driver_api/driver_api_services.dart';
import 'package:get_smart_ride_cas/api/driver_api/driver_api.dart';

import 'package:get_smart_ride_cas/driver/cliper.dart/bottom_rounded_cliper.dart';
import 'package:get_smart_ride_cas/driver/constant/ps_constants.dart';
import 'package:get_smart_ride_cas/driver/home/screens/driver_image.dart';
import 'package:get_smart_ride_cas/driver/repository/initial_requirements/bloc/driverinitialrequirements_bloc.dart';
import 'package:get_smart_ride_cas/driver/view_object/Driver_vehicle_info.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_vehicle_info_res.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_vehicle_type.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_vehicle_type_res.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class CheckDriverVehicleInfoPage extends StatefulWidget {
  String phoneNo;
  String password;
  @override
  _CheckDriverVehicleInfoPageState createState() =>
      _CheckDriverVehicleInfoPageState();

  CheckDriverVehicleInfoPage({this.password, this.phoneNo});
}

class _CheckDriverVehicleInfoPageState extends State<CheckDriverVehicleInfoPage>
    with TickerProviderStateMixin {
  var height, width;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextStyle textStyle = TextStyle(color: Colors.black, fontSize: 19);
  TextStyle textStyle2 = TextStyle(color: Colors.black, fontSize: 19);

  // Color iconColor = Colors.white;
  Color appbarColor = Color(0xff4ADEDE);

  Color cardBorderColor = Colors.lightBlue;

  bool textOpacity = false;

  AnimationController _controller, _iconController;
  Animation _animationIcon;

  //== Text Field Propertiies ===\\

  TextEditingController _brandController = TextEditingController();
  TextEditingController _modelController = TextEditingController();
  TextEditingController _colorController = TextEditingController();
  TextEditingController _numberPlateControllr = TextEditingController();
  TextEditingController _noOfPassengerController = TextEditingController();

  TextStyle _textStyleBlueTheme = TextStyle(
    color: Colors.blue,
  );
  Color iconColor = Colors.blue;

  bool backgroundfill = false;
  Color backgroundColor = Colors.grey;
  int selectedVehicleTypeId;

  List<DriverVehicleTypeResponse> vehicleList = List();

  Future<PsResource<List<DriverVehicleTypeResponse>>> get() async {
    DriverVehicleType model = DriverVehicleType(
        str1: DriverConst.str1,
        str2: DriverConst.str2,
        str3: DriverConst.str3,
        str4: DriverConst.str4);

    ApiServices _api = ApiServices();
    PsResource<List<DriverVehicleTypeResponse>> _resource =
        await _api.driverVehicleType(model.toMap(model));

    return _resource;
  }

  bool isLoading = false;
  @override
  void initState() {
    isLoading = true;
    Future.delayed(const Duration(milliseconds: 0), () {
      setState(() {
        textOpacity = true;
      });
    });
    get().then((value) {
      setState(() {
        isLoading = false;
        vehicleList = value.data;
      });
    });
    _iconController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    _animationIcon = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _iconController, curve: Curves.decelerate));
    // ..addListener(() {
    //   setState(() {
    //     //  print(_animation.value);
    //   });
    // })
    // ..addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     _iconController.reverse();
    //   } else if (status == AnimationStatus.dismissed) {
    //     _iconController.forward();
    //   }
    // });
    _iconController.forward();
    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    var boxHeight = height * 0.15;
    var boxWidth = width * 1;

    return Scaffold(
        body: Container(
      height: height,
      width: width,
      child: isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Form(
                key: formKey,
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
                                      image: AssetImage(
                                          "images/car_on_bridge.jpg"),
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
                                      padding:
                                          EdgeInsets.only(top: height * 0.1),
                                      child: Container(
                                        child: Text(
                                          "Vehicle",
                                          style: TextStyle(
                                              fontSize: 26,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: height * 0.02),
                                      child: Container(
                                        child: Text(
                                          "Inforamation",
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
                    //============================= Image Container End Here ==============================\\

                    Container(
                      color: Colors.transparent,
                      height: height * 0.2,
                      width: width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3, crossAxisSpacing: 10),
                          itemCount: vehicleList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () async {
                                selectedVehicleTypeId =
                                    vehicleList[index].vehicleTypeId;

                                print(
                                    "IDD.....IDD...${vehicleList[index].vehicleTypeId}");

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
                                  selectedVehicleTypeId =
                                      vehicleList[index].vehicleTypeId;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 2, right: 2),
                                height: height * 0.1,
                                //  width: width * 0.3,
                                // alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: selectedVehicleTypeId ==
                                            vehicleList[index].vehicleTypeId
                                        ? Colors.orange
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
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Image.network(
                                        "${DriverApi.baseUrL}${vehicleList[index].vTypeImage}"),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    //=========================== Vehicle Data =====================\\
                    //
                    ///================= Brand ===================\\\
                    ///
                    Padding(
                      padding: EdgeInsets.only(
                          top: height * 0.05, left: 28, right: 28),
                      child: AnimatedContainer(
                        curve: Curves.bounceOut,
                        duration: Duration(seconds: 3),
                        width: textOpacity == false
                            ? 0
                            : MediaQuery.of(context).size.width,
                        child: Container(
                          //   color: Colors.grey,
                          height: height * 0.11,
                          child: TextFormField(
                            controller: _brandController,
                            keyboardType: TextInputType.name,
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Brand is required"),
                            ]),
                            decoration: InputDecoration(
                              fillColor: backgroundColor,
                              filled: backgroundfill,

                              //  focusColor: Colors.grey,
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: iconColor, width: 2)),
                              labelText: "Brand",
                              labelStyle: _textStyleBlueTheme,
                              hintText: "Brand",
                            ),
                          ),
                        ),
                      ),
                    ),

                    ///================= Model ===================\\\
                    ///
                    Padding(
                      padding: EdgeInsets.only(top: 0, left: 28, right: 28),
                      child: AnimatedContainer(
                        curve: Curves.bounceOut,
                        duration: Duration(seconds: 3),
                        width: textOpacity == false
                            ? 0
                            : MediaQuery.of(context).size.width,
                        child: Container(
                          // color: Colors.grey,
                          height: height * 0.11,
                          child: TextFormField(
                            controller: _modelController,
                            keyboardType: TextInputType.phone,
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Model is required"),
                            ]),
                            decoration: InputDecoration(
                              fillColor: backgroundColor,
                              filled: backgroundfill,

                              //  focusColor: Colors.grey,
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: iconColor, width: 2)),
                              labelText: "Model",
                              labelStyle: _textStyleBlueTheme,
                              hintText: "model",
                            ),
                          ),
                        ),
                      ),
                    ),

                    ///================= Color ===================\\\
                    ///
                    Padding(
                      padding: EdgeInsets.only(top: 0, left: 28, right: 28),
                      child: AnimatedContainer(
                        curve: Curves.bounceOut,
                        duration: Duration(seconds: 3),
                        width: textOpacity == false
                            ? 0
                            : MediaQuery.of(context).size.width,
                        child: Container(
                          //   color: Colors.grey,
                          height: height * 0.11,
                          child: TextFormField(
                            controller: _colorController,
                            keyboardType: TextInputType.text,
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Color is required"),
                            ]),
                            decoration: InputDecoration(
                              fillColor: backgroundColor,
                              filled: backgroundfill,

                              //   fillColor: Colors.grey,
                              focusColor: Colors.grey,
                              //   enabledBorder: OutlineInputBorder(
                              //     borderSide:
                              //         BorderSide(color: Colors.grey, width: 2),
                              //    ),
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: iconColor, width: 2)),
                              labelText: "Color",
                              labelStyle: _textStyleBlueTheme,
                              hintText: "color",
                            ),
                          ),
                        ),
                      ),
                    ),

                    ///================= Number Plate ===================\\\
                    ///
                    Padding(
                      padding: EdgeInsets.only(top: 0, left: 28, right: 28),
                      child: AnimatedContainer(
                        curve: Curves.bounceOut,
                        duration: Duration(seconds: 3),
                        width: textOpacity == false
                            ? 0
                            : MediaQuery.of(context).size.width,
                        child: Container(
                          //   color: Colors.grey,
                          height: height * 0.11,
                          child: TextFormField(
                            controller: _numberPlateControllr,
                            keyboardType: TextInputType.visiblePassword,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "Number Plate is Required"),
                            ]),
                            decoration: InputDecoration(
                              fillColor: backgroundColor,
                              filled: backgroundfill,
                              //   focusColor: Colors.grey.withOpacity(0.3),
                              //  focusColor: Colors.grey,
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: iconColor, width: 2)),
                              labelText: "Number Plate",
                              labelStyle: _textStyleBlueTheme,
                              hintText: "number plate",
                            ),
                          ),
                        ),
                      ),
                    ),

                    ///================= No of Passenger ===================\\\
                    ///
                    Padding(
                      padding: EdgeInsets.only(top: 0, left: 28, right: 28),
                      child: AnimatedContainer(
                        curve: Curves.bounceOut,
                        duration: Duration(seconds: 3),
                        width: textOpacity == false
                            ? 0
                            : MediaQuery.of(context).size.width,
                        child: Container(
                          //   color: Colors.grey,
                          height: height * 0.11,
                          child: TextFormField(
                            controller: _noOfPassengerController,
                            keyboardType: TextInputType.phone,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "Passenger no is Required"),
                            ]),
                            decoration: InputDecoration(
                              fillColor: backgroundColor,
                              filled: backgroundfill,
                              //  focusColor: Colors.grey,
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: iconColor, width: 2)),
                              labelText: "Passenger NO",
                              labelStyle: _textStyleBlueTheme,
                              hintText: "passenger no",
                            ),
                          ),
                        ),
                      ),
                    ),

                    ///
                    /// ================= Button Next ================== \\\
                    ///
                    Padding(
                      padding: EdgeInsets.only(
                          top: height * 0.02,
                          left: 28,
                          right: 28,
                          bottom: height * 0.03),
                      child: AnimatedContainer(
                        curve: Curves.bounceOut,
                        duration: Duration(seconds: 3),
                        width: textOpacity == false
                            ? 0
                            : MediaQuery.of(context).size.width,
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.blue,
                                    Colors.lightBlue,
                                    Colors.blue,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.8),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                ),
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          height: 45,
                          width: width * 0.84,
                          child: FlatButton(
                            onPressed: () async {
                              if (formKey.currentState.validate()) {
                                Uuid uuid = Uuid();
                                var id = uuid.v4();
                                DriverVehicleInfo model = DriverVehicleInfo(
                                  brand: _brandController.text,
                                  color: _colorController.text,
                                  model: _modelController.text,
                                  str1: DriverConst.str1,
                                  str2: DriverConst.str2,
                                  str3: DriverConst.str3,
                                  uUID: id,
                                  vehicleNumber: _numberPlateControllr.text,
                                  vehicleTypeId: selectedVehicleTypeId,
                                );
                                ApiServices _api = ApiServices();
                                PsResource<DriverVehicleInfoResponse>
                                    _resource =
                                    await _api.driverInsertVehicleInfo(
                                        model.toMap(model));

                                print(
                                    " ................Response .........${_resource.data.status}");

                                if (_resource.data.status ==
                                    "Vehicle Inserted Successfully") {
                                  BlocProvider.of<
                                              DriverinitialrequirementsBloc>(
                                          context)
                                      .add(InsertModel(map: <String, dynamic>{
                                    "PhoneNumber": "${widget.phoneNo}",
                                    "Password": "${widget.password}",
                                  }));
                                } else {
                                  print("Vehicle does not Insert");
                                }
                              } else {
                                print("Validate Form Fields");
                              }
                            },
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 21,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    ));
  }
}
