import 'package:get_smart_ride_cas/api/common/ps_object.dart';

class DriverSignUpResponse extends PsObject<DriverSignUpResponse> {
  String status;
  int id;
  String str1;
  String str2;
  String str3;
  String str4;

  DriverSignUpResponse(
      {this.id, this.status, this.str1, this.str2, this.str3, this.str4});

  @override
  DriverSignUpResponse fromMap(dynamicData) {
    if (dynamicData != null) {
      return DriverSignUpResponse(
        id: dynamicData['Id'],
        str1: dynamicData['Str1'],
        str2: dynamicData['Str2'],
        str3: dynamicData['Str3'],
        str4: dynamicData['Str4'],
        status: dynamicData['Status'],
      );
    } else {
      return null;
    }
  }

  @override
  List<DriverSignUpResponse> fromMapList(List dynamicDataList) {
    final List<DriverSignUpResponse> commentList = <DriverSignUpResponse>[];

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
  Map<String, dynamic> toMap(DriverSignUpResponse object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{
        'Status': object.status,
        'Id': object.id,
        'Str1': object.str1,
        'Str2': object.str2,
        'Str3': object.str3,
        'Str4': object.str4
      };

      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>> toMapList(List<DriverSignUpResponse> objectList) {
    final List<Map<String, dynamic>> mapList = <Map<String, dynamic>>[];
    if (objectList != null) {
      for (DriverSignUpResponse data in objectList) {
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
