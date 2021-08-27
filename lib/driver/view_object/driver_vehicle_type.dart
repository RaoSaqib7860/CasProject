import 'package:get_smart_ride_cas/api/common/ps_object.dart';

class DriverVehicleType extends PsObject<DriverVehicleType> {
  String str1;
  String str2;
  String str3;
  String str4;
  @override
  String getPrimaryKey() {
    return '0';
  }

  @override
  DriverVehicleType fromMap(dynamicData) {
    if (dynamicData != null) {
      return DriverVehicleType(
        str1: dynamicData['Str1'],
        str2: dynamicData['Str2'],
        str3: dynamicData['Str3'],
        str4: dynamicData['Str4'],
      );
    } else {
      return null;
    }
  }

  @override
  List<DriverVehicleType> fromMapList(List dynamicDataList) {
    final List<DriverVehicleType> commentList = <DriverVehicleType>[];

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
  Map<String, dynamic> toMap(DriverVehicleType object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{
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
  List<Map<String, dynamic>> toMapList(List<DriverVehicleType> objectList) {
    final List<Map<String, dynamic>> mapList = <Map<String, dynamic>>[];
    if (objectList != null) {
      for (DriverVehicleType data in objectList) {
        if (data != null) {
          mapList.add(toMap(data));
        }
      }
    }

    return mapList;
  }

  DriverVehicleType({this.str1, this.str2, this.str3, this.str4});
}
