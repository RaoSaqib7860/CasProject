import 'package:get_smart_ride_cas/api/common/ps_object.dart';

class DriverOtpResponse extends PsObject<DriverOtpResponse> {
  String uUID;
  String status;

  String idcardImage;
  String drivingLicense;
  String driverImage;
  String vehicleNo;
  String str1;
  String str2;
  String str3;
  String str4;
  String driverPhoneNo;
  String driverName;
  String driverEmail;
  DriverOtpResponse(
      {this.uUID,
      this.driverPhoneNo,
      this.driverImage,
      this.driverEmail,
      this.driverName,
      this.drivingLicense,
      this.idcardImage,
      this.str1,
      this.str2,
      this.vehicleNo,
      this.status,
      this.str3,
      this.str4});

  @override
  String getPrimaryKey() {
    return '0';
  }

  @override
  DriverOtpResponse fromMap(dynamicData) {
    if (dynamicData != null) {
      return DriverOtpResponse(
          uUID: dynamicData['UUID'],
          driverPhoneNo: dynamicData['PhoneNumber'],
          idcardImage: dynamicData['IdCardImage'],
          driverImage: dynamicData['DriverImage'],
          vehicleNo: dynamicData['VehicleNumber'],
          driverName: dynamicData['Name'],
          driverEmail: dynamicData['Email'],
          str1: dynamicData['Str1'],
          str2: dynamicData['Str2'],
          str3: dynamicData['Str3'],
          str4: dynamicData['Str4'],
          status: dynamicData['Status'],
          drivingLicense: dynamicData['DrivingLiscence']);
    } else {
      return null;
    }
  }

  @override
  List<DriverOtpResponse> fromMapList(List dynamicDataList) {
    final List<DriverOtpResponse> commentList = <DriverOtpResponse>[];

    if (dynamicDataList != null) {
      for (dynamic dynamicData in dynamicDataList) {
        if (dynamicData != null) {
          commentList.add(fromMap(dynamicData));
        }
      }
    }
    return commentList;
  }

  @override
  Map<String, dynamic> toMap(DriverOtpResponse object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{
        'UUID': object.uUID,
        'PhoneNumber': object.driverPhoneNo,
        'IdCardImage': object.idcardImage,
        'DriverImage': object.driverImage,
        'VehicleNumber': object.vehicleNo,
        'Name': object.driverName,
        'Email': object.driverEmail,
        'Str1': object.str1,
        'Str2': object.str2,
        'Status': object.status,
        'Str3': object.str3,
        'Str4': object.str4,
        'DrivingLiscence': object.drivingLicense
      };

      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>> toMapList(List<DriverOtpResponse> objectList) {
    final List<Map<String, dynamic>> mapList = <Map<String, dynamic>>[];
    if (objectList != null) {
      for (DriverOtpResponse data in objectList) {
        if (data != null) {
          mapList.add(toMap(data));
        }
      }
    }

    return mapList;
  }

  // DriverOtpResponse.fromJson(Map<String, dynamic> json)
  //     : uUID = json['UUID'],
  //       email = json['RidingClientEmail'],
  //       ridingClientPhoneNo = json['RidingClientPhoneNumber'];
}
