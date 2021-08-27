import 'dart:io';

import 'package:get_smart_ride_cas/api/common/ps_object.dart';

class InsertRidingClientModel extends PsObject<InsertRidingClientModel> {
  String ridingClientEmail;
  String ridingClientName;
  String ridingClientImage;
  String ridingClientNDId;
  String uUID;
  int gender;
  String ridingClientPhoneNo;
  InsertRidingClientModel(
      {this.ridingClientEmail,
      this.ridingClientName,
      this.ridingClientImage,
      this.ridingClientNDId,
      this.uUID,
      this.gender,
      this.ridingClientPhoneNo});

  @override
  String getPrimaryKey() {
    return '0';
  }

  @override
  InsertRidingClientModel fromMap(dynamicData) {
    if (dynamicData != null) {
      return InsertRidingClientModel(
          ridingClientEmail: dynamicData['RidingClientEmail'],
          ridingClientImage: dynamicData['RidingClientImage'],
          ridingClientNDId: dynamicData['RidingClientNDId'],
          ridingClientName: dynamicData['RidingClientName'],
          uUID: dynamicData['UUID'],
          gender: dynamicData['Gender'],
          ridingClientPhoneNo: dynamicData['RidingClientPhoneNumber']);
    } else {
      return null;
    }
  }

  @override
  List<InsertRidingClientModel> fromMapList(List dynamicDataList) {
    final List<InsertRidingClientModel> commentList =
        <InsertRidingClientModel>[];

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
  Map<String, dynamic> toMap(InsertRidingClientModel object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{
        'RidingClientEmail': object.ridingClientEmail,
        'RidingClientImage': object.ridingClientImage,
        'RidingClientNDId': object.ridingClientNDId,
        'RidingClientName': object.ridingClientName,
        'UUID': object.uUID,
        'Gender': object.gender,
        'RidingClientPhoneNumber': object.ridingClientPhoneNo
      };

      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>> toMapList(
      List<InsertRidingClientModel> objectList) {
    final List<Map<String, dynamic>> mapList = <Map<String, dynamic>>[];
    if (objectList != null) {
      for (InsertRidingClientModel data in objectList) {
        if (data != null) {
          mapList.add(toMap(data));
        }
      }
    }

    return mapList;
  }
}
