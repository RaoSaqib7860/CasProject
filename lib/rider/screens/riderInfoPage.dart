import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_smart_ride_cas/Commons/commons.dart';
import 'package:get_smart_ride_cas/Commons/constant.dart';
import 'package:get_smart_ride_cas/Commons/shared_preferences.dart';
import 'package:get_smart_ride_cas/api/common/ps_resource.dart';
import 'package:get_smart_ride_cas/api/rider_api/rider_api_services.dart';
import 'package:get_smart_ride_cas/app/theme/colors.dart';
import 'package:get_smart_ride_cas/rider/home/rider_home_screen.dart';
import 'package:get_smart_ride_cas/rider/objects/ApiResponse.dart';
import 'package:get_smart_ride_cas/rider/objects/insertion_of_riding_client.dart';
import 'package:get_smart_ride_cas/rider/screens/signup_screen.dart';
import 'package:get_smart_ride_cas/widgets/flush_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class RiderInfo extends StatefulWidget {
  final String userEmail;
  int groupValueRadioButton;
  final String userName;
  final String image;
  static String riderEmail;
  final String phoneNoController;
  // final String radioValue;
  int radioValue;
  RiderInfo(
      {Key key,
      this.userEmail,
      this.userName,
      this.image,
      this.radioValue,
      this.phoneNoController,
      this.groupValueRadioButton})
      : super(key: key);

  @override
  _RiderInfoState createState() => _RiderInfoState();
}

class _RiderInfoState extends State<RiderInfo> {
  int _groupValue = 1;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // if (widget.userName != null) {
    //   RiderInfo.riderEmail = widget.userEmail;
    // }
    print("PHONE NO............${widget.phoneNoController}");
    print("RIDER EMAIL COOMONS............${Commons.riderEmail}");
    print("NAME RIDERR COOMONS............${Commons.userName}");
    print("RIDER IMAGE COOMONS............${Commons.image}");
    print("RIDER NAME google............${googleUserName}");
    print("RIDER NAME google............$googleUserImage");
    print("RIDER EMAIL google............$googleEmail");
    super.initState();

    //method
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          //  crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.08,
            ),
            Text(
              "Rider info",
              style: GoogleFonts.mina(fontSize: 20),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 8,
              child: Container(
                width: width * 0.35,
                height: height * 0.18,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: Theme.of(context).accentColor, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                  image: DecorationImage(
                      image: NetworkImage("$googleUserImage"),
                      fit: BoxFit.cover),
                ),
                // child: Align(
                //     alignment: Alignment.bottomRight,
                //     child: InkWell(
                //       onTap: () async {},
                //       child: Icon(Icons.image, color: Colors.white),
                //     )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 18.0, left: 18, right: 18, bottom: 10),
              child: Container(
                width: width * 0.9,
                height: height * 0.09,
                decoration: BoxDecoration(
                    //color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1, color: Colors.grey)),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(
                        Icons.person,
                        color: AppColors.mainColor,
                      ),
                    ),
                    Text(googleUserName)
                    // widget.userName != null
                    //     ? Text(widget.userName)
                    //     : Text("user name")
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 18.0, left: 18, right: 18, bottom: 10),
              child: Container(
                width: width * 0.9,
                height: height * 0.09,
                decoration: BoxDecoration(
                    //color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1, color: Colors.grey)),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(
                        Icons.email,
                        color: AppColors.mainColor,
                      ),
                    ),
                    Text(googleEmail)
                    // widget.userEmail != null
                    //     ? Text(widget.userEmail)
                    //     : Text("user email")
                  ],
                ),
              ),
            ),
            _myRadioButton(
              title: "female",
              color: AppColors.mainColor,
              value: 0,
              onChanged: (newValue) => setState(() => _groupValue = newValue),
            ),
            _myRadioButton(
              title: "male",
              value: 1,
              onChanged: (newValue) => setState(() => _groupValue = newValue),
            ),
            InkWell(
              onTap: () async {
                loginByGmail = true;
                Uuid uuid = Uuid();
                var id = uuid.v4();
                RiderApiServices api = RiderApiServices();
                InsertRidingClientModel model = InsertRidingClientModel(
                  ridingClientEmail: googleEmail,
                  ridingClientImage: googleUserImage,
                  ridingClientNDId: id,
                  ridingClientName: googleUserName,
                  uUID: id,
                  gender: _groupValue,
                  ridingClientPhoneNo: widget.phoneNoController,
                );

                PsResource<ApiResponse> _resource = await api
                    .signUpRider(InsertRidingClientModel().toMap(model));
                if (_resource.data.status ==
                    "Riding Client Inserted Successfully") {
                  RiderUser user = RiderUser(
                      email: googleEmail,
                      id: id,
                      image: googleUserImage,
                      username: googleUserName);
                  setDataToSharedPreferances(user);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return _groupValue != null
                        ? RiderHomeScreen()
                        : FlushBar.showSimpleFlushBar("Select gender value",
                            context, Colors.red, Colors.white);
                  }));
                } else if (_resource.data.status ==
                    'Phone Number Already Exists') {
                  FlushBar.showSimpleFlushBar(
                      "The phone no you entered is already registered for another account", // ya status show hota ha///haan
                      context,
                      Colors.red,
                      Colors.white);
                } else if (_resource.data.status == "Email Already Exists") {
                  // setState(() {
                  //   fetchData = false;
                  // });
                  FlushBar.showSimpleFlushBar(
                      "Email Already Exists", // ya status show hota ha///haan
                      context,
                      Colors.pink,
                      Colors.white);
                } else if (_resource.data.status ==
                    "Riding Client Insertion Failed") {
                  // setState(() {
                  //   fetchData = false;
                  // });
                  FlushBar.showSimpleFlushBar(
                      "Insertion failed", context, Colors.pink, Colors.white);
                } else {
                  //  Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) =>
                  //           EnterPhoneNumber(
                  //         user: user,
                  //      ),
                  //     )); 
                } 
              },
              child: Container(
                width: width * 0.8,
                height: height * 0.07,
                decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                    child: Text(
                  "Done",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
              ),
            )
          ],
        ),
      ),
    );
    // );
  }

  Widget _myRadioButton(
      {String title, int value, Function onChanged, Color color}) {
    return RadioListTile(
      value: value,
      activeColor: color,
      groupValue: _groupValue,
      onChanged: onChanged,
      title: Text(title),
    );
  }

  Future<void> setDataToSharedPreferances(RiderUser user) async {
    Commons.riderEmail = user.email;
    Commons.image = user.image;
    Commons.userName = user.username;
    print("--------------- Shared Preferrences ---------- ${user.email}");
    SharedPreferencesData.sharedPreferencesModel =
        await SharedPreferences.getInstance();
    SharedPreferencesData.sharedPreferencesModel
        .setString(Const.RIDER_EMAIL, user.email);
    SharedPreferencesData.sharedPreferencesModel
        .setString(Const.RiderUserName, user.username);
    SharedPreferencesData.sharedPreferencesModel
        .setString(Const.Riderimage, user.image);
  }
}
