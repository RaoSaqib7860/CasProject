import 'package:get_smart_ride_cas/api/common/ps_object.dart';

class ApiResponse extends PsObject<ApiResponse> {
  String status;
  int id;
  ApiResponse({
    this.status,
    this.id,
  });
  @override
  String getPrimaryKey() {
    return '0';
  }

  @override
  ApiResponse fromMap(dynamicData) {
    if (dynamicData != null) {
      return ApiResponse(
        status: dynamicData['Status'],
        id: dynamicData['Id'],
      );
    } else {
      return null;
    }
  }

  @override
  List<ApiResponse> fromMapList(List dynamicDataList) {
    final List<ApiResponse> commentList = <ApiResponse>[];

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
  Map<String, dynamic> toMap(ApiResponse object) {
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
  List<Map<String, dynamic>> toMapList(List<ApiResponse> objectList) {
    final List<Map<String, dynamic>> mapList = <Map<String, dynamic>>[];
    if (objectList != null) {
      for (ApiResponse data in objectList) {
        if (data != null) {
          mapList.add(toMap(data));
        }
      }
    }

    return mapList;
  }
}
