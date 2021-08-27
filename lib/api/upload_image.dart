import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_cnic_upload_res.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_image_upload_res.dart';
import 'package:get_smart_ride_cas/driver/view_object/driving_licence_res.dart';
import 'package:get_smart_ride_cas/rider/screens/riderImageUpload.dart';
import 'package:path/path.dart';

Future<DriverCnicUploadResponse> postDriverCNICImage(String url, String str1,
    String str2, String str3, String str4, File imageFile) async {
  print(url);
  try {
    Dio _dio = new Dio();
    FormData formData = FormData.fromMap({
      "Str1": str1,
      "Str2": str2,
      "Str3": str3,
      "ImageFile": await MultipartFile.fromFile(
        imageFile.path,
        filename: basename(imageFile.path),
      ),
    });
    print("...............FormData............. = ${formData.fields}");
    final Response response = await _dio.post(
      url,
      data: formData,
    );
    print(
        " .................... Response Data .....................${response.data}");

    if (response.statusCode == 200) {
      if (response.data != null) {
        DriverCnicUploadResponse model = DriverCnicUploadResponse();

        return model.fromMap(response.data);
      }
    } else {}
  } finally {}
}

Future<DrivingLicenceResponse> postDrivingLicenceImage(String url, String str1,
    String str2, String str3, String str4, File imageFile) async {
  print(url);
  try {
    Dio _dio = new Dio();
    FormData formData = FormData.fromMap({
      "Str1": str1,
      "Str2": str2,
      "Str3": str3,
      "ImageFile": await MultipartFile.fromFile(
        imageFile.path,
        filename: basename(imageFile.path),
      ),
    });
    print("...............FormData............. = ${formData.fields}");
    final Response response = await _dio.post(
      url,
      data: formData,
    );
    print(
        " .................... Response Data .....................${response.data}");

    if (response.statusCode == 200) {
      if (response.data != null) {
        DrivingLicenceResponse model = DrivingLicenceResponse();

        return model.fromMap(response.data);
      }
      DrivingLicenceResponse model = DrivingLicenceResponse();
      return model.fromMap(response.data);
    }
  } catch (e) {
    print(e);
  } finally {}
}

Future<DriverImageUploadResponse> postDriverImage(String url, String str1,
    String str2, String str3, String str4, File imageFile) async {
  print(url);
  try {
    Dio _dio = new Dio();
    FormData formData = FormData.fromMap({
      "Str1": str1,
      "Str2": str2,
      "Str3": str3,
      "RidingClientImage": await MultipartFile.fromFile(
        imageFile.path,
        filename: basename(imageFile.path),
      ),
    });
    print("...............FormData............. = ${formData.fields}");
    final Response response = await _dio.post(
      url,
      data: formData,
    );
    print(
        " .................... Response Data .....................${response.data}");

    if (response.statusCode == 200) {
      if (response.data != null) {
        DriverImageUploadResponse model = DriverImageUploadResponse();

        return model.fromMap(response.data);
      }
      DriverImageUploadResponse model = DriverImageUploadResponse();
      return model.fromMap(response.data);
    } else {}
  } finally {}
}

Future<RiderImageUploadResponse> postRiderImage(
    String url, String email, File imageFile) async {
  print(url);
  try {
    Dio _dio = new Dio();
    FormData formData = FormData.fromMap({
      "RidingClientEmail": email,
      "ImageFile": await MultipartFile.fromFile(
        imageFile.path,
        filename: basename(imageFile.path),
      ),
    });
    print("...............FormData............. = ${formData.fields}");
    final Response response = await _dio.post(
      url,
      data: formData,
    );
    print(
        " .................... Response Data .....................${response.data}");

    if (response.statusCode == 200) {
      if (response.data != null) {
        RiderImageUploadResponse model = RiderImageUploadResponse();
        print("MODELLLL.............$model");
        return model.fromMap(response.data);
      }
      RiderImageUploadResponse model = RiderImageUploadResponse();
      return model.fromMap(response.data);
    } else {}
  } finally {}
}

Future<RiderImageUploadResponse> postRidingClientImage(
  String url,
  String email,
  String name,
  String ridingClientNDId,
  String uUID,
  int gender,
  String ridingClientPhoneNo,
  String imageFile,
) async {
  print(url);
  try {
    Dio _dio = new Dio();
    FormData formData = FormData.fromMap({
      "RidingClientEmail": email,
      "RidingClientName": name,
      "RidingClientNDId": ridingClientNDId,
      "Gender": gender,
      "RidingClientPhoneNumber": ridingClientPhoneNo,
      "UUID": uUID,
      "ImageFile": await MultipartFile.fromFile(
        imageFile,
        filename: basename(imageFile),
      ),
    });
    print("...............FormData............. = ${formData.fields}");
    final Response response = await _dio.post(
      url,
      data: formData,
    );
    print(
        " .................... Response Data .....................${response.data}");

    if (response.statusCode == 200) {
      if (response.data != null) {
        RiderImageUploadResponse model = RiderImageUploadResponse();

        return model.fromMap(response.data);
      }
      RiderImageUploadResponse model = RiderImageUploadResponse();
      return model.fromMap(response.data);
    } else {}
  } finally {}
}
