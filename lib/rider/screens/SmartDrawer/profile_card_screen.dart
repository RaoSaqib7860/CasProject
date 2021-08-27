import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get_smart_ride_cas/Commons/commons.dart';
import 'package:get_smart_ride_cas/Commons/constant.dart';
import 'package:get_smart_ride_cas/Commons/shared_preferences.dart';
import 'package:get_smart_ride_cas/api/common/ps_resource.dart';
import 'package:get_smart_ride_cas/api/driver_api/driver_api_services.dart';
import 'package:get_smart_ride_cas/api/rider_api/rider_api.dart';
import 'package:get_smart_ride_cas/api/rider_api/rider_api_services.dart';
import 'package:get_smart_ride_cas/app/theme/colors.dart';
import 'package:get_smart_ride_cas/app/theme/textStyles.dart';
import 'package:get_smart_ride_cas/rider/home/rider_home_screen.dart';
import 'package:get_smart_ride_cas/rider/objects/ApiResponse.dart';
import 'package:get_smart_ride_cas/rider/objects/insert_email_request.dart';
import 'package:get_smart_ride_cas/rider/objects/otp_response.dart';
import 'package:get_smart_ride_cas/rider/objects/ridingClientPhoneNumberForOtp.dart';
import 'package:get_smart_ride_cas/utils/utils.dart';
import 'package:get_smart_ride_cas/widgets/flush_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../riderImageUpload.dart';
import '../signup_screen.dart';

class ProfileCard extends StatefulWidget {
  final String riderImage;

  final String riderName;
  final String firstName;
  final String lastName;
  final File imageForOtp;
  final String riderPhoneNo;
  final String riderEmail;
  const ProfileCard(
      {Key key,
      this.riderImage,
      this.riderEmail,
      this.firstName,
      this.lastName,
      this.riderName,
      this.riderPhoneNo,
      this.imageForOtp})
      : super(key: key);
  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  bool showPassword = false;
  File image;

  // bool isLoading;
  final picker = ImagePicker();
  @override
  void initState() {
    // if (image != null) {
    //   image = Commons.image;
    // }
    print("image in profile card is..........${Commons.image}");
    print("GOOGLE image in profile card is..........$googleUserImage");
    print("phoe...............${widget.riderPhoneNo}");
    //  String email = gooogleSignIn.currentUser.email;
    //   InsertEmailRequest model = InsertEmailRequest(ridingClientEmail: email);
    // postEmail(model).then((value) {
    //   print("........ status ........${value.status}");

    //   print("........ ID ........${value.id}");
    // });

    // //  var uuid = Uuid();
    // InsertionOfRidingClientModel model2 = InsertionOfRidingClientModel(
    //   ridingClientEmail: gooogleSignIn.currentUser.email,
    //   ridingClientName: gooogleSignIn.currentUser.displayName,
    //   ridingClientImage: gooogleSignIn.currentUser.photoUrl,
    //   ridingClientNDId: gooogleSignIn.currentUser.id,
    //   uUID: Uuid().v4(),
    // );

    // newInsertionEmail(model2).then((value) {
    //   print("........ status2 ........${value.status}");

    //   print("........ ID2 ........${value.id}");
    // });
    super.initState();
  }

  Future getImage() async {
    //
    print(" I M A G E...........  ");
    //isLoading = true;
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        // isLoading = false;
        image = File(pickedFile.path);
        print(" I M A G E...........  ${image.path}");
        return image;
      } else {
        print("NO IMAGE SELECTED");

        //  return;
        //   ab check kra ab hwi hai change
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return LayoutBuilder(
      builder: (context, constraints) => Container(
        height: constraints.maxHeight,
        width: constraints.maxWidth,
        color: AppColors.greyColor.withOpacity(0.5),
        child: FadeInLeft(
          animate: true,
          child: Card(
            color: AppColors.secondMainColor.withOpacity(0.5),
            margin: const EdgeInsets.only(
                left: 80, bottom: 135, top: 140, right: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
            child: Center(
              child: Column(
                children: [
                  Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return RiderHomeScreen();
                            }));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Icon(Icons.arrow_back,
                                color: AppColors.mainColor),
                          )),
                      SizedBox(
                        width: width * 0.1,
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
                          width: constraints.maxWidth * 0.35,
                          child: Center(
                            child: Text(
                              'Profile',
                              style: AppTextStyles.description1
                                  .copyWith(color: AppColors.whiteColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: constraints.maxHeight * 0.01,
                          ),
                          // CircleAvatar(
                          //   backgroundColor: AppColors.mainColor,
                          //   radius: 40,
                          //   backgroundImage: Commons.image != null
                          //       ? NetworkImage(Commons.image)
                          //       : AssetImage("images/profile_vector.jpg"),
                          //   child: Align(
                          //       alignment: Alignment.bottomRight,
                          //       child: Icon(Icons.image, color: Colors.white)),
                          //   // gooogleSignIn.currentUser.photoUrl
                          // ),

                          Card(
                            child: Container(
                              width: width * 0.24,
                              height: height * 0.13,
                              //   backgroundColor: AppColors.mainColor,
                              //  radius: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Theme.of(context).accentColor,
                                      width: 2),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                    ),
                                  ],
                                  //   shape: BoxShape.circle,
                                  image:
                                      // widget.riderImage != null
                                      //     ? DecorationImage(
                                      //         //  image:image==null && Commons.image != null?? NetworkImage(Commons.image):
                                      //         image: NetworkImage(
                                      //             "${RiderApi.baseUrl}${widget.riderImage}"),
                                      //         fit: BoxFit.fill)
                                      //     :
                                      DecorationImage(
                                          //  image:image==null && Commons.image != null?? NetworkImage(Commons.image):
                                          image: image != null
                                              ? FileImage(image)
                                              : (Commons.image != null)
                                                  ? NetworkImage(
                                                      "${Commons.image}")
                                                  : NetworkImage(
                                                      "https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png"),
                                          // : NetworkImage(
                                          //     "https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png"),
                                          // : SignupScreen
                                          //             .onOtpLoginForRider ==
                                          //         true
                                          //     ? NetworkImage(
                                          //         "${RiderApi.baseUrl}${Commons.image}")
                                          //     : NetworkImage(
                                          //         "https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png"),
                                          fit: BoxFit.fill)),
                              child: InkWell(
                                onTap: () async {
                                  //   isLoading = true;
                                  print("ON TAPPPPPP......//////////");
                                  await getImage();
                                  if (image != null) {
                                    print(
                                        "=========Image updaete method is Call =====");
                                    print(
                                        "Image is not null ===================${image.path}");
                                    RiderApiServices api = RiderApiServices();
                                    Utils.checkInternetConnectivity()
                                        .then((value) async {
                                      if (value == true) {
                                        RiderImageUploadResponse _resource =
                                            await api.riderImageUpload(
                                                Commons.riderEmail == null
                                                    ? widget.riderPhoneNo
                                                    : Commons.riderEmail,
                                                image);
                                        print(
                                            " Response from server${_resource.status}");

                                        if (_resource.status ==
                                            "File Uploaded Successfully") {
                                          if (widget.riderPhoneNo != null) {
                                            RiderApiServices api =
                                                RiderApiServices();
                                            Uuid uuid = Uuid();
                                            var id = uuid.v4();
                                            InsertRidingPhoneNoForOtp model =
                                                InsertRidingPhoneNoForOtp(
                                              uUID: id,
                                              ridingClientPhoneNo:
                                                  widget.riderPhoneNo,
                                            );
                                            PsResource<Otp_Response> _resource =
                                                await api
                                                    .loginClientPhoneNoAfterOTPVerify(
                                                        InsertRidingPhoneNoForOtp()
                                                            .toMap(model));

                                            var imagee = _resource.data.image;
                                            var name = _resource.data.name;
                                            var phoneNo =
                                                _resource.data.phoneNo;

                                            print("image.........$imagee");
                                            print(
                                                "image with url...........//////////////////////////////////////////////////////////////////////////////////////////////////....... ${RiderApi.baseUrl + imagee}");
                                            RiderUser user = RiderUser(
                                                //id: id,
                                                image:
                                                    "${RiderApi.baseUrl + imagee}",
                                                username: name,
                                                //     email: email,
                                                phoneNo: phoneNo);
                                            setDataToSharedPreferances(user);
                                          } else {
                                            RiderInsertEmailRequest model =
                                                RiderInsertEmailRequest(
                                                    ridingClientEmail:
                                                        Commons.riderEmail);
                                            RiderApiServices api =
                                                RiderApiServices();

                                            PsResource<Otp_Response> _resource =
                                                await api.insertRider(
                                                    RiderInsertEmailRequest()
                                                        .toMap(model));

                                            print(
                                                "STATUS.....${_resource.data.status}");
                                            print("MODEL.....$model");
                                            var imagee = _resource.data.image;
                                            var name = _resource.data.name;
                                            var email = _resource.data.email;

                                            print("image.........$imagee");
                                            print(
                                                "image with url during google sign in...........//////////////////////////////////////////////////////////////////////////////////////////////////....... ${RiderApi.baseUrl + imagee}");
                                            RiderUser user = RiderUser(
                                                //id: id,
                                                image:
                                                    "${RiderApi.baseUrl + imagee}",
                                                username: name,
                                                //     email: email,
                                                email: email);
                                            setDataToSharedPreferances(user);
                                          }

                                          FlushBar.showSimpleFlushBar(
                                              "file uploaded successfully",
                                              context,
                                              Colors.green,
                                              Colors.white);
                                          // setState(() {
                                          //   isLoading = false;
                                          //   //    ProfileCard();
                                          // });

                                          //

                                          // check kra isa \\krti
                                        }
                                      }
                                      // else {
                                      //   FlushBar.showSimpleFlushBar(
                                      //       "check connection",
                                      //       context,
                                      //       Colors.red,
                                      //       Colors.white);
                                      // }
                                    });
                                  }
                                  //  else {
                                  //   FlushBar.showSimpleFlushBar("Select Image",
                                  //       context, Colors.red, Colors.white);
                                  // }
                                },
                                child: Stack(
                                  children: [
                                    Align(
                                        alignment: Alignment.bottomRight,
                                        child: Icon(Icons.image,
                                            color: Colors.white)),
                                    // isLoading == true
                                    //     ? Center(
                                    //         child: CircularProgressIndicator())
                                    //     : Container()
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: constraints.maxHeight * 0.04,
                          ),
                          // Padding(
                          //   padding:
                          //       const EdgeInsets.symmetric(horizontal: 10.0),
                          //   child: ClipRRect(
                          //     borderRadius: BorderRadius.circular(15),
                          //     child: ListTile(
                          //       tileColor: AppColors.whiteColor,
                          //       dense: false,
                          //       leading: Icon(
                          //         Icons.person,
                          //         color: AppColors.mainColor,
                          //       ),
                          //       // leading: CircleAvatar(
                          //       //   backgroundColor: AppColors.mainColor,
                          //       //   //  radius: 35,
                          //       //   backgroundImage: Commons.image != null
                          //       //       ? NetworkImage(Commons.image)
                          //       //       : AssetImage("images/profile_vector.jpg"),
                          //       //   // gooogleSignIn.currentUser.photoUrl
                          //       // ),
                          //       title: Text(
                          //         widget.riderName == null
                          //             ? Commons.userName
                          //             : widget
                          //                 .riderName, // gooogleSignIn.currentUser.displayName,
                          //         style: AppTextStyles.description1
                          //             .copyWith(fontSize: 14),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            height: 5,
                          ),

                          Divider(),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: ListTile(
                                tileColor: AppColors.whiteColor,
                                dense: true,
                                leading: Icon(
                                  Icons.person,
                                  color: AppColors.mainColor,
                                ),
                                title: Text(
                                  widget.riderName == null
                                      ? Commons.userName
                                      : widget.riderName,
                                  // gooogleSignIn.currentUser.email,

                                  style: AppTextStyles.description1
                                      .copyWith(fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Commons.riderEmail != null
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: ListTile(
                                      tileColor: AppColors.whiteColor,
                                      dense: true,
                                      leading: Icon(
                                        Icons.email,
                                        color: AppColors.mainColor,
                                      ),
                                      title: Text(
                                        Commons.riderEmail,
                                        style: AppTextStyles.description1
                                            .copyWith(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: ListTile(
                                      tileColor: AppColors.whiteColor,
                                      dense: true,
                                      leading: Icon(
                                        Icons.phone,
                                        color: AppColors.mainColor,
                                      ),
                                      title: Text(
                                        Commons.riderPhoneNO,
                                        style: AppTextStyles.description1
                                            .copyWith(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),
                          // Align(
                          //   alignment: Alignment.bottomCenter,
                          //   child: Card(
                          //     color: AppColors.whiteColor,
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(5),
                          //     ),
                          //     elevation: 5,
                          //     clipBehavior: Clip.antiAliasWithSaveLayer,
                          //     child: SizedBox(
                          //       height: constraints.maxHeight * 0.045,
                          //       width: constraints.maxWidth * 0.2,
                          //       child: Center(
                          //         child: Text(
                          //           'Edit',
                          //           style: AppTextStyles.description1,
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> setDataToSharedPreferances(RiderUser user) async {
    Commons.riderEmail = user.email;
    Commons.image = user.image;
    Commons.userName = user.username;
    Commons.riderPhoneNO = user.phoneNo;
    print("--------------- Shared Preferrences ---------- $user.email");
    SharedPreferencesData.sharedPreferencesModel =
        await SharedPreferences.getInstance();
    SharedPreferencesData.sharedPreferencesModel.clear();
    SharedPreferencesData.sharedPreferencesModel
        .setString(Const.RIDER_EMAIL, user.email);
    SharedPreferencesData.sharedPreferencesModel
        .setString(Const.RiderUserName, user.username);
    SharedPreferencesData.sharedPreferencesModel
        .setString(Const.Riderimage, user.image);
    SharedPreferencesData.sharedPreferencesModel
        .setString(Const.RIDER_PHONE_NO, user.phoneNo);
  }
}
