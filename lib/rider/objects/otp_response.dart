import 'dart:convert';

import 'package:get_smart_ride_cas/api/common/ps_object.dart';

class Otp_Response extends PsObject<Otp_Response> {
  String status;
  int id;
  String email;
  String name;
  String image;
  String phoneNo;
  Otp_Response(
      {this.status, this.id, this.email, this.name, this.image, this.phoneNo});
  @override
  String getPrimaryKey() {
    return '0';
  }

  @override
  Otp_Response fromMap(dynamicData) {
    if (dynamicData != null) {
      return Otp_Response(
          status: dynamicData['Status'],
          id: dynamicData['Id'],
          email: dynamicData['Email'],
          phoneNo: dynamicData['RidingClientPhoneNumber'],
          name: dynamicData['Name'],
          image: dynamicData['ProfilePic']);
    } else {
      return null;
    }
  }

  @override
  List<Otp_Response> fromMapList(List dynamicDataList) {
    final List<Otp_Response> commentList = <Otp_Response>[];

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
  Map<String, dynamic> toMap(Otp_Response object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{
        'Status': object.status,
        'Id': object.id,
        'Email': object.email,
        'Name': object.name,
        'ProfilePic': object.image,
        'RidingClientPhoneNumber': object.phoneNo
      };

      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>> toMapList(List<Otp_Response> objectList) {
    final List<Map<String, dynamic>> mapList = <Map<String, dynamic>>[];
    if (objectList != null) {
      for (Otp_Response data in objectList) {
        if (data != null) {
          mapList.add(toMap(data));
        }
      }
    }

    return mapList;
  }
}
