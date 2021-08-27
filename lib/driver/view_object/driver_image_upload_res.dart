import 'package:get_smart_ride_cas/api/common/ps_object.dart';

class DriverImageUploadResponse extends PsObject<DriverImageUploadResponse> {
  String status;
  int id;

  DriverImageUploadResponse({
    this.id,
    this.status,
  });

  @override
  DriverImageUploadResponse fromMap(dynamicData) {
    if (dynamicData != null) {
      return DriverImageUploadResponse(
        id: dynamicData['Id'],
        status: dynamicData['Status'],
      );
    } else {
      return null;
    }
  }

  @override
  List<DriverImageUploadResponse> fromMapList(List dynamicDataList) {
    final List<DriverImageUploadResponse> commentList =
        <DriverImageUploadResponse>[];

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
  Map<String, dynamic> toMap(DriverImageUploadResponse object) {
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
      List<DriverImageUploadResponse> objectList) {
    final List<Map<String, dynamic>> mapList = <Map<String, dynamic>>[];
    if (objectList != null) {
      for (DriverImageUploadResponse data in objectList) {
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
