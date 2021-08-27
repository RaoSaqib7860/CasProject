import 'package:get_smart_ride_cas/api/common/ps_object.dart';

class DriverVehicleInfo extends PsObject<DriverVehicleInfo> {
  String vehicleNumber;
  int vehicleTypeId;
  String brand;
  String model;
  String color;
  String uUID;
  String str1;
  String str2;
  String str3;

  DriverVehicleInfo(
      {this.vehicleNumber,
      this.vehicleTypeId,
      this.brand,
      this.model,
      this.color,
      this.uUID,
      this.str1,
      this.str2,
      this.str3});

  @override
  String getPrimaryKey() {
    return '0';
  }

  @override
  DriverVehicleInfo fromMap(dynamicData) {
    if (dynamicData != null) {
      return DriverVehicleInfo(
          str1: dynamicData['Str1'],
          str2: dynamicData['Str2'],
          str3: dynamicData['Str3'],
          vehicleNumber: dynamicData['VehicleNumber'],
          brand: dynamicData['Brand'],
          color: dynamicData['Color'],
          model: dynamicData['Model'],
          uUID: dynamicData['UUID'],
          vehicleTypeId: dynamicData['VehicleTypeId']);
    } else {
      return null;
    }
  }

  @override
  List<DriverVehicleInfo> fromMapList(List dynamicDataList) {
    final List<DriverVehicleInfo> commentList = <DriverVehicleInfo>[];

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
  Map<String, dynamic> toMap(DriverVehicleInfo object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{
        'Str1': object.str1,
        'Str2': object.str2,
        'Str3': object.str3,
        'VehicleNumber': object.vehicleNumber,
        'UUID': object.uUID,
        'Brand': brand,
        'Model': model,
        'Color': color,
        'VehicleTypeId': vehicleTypeId,
      };

      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>> toMapList(List<DriverVehicleInfo> objectList) {
    final List<Map<String, dynamic>> mapList = <Map<String, dynamic>>[];
    if (objectList != null) {
      for (DriverVehicleInfo data in objectList) {
        if (data != null) {
          mapList.add(toMap(data));
        }
      }
    }

    return mapList;
  }
}
