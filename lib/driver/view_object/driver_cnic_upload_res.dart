import 'package:get_smart_ride_cas/api/common/ps_object.dart';

class DriverCnicUploadResponse extends PsObject<DriverCnicUploadResponse> {
  String status;
  int id;

  DriverCnicUploadResponse({
    this.id,
    this.status,
  });

  @override
  DriverCnicUploadResponse fromMap(dynamicData) {
    if (dynamicData != null) {
      return DriverCnicUploadResponse(
        id: dynamicData['Id'],
        status: dynamicData['Status'],
      );
    } else {
      return null;
    }
  }

  @override
  List<DriverCnicUploadResponse> fromMapList(List dynamicDataList) {
    final List<DriverCnicUploadResponse> commentList =
        <DriverCnicUploadResponse>[];

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
  Map<String, dynamic> toMap(DriverCnicUploadResponse object) {
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
      List<DriverCnicUploadResponse> objectList) {
    final List<Map<String, dynamic>> mapList = <Map<String, dynamic>>[];
    if (objectList != null) {
      for (DriverCnicUploadResponse data in objectList) {
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
