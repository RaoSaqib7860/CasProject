import 'package:get_smart_ride_cas/api/common/ps_object.dart';

class RiderInsertEmailRequest extends PsObject<RiderInsertEmailRequest> {
  String ridingClientEmail;

  RiderInsertEmailRequest({this.ridingClientEmail});

  @override
  String getPrimaryKey() {
    return '0';
  }

  @override
  RiderInsertEmailRequest fromMap(dynamicData) {
    if (dynamicData != null) {
      return RiderInsertEmailRequest(
        ridingClientEmail: dynamicData['RidingClientEmail'],
      );
    } else {
      return null;
    }
  }

  @override
  List<RiderInsertEmailRequest> fromMapList(List dynamicDataList) {
    final List<RiderInsertEmailRequest> commentList =
        <RiderInsertEmailRequest>[];

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
  Map<String, dynamic> toMap(RiderInsertEmailRequest object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{
        'RidingClientEmail': object.ridingClientEmail,
      };

      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>> toMapList(
      List<RiderInsertEmailRequest> objectList) {
    final List<Map<String, dynamic>> mapList = <Map<String, dynamic>>[];
    if (objectList != null) {
      for (RiderInsertEmailRequest data in objectList) {
        if (data != null) {
          mapList.add(toMap(data));
        }
      }
    }

    return mapList;
  }
}
