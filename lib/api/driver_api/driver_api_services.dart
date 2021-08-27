import 'dart:io';

import 'package:get_smart_ride_cas/api/common/ps_api.dart';
import 'package:get_smart_ride_cas/api/common/ps_resource.dart';
import 'package:get_smart_ride_cas/api/driver_api/driver_api.dart';
import 'package:get_smart_ride_cas/api/upload_image.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_Otp_response.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_all_riding_list.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_cnic_upload_res.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_image_upload_res.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_login_reponse.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_penalty.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_profile.dart';

import 'package:get_smart_ride_cas/driver/view_object/driver_signup_res.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_vehicle_info_res.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_vehicle_type_res.dart';
import 'package:get_smart_ride_cas/driver/view_object/driving_licence_res.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_franchise.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_ride_bill.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_today_earnings.dart';
import 'package:get_smart_ride_cas/rider/objects/ApiResponse.dart';

class ApiServices extends PsApi {
  //=================== Driver Login =================\\
  //
  Future<PsResource<DriverLoginResponse>> driverLogin(
      Map<dynamic, dynamic> jsonMap) async {
    String url = "${DriverApi.driverLogin}";
    return await postData<DriverLoginResponse, DriverLoginResponse>(
        DriverLoginResponse(), url, jsonMap);
  }

  //=================== Driver SignUp =================\\
  //
  Future<PsResource<DriverSignUpResponse>> driverSignUP(
      Map<dynamic, dynamic> jsonMap) async {
    String url = "${DriverApi.driverSignUP}";
    return await postData<DriverSignUpResponse, DriverSignUpResponse>(
        DriverSignUpResponse(), url, jsonMap);
  }

  //=================== Driver Cnic Upload =================\\
  //
  Future<DriverCnicUploadResponse> driverCnicUpload(
      String str1, String str2, String str3, String str4, File image) async {
    String url = "${DriverApi.driverCNICUpload}";
    return await postDriverCNICImage(url, str1, str2, str3, str4, image);
  }

  //=================== Driver License Upload =================\\
  //
  Future<DrivingLicenceResponse> drivingLicenceUpload(
      String str1, String str2, String str3, String str4, File image) async {
    String url = "${DriverApi.drivingLicenceUpload}";
    return await postDrivingLicenceImage(url, str1, str2, str3, str4, image);
  }

  //=================== Driver Image Upload =================\\
  //
  Future<DriverImageUploadResponse> driverImageUpload(
      String str1, String str2, String str3, String str4, File image) async {
    String url = "${DriverApi.driverImageUpload}";
    return await postDriverImage(url, str1, str2, str3, str4, image);
  }

  //=================== Driver Get Vehicle Type =================\\
  //
  Future<PsResource<List<DriverVehicleTypeResponse>>> driverVehicleType(
      Map<dynamic, dynamic> jsonMap) async {
    String url = "${DriverApi.driverVehicleType}";
    return await postData<DriverVehicleTypeResponse,
            List<DriverVehicleTypeResponse>>(
        DriverVehicleTypeResponse(), url, jsonMap);
  }

  //=================== DriverInsertVehicleInfo=================\\
  //
  Future<PsResource<DriverVehicleInfoResponse>> driverInsertVehicleInfo(
      Map<dynamic, dynamic> jsonMap) async {
    String url = "${DriverApi.driverVehicleInfo}";
    return await postData<DriverVehicleInfoResponse, DriverVehicleInfoResponse>(
        DriverVehicleInfoResponse(), url, jsonMap);
  }

//=================== Driver Latest Booking Request =================\\
//
  // Future<PsResource<DriverRidingRequestById>> getDriverLatestRequestById(
  //     Map<dynamic, dynamic> jsonMap) async {
  //   String url = "${DriverApi.driverLatestBookingRequestById}";
  //   return await postData<DriverRidingRequestById, DriverRidingRequestById>(
  //       DriverRidingRequestById(), url, jsonMap);
  // }

  //=================== Driver All Riding Request =================\\
  //
  Future<PsResource<List<DriverAllRidingRequest>>> getDriverAllRidingList(
      Map<dynamic, dynamic> jsonMap) async {
    String url = "${DriverApi.getAllRidingRequestsForDriver}";
    return await postData<DriverAllRidingRequest, List<DriverAllRidingRequest>>(
        DriverAllRidingRequest(), url, jsonMap);
  }

  //=================== Driver Penalty =================\\
  //
  Future<PsResource<List<DriverPenalty>>> getDriverPenalty(
      Map<dynamic, dynamic> jsonMap) async {
    String url = "${DriverApi.getPenaltyTimeAndAmountForDriver}";
    return await postData<DriverPenalty, List<DriverPenalty>>(
        DriverPenalty(), url, jsonMap);
  }

  //=================== Driver Franchise Data =================\\
  //
  Future<PsResource<List<DriverFranchiseResponse>>> getDriverFranchise(
      Map<dynamic, dynamic> jsonMap) async {
    String url = "${DriverApi.getFranschiseData}";
    return await postData<DriverFranchiseResponse,
        List<DriverFranchiseResponse>>(DriverFranchiseResponse(), url, jsonMap);
  }

  //=================== Driver Ride Bill =================\\
  //
  Future<PsResource<List<DriverRideBill>>> getDriverRideBill(
      Map<dynamic, dynamic> jsonMap) async {
    String url = "${DriverApi.getDriverRideBill}";
    return await postData<DriverRideBill, List<DriverRideBill>>(
        DriverRideBill(), url, jsonMap);
  }

  //=================== Driver Today Earning =================\\
  //
  Future<PsResource<List<DriverTodayEarning>>> getDriverTodayEarning(
      Map<dynamic, dynamic> jsonMap) async {
    String url = "${DriverApi.getDriverTodayEarning}";
    return await postData<DriverTodayEarning, List<DriverTodayEarning>>(
        DriverTodayEarning(), url, jsonMap);
  }

  //=================== Driver  From To  Earning =================\\
  //
  Future<PsResource<List<DriverTodayEarning>>> getDriverFromToTotalEarning(
      Map<dynamic, dynamic> jsonMap) async {
    String url = "${DriverApi.getDriverFromToDayEarning}";
    return await postData<DriverTodayEarning, List<DriverTodayEarning>>(
        DriverTodayEarning(), url, jsonMap);
  }

// asa krna da phr dekhya ga isa\\
  //=================== Driver Profile =================\\
  //
  Future<PsResource<List<DriverProfileModel>>> getDriverProfileData(
      Map<dynamic, dynamic> jsonMap) async {
    String url = "${DriverApi.getDriverProfile}";
    return await postData<DriverProfileModel, List<DriverProfileModel>>(
        DriverProfileModel(), url, jsonMap);
  }

  //=================== Driver Profile Update =================\\
  //
  Future<PsResource<ApiResponse>> updateDriverProfileData(
      Map<dynamic, dynamic> jsonMap) async {
    String url = "${DriverApi.updateDriverProfile}";
    return await postData<ApiResponse, ApiResponse>(
        ApiResponse(), url, jsonMap);
  }
  //=================== Login Driver phoneno after OTP =================\\

  //
  Future<PsResource<DriverOtpResponse>> loginClientPhoneNoAfterOTPVerify(
      Map<dynamic, dynamic> jsonMap) async {
    String url = "${DriverApi.driverLoginWithMobileAfterOTPVerify}";
    return await postData<DriverOtpResponse, DriverOtpResponse>(
        DriverOtpResponse(), url, jsonMap);
  }
}
