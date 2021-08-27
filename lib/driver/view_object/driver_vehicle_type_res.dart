import 'package:get_smart_ride_cas/api/common/ps_object.dart';

class DriverVehicleTypeResponse extends PsObject<DriverVehicleTypeResponse> {
  String vehicleType;
  int vehicleTypeId;
  String vTypeName;
  String vTypeImage;
  double registrationCost;

  @override
  String getPrimaryKey() {
    return '0';
  }

  @override
  DriverVehicleTypeResponse fromMap(dynamicData) {
    if (dynamicData != null) {
      return DriverVehicleTypeResponse(
          vehicleTypeId: dynamicData['VehicleTypeId'],
          registrationCost: dynamicData['RegistrationCost'],
          vehicleType: dynamicData['VehicleType'],
          vTypeImage: dynamicData['VTypeImage'],
          vTypeName: dynamicData['VTypeName']);
    } else {
      return null;
    }
  }

  @override
  List<DriverVehicleTypeResponse> fromMapList(List dynamicDataList) {
    final List<DriverVehicleTypeResponse> commentList =
        <DriverVehicleTypeResponse>[];

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
  Map<String, dynamic> toMap(DriverVehicleTypeResponse object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{
        'RegistrationCost': object.registrationCost,
        'VehicleType': object.vehicleType,
        'VehicleTypeId': object.vehicleTypeId,
        'VTypeImage': object.vTypeImage,
        'VTypeName': object.vTypeName
      };

      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>> toMapList(
      List<DriverVehicleTypeResponse> objectList) {
    final List<Map<String, dynamic>> mapList = <Map<String, dynamic>>[];
    if (objectList != null) {
      for (DriverVehicleTypeResponse data in objectList) {
        if (data != null) {
          mapList.add(toMap(data));
        }
      }
    }

    return mapList;
  }

  DriverVehicleTypeResponse(
      {this.vehicleTypeId,
      this.registrationCost,
      this.vehicleType,
      this.vTypeImage,
      this.vTypeName});
}
