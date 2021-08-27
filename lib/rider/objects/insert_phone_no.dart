import 'package:get_smart_ride_cas/api/common/ps_object.dart';

class InsertingRidingClientPhoneNumber
    extends PsObject<InsertingRidingClientPhoneNumber> {
  //
  String ridingClientEmail;
  String ridingClientPhoneNumber;
  InsertingRidingClientPhoneNumber({
    this.ridingClientEmail,
    this.ridingClientPhoneNumber,
  });

  @override
  String getPrimaryKey() {
    return '0';
  }

  @override
  InsertingRidingClientPhoneNumber fromMap(dynamicData) {
    if (dynamicData != null) {
      return InsertingRidingClientPhoneNumber(
        ridingClientEmail: dynamicData['RidingClientEmail'],
        ridingClientPhoneNumber: dynamicData['RidingClientPhoneNumber'],
      );
    } else {
      return null;
    }
  }

  @override
  List<InsertingRidingClientPhoneNumber> fromMapList(List dynamicDataList) {
    final List<InsertingRidingClientPhoneNumber> commentList =
        <InsertingRidingClientPhoneNumber>[];

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
  Map<String, dynamic> toMap(InsertingRidingClientPhoneNumber object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{
        'RidingClientEmail': object.ridingClientEmail,
        'RidingClientPhoneNumber': object.ridingClientPhoneNumber,
      };

      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>> toMapList(
      List<InsertingRidingClientPhoneNumber> objectList) {
    final List<Map<String, dynamic>> mapList = <Map<String, dynamic>>[];
    if (objectList != null) {
      for (InsertingRidingClientPhoneNumber data in objectList) {
        if (data != null) {
          mapList.add(toMap(data));
        }
      }
    }

    return mapList;
  }
}
