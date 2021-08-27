import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_smart_ride_cas/api/common/ps_resource.dart';
import 'package:get_smart_ride_cas/api/driver_api/driver_api.dart';
import 'package:get_smart_ride_cas/driver/constant/ps_constants.dart';
import 'package:get_smart_ride_cas/driver/home/screens/driver_dashboard.dart';
import 'package:get_smart_ride_cas/driver/home/screens/driver_profile.dart';
import 'package:get_smart_ride_cas/driver/home/screens/login_page.dart';

import 'package:get_smart_ride_cas/driver/home/screens/driver_franchise.dart';
import 'package:get_smart_ride_cas/Commons/constant.dart';
import 'package:get_smart_ride_cas/driver/repository/driver_profile/bloc/driverprofile_bloc.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_profile.dart';
import 'package:get_smart_ride_cas/utils/utils.dart';
import 'package:get_smart_ride_cas/widgets/flush_bar.dart';

import 'package:shared_preferences/shared_preferences.dart';

class MYDrawer extends StatefulWidget {
  final String userType;
  MYDrawer({
    this.userType,
  });
  @override
  _MYDrawerState createState() => _MYDrawerState();
}

class _MYDrawerState extends State<MYDrawer> {
  TextStyle _textStyle = TextStyle(fontSize: 17);

  @override
  void initState() {
    print("STR 1......................${DriverConst.str1}");
    Utils.checkInternetConnectivity().then((value) {
      if (value) {
        BlocProvider.of<DriverprofileBloc>(context).add(DriverProfileSetEvent(
            map: <String, dynamic>{
              'Str1': DriverConst.str1,
              'Str2': DriverConst.str2,
              'Str3': DriverConst.str3
            }));
      } else {
        FlushBar.showSimpleFlushBar(
            "Check Connectivity", context, Colors.red, Colors.white);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Drawer(
      //  elevation: 50,
      child: Container(
        height: height,
        //  color: Colors.white.withOpacity(0.4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.blue,
              //   height: height * 0.26,
              width: width,
              child: Padding(
                padding: EdgeInsets.only(top: height * 0.06),
                child: BlocBuilder<DriverprofileBloc, DriverProfileState>(
                  builder: (context, state) {
                    if (state is DriverProfileInitialState) {
                      return Container(
                        height: height * 0.2,
                        child: Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                        ),
                      );
                    } else if (state is DriverProfileLoadedState) {
                      PsResource<List<DriverProfileModel>> model = state.model;
                      print(
                          "...I M A G E........${DriverApi.baseUrL}${model.data[0].driverImage}");
                      return Column(
                        children: [
                          CircleAvatar(
                            maxRadius: 40,
                            backgroundImage: model.data[0].driverImage != null
                                ? NetworkImage(
                                    "${DriverApi.baseUrL}${model.data[0].driverImage}")
                                : AssetImage(
                                    "images/profile_vector.jpg",
                                  ),
                          ),

                          //blky hori shayed..aik min
                          //ab main aik or register krky login krky dekhti hun.thh ha
                          //panel mai admin sy driver ko kesy krwayein gy verify?
                          // wao ap ko admin pannel ki acess b da di ha hahaha..haan aj mjy link mila tha iska....ab ye wala kia issue tha..data type ka tha?hn..or null koe data type ni
                          Padding(
                            padding: EdgeInsets.only(
                                top: height * 0.01, bottom: height * 0.01),
                            child: AutoSizeText("${model.data[0].name}",
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: height * 0.01, bottom: height * 0.01),
                            child: AutoSizeText(
                              "${model.data[0].email == null ? "how " : model.data[0].email}", //a
                              maxLines: 1,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Container(); //init waly ko comment krky krti hun..
                      //jesy e drawer kholti hun..exception ajati.. thk  ha two min trh jao
                    }
                  },
                ),
              ),
            ),
            //
            //
            Divider(),
            //
            //
            Expanded(
              child: Container(
                height: height,
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      title: Text("Home", style: _textStyle),
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DriverDashboard(),
                            ));
                      },
                    ),

                    ListTile(
                      title: Text("Profile", style: _textStyle),
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DriverProfilePage(),
                            ));
                      },
                    ),

                    // ListTile(
                    //   title: Text(
                    //     "My Records",
                    //     style: TextStyle(color: Colors.black),
                    //   ),
                    // ),

                    ListTile(
                      title: Text(
                        "Franchise",
                        style: _textStyle,
                      ),
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return DriverFranchiseScreen();
                          },
                        ));
                      },
                    ),

                    ListTile(
                      title: Text(
                        "Sign Out",
                        style: _textStyle,
                      ),
                      // leading: Image.asset("images/background12.jpg"),
                      onTap: () {
                        setDataToSharedPreferances();
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                          builder: (context) {
                            return DriverLoginPage();
                          },
                        ), (route) => false);
                      },
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    ListTile(
                      title: Text(
                        "Help and assistance",
                        style: _textStyle,
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text(
                        "Contact US",
                        style: _textStyle,
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> setDataToSharedPreferances() async {
    SharedPreferences model = await SharedPreferences.getInstance();
    model.remove(Const.STR1);
    model.remove(Const.STR2);

    model.remove(Const.STR3);
    model.remove(Const.STR4);
  }
}

/*
 UserAccountsDrawerHeader(
                      
                      accountName: Text("${ProfileResponse.username}"),
                      accountEmail: Text("${ProfileResponse.useremail}"),
                      currentAccountPicture: GestureDetector(
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "${LoginPage.baseUrl + ProfileResponse.imageURL}"),
                        ),
                      ),
                    ),
*/
