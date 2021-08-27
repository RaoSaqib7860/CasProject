import 'dart:io';

import 'package:get_smart_ride_cas/api/common/ps_api.dart';
import 'package:get_smart_ride_cas/api/common/ps_resource.dart';
import 'package:get_smart_ride_cas/api/rider_api/rider_api.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_all_riding_list.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_penalty.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_vehicle_type_res.dart';
import 'package:get_smart_ride_cas/rider/objects/ApiResponse.dart';
import 'package:get_smart_ride_cas/rider/objects/GetDistanceCostVechicleVise.dart';
import 'package:get_smart_ride_cas/rider/objects/otp_response.dart';
import 'package:get_smart_ride_cas/rider/screens/riderImageUpload.dart';

import '../upload_image.dart';

class RiderApiServices extends PsApi {
  //=================== Insert Rider Email =================\\

  Future<PsResource<ApiResponse>> insertRiderEmail(
      Map<dynamic, dynamic> jsonMap) async {
    String url = "${RiderApi.insertRiderEmail}";
    return await postData<ApiResponse, ApiResponse>(
        ApiResponse(), url, jsonMap);
  }

  Future<PsResource<Otp_Response>> insertRider(
      Map<dynamic, dynamic> jsonMap) async {
    String url = "${RiderApi.insertRiderEmail}";
    return await postData<Otp_Response, Otp_Response>(
        Otp_Response(), url, jsonMap);
  }
  //=================== Insert Rider Phone Number =================\\

  Future<PsResource<ApiResponse>> insertRiderPhoneNumber(
      Map<dynamic, dynamic> jsonMap) async {
    String url = "${RiderApi.insertRidingClientPhoeNumber}";
    return await postData<ApiResponse, ApiResponse>(
        ApiResponse(), url, jsonMap);
  }

  //=================== SignUp Rider =================\\

  Future<PsResource<ApiResponse>> signUpRider(
      Map<dynamic, dynamic> jsonMap) async {
    String url = "${RiderApi.insertRider}";
    return await postData<ApiResponse, ApiResponse>(
        ApiResponse(), url, jsonMap);
  }

  Future<RiderImageUploadResponse> signUpRiderForOtp(
    String email,
    String name,
    String ridingClientNDId,
    String uUID,
    int gender,
    String ridingClientPhoneNo,
    String imageFile,
  ) async {
    String url = "${RiderApi.insertRider}";
    return await postRidingClientImage(url, email, name, ridingClientNDId, uUID,
        gender, ridingClientPhoneNo, imageFile);
  }
  //=================== SignUp Rider =================\\

  Future<PsResource<ApiResponse>> getCityID(
      Map<dynamic, dynamic> jsonMap) async {
    String url = "${RiderApi.getCityId}";
    return await postData<ApiResponse, ApiResponse>(
        ApiResponse(), url, jsonMap);
  }

  //=================== Rider GetVehicle List=================\\

  Future<PsResource<List<DriverVehicleTypeResponse>>> driverVehicleType(
      Map<dynamic, dynamic> jsonMap) async {
    String url = "${RiderApi.getVehicleType}";
    return await postData<DriverVehicleTypeResponse,
            List<DriverVehicleTypeResponse>>(
        DriverVehicleTypeResponse(), url, jsonMap);
  }

//=================== Rider get Distance Cost Vehicle Vise =================\\

  Future<PsResource<List<DistanceCostVehicleVise>>> getDistanceCostVehicleVise(
      Map<dynamic, dynamic> jsonMap) async {
    String url = "${RiderApi.getDistanceCostVehicleVise}";
    return await postData<DistanceCostVehicleVise,
        List<DistanceCostVehicleVise>>(DistanceCostVehicleVise(), url, jsonMap);
  }

  //=================== Rider All Riding Request =================\\
  //
  Future<PsResource<List<DriverAllRidingRequest>>> getDriverAllRidingList(
      Map<dynamic, dynamic> jsonMap) async {
    String url = "${RiderApi.getAllRidingListForRider}";
    return await postData<DriverAllRidingRequest, List<DriverAllRidingRequest>>(
        DriverAllRidingRequest(), url, jsonMap);
  }

  //=================== Driver Penalty =================\\
  //
  Future<PsResource<DriverPenalty>> getDriverPenalty(
      Map<dynamic, dynamic> jsonMap) async {
    String url = "${RiderApi.getPenaltyForRider}";
    return await postData<DriverPenalty, DriverPenalty>(
        DriverPenalty(), url, jsonMap);
  }

  //=================== Driver Image Upload =================\\
  //
  Future<RiderImageUploadResponse> riderImageUpload(
      String email, File image) async {
    String url = "${RiderApi.riderImageUpload}";
    return await postRiderImage(url, email, image);
  }

  //=================== Login client phoneno after OTP =================\\
  //
  Future<PsResource<Otp_Response>> loginClientPhoneNoAfterOTPVerify(
      Map<dynamic, dynamic> jsonMap) async {
    String url = "${RiderApi.loginClientPhoneNo}";
    return await postData<Otp_Response, Otp_Response>(
        Otp_Response(), url, jsonMap);
  }
}
