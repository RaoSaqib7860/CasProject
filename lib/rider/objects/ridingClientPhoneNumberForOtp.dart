import 'package:get_smart_ride_cas/api/common/ps_object.dart';

class InsertRidingPhoneNoForOtp extends PsObject<InsertRidingPhoneNoForOtp> {
  String uUID;
  String email;
  String ridingClientPhoneNo;
  InsertRidingPhoneNoForOtp({this.uUID, this.ridingClientPhoneNo, this.email});

  @override
  String getPrimaryKey() {
    return '0';
  }

  @override
  InsertRidingPhoneNoForOtp fromMap(dynamicData) {
    if (dynamicData != null) {
      return InsertRidingPhoneNoForOtp(
          uUID: dynamicData['UUID'],
          ridingClientPhoneNo: dynamicData['RidingClientPhoneNumber'],
          email: dynamicData['RidingClientEmail']);
    } else {
      return null;
    }
  }

  @override
  List<InsertRidingPhoneNoForOtp> fromMapList(List dynamicDataList) {
    final List<InsertRidingPhoneNoForOtp> commentList =
        <InsertRidingPhoneNoForOtp>[];

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
  Map<String, dynamic> toMap(InsertRidingPhoneNoForOtp object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{
        'UUID': object.uUID,
        'RidingClientPhoneNumber': object.ridingClientPhoneNo,
        'RidingClientEmail': object.email
      };

      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>> toMapList(
      List<InsertRidingPhoneNoForOtp> objectList) {
    final List<Map<String, dynamic>> mapList = <Map<String, dynamic>>[];
    if (objectList != null) {
      for (InsertRidingPhoneNoForOtp data in objectList) {
        if (data != null) {
          mapList.add(toMap(data));
        }
      }
    }

    return mapList;
  }

  static InsertRidingPhoneNoForOtp fromJson(dynamicData) {
    if (dynamicData != null) {
      return InsertRidingPhoneNoForOtp(
          uUID: dynamicData['UUID'],
          ridingClientPhoneNo: dynamicData['RidingClientPhoneNumber'],
          email: dynamicData['RidingClientEmail']);
    } else {
      return null;
    }
  }
  // InsertRidingPhoneNoForOtp.fromJson(Map<String, dynamic> json)
  //     : uUID = json['UUID'],
  //       email = json['RidingClientEmail'],
  //       ridingClientPhoneNo = json['RidingClientPhoneNumber'];
}
