class DrivingLicenceResponse {
  String status;
  int id;

  DrivingLicenceResponse({
    this.id,
    this.status,
  });

  @override
  DrivingLicenceResponse fromMap(dynamicData) {
    if (dynamicData != null) {
      return DrivingLicenceResponse(
        id: dynamicData['Id'],
        status: dynamicData['Status'],
      );
    } else {
      return null;
    }
  }

  @override
  List<DrivingLicenceResponse> fromMapList(List dynamicDataList) {
    final List<DrivingLicenceResponse> commentList = <DrivingLicenceResponse>[];

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
  Map<String, dynamic> toMap(DrivingLicenceResponse object) {
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
      List<DrivingLicenceResponse> objectList) {
    final List<Map<String, dynamic>> mapList = <Map<String, dynamic>>[];
    if (objectList != null) {
      for (DrivingLicenceResponse data in objectList) {
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
