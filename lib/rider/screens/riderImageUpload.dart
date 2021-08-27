import 'package:get_smart_ride_cas/api/common/ps_object.dart';

class RiderImageUploadResponse extends PsObject<RiderImageUploadResponse> {
  String status;
  int id;

  RiderImageUploadResponse({
    this.id,
    this.status,
  });

  @override
  RiderImageUploadResponse fromMap(dynamicData) {
    if (dynamicData != null) {
      return RiderImageUploadResponse(
        id: dynamicData['Id'],
        status: dynamicData['Status'],
      );
    } else {
      return null;
    }
  }

  @override
  List<RiderImageUploadResponse> fromMapList(List dynamicDataList) {
    final List<RiderImageUploadResponse> commentList =
        <RiderImageUploadResponse>[];

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
  Map<String, dynamic> toMap(RiderImageUploadResponse object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{
        'Status': object.status,
        'Id': object.id,
      };

      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>> toMapList(
      List<RiderImageUploadResponse> objectList) {
    final List<Map<String, dynamic>> mapList = <Map<String, dynamic>>[];
    if (objectList != null) {
      for (RiderImageUploadResponse data in objectList) {
        if (data != null) {
          mapList.add(toMap(data));
        }
      }
    }

    return mapList;
  }

  @override
  String getPrimaryKey() {
    // TODO: implement getPrimaryKey
    throw UnimplementedError();
  }
}
