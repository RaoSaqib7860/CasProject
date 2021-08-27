import 'package:get_smart_ride_cas/api/common/ps_object.dart';

class DriverLoginResponse extends PsObject<DriverLoginResponse> {
  String status;
  int id;
  String str1;
  String str2;
  String str3;
  String str4;
  String idCardImage;
  String drivingLicence;
  String driverImage;
  String vehicleNumber;

  DriverLoginResponse(
      {this.id,
      this.str3,
      this.status,
      this.str2,
      this.str1,
      this.str4,
      this.idCardImage,
      this.driverImage,
      this.drivingLicence,
      this.vehicleNumber});

  @override
  DriverLoginResponse fromMap(dynamicData) {
    if (dynamicData != null) {
      return DriverLoginResponse(
          id: dynamicData['Id'],
          str3: dynamicData['Str3'],
          status: dynamicData['Status'],
          str2: dynamicData['Str2'],
          str1: dynamicData['Str1'],
          str4: dynamicData['Str4'],
          idCardImage: dynamicData['IdCardImage'],
          driverImage: dynamicData['DriverImage'],
          drivingLicence: dynamicData['DrivingLicence'],
          vehicleNumber: dynamicData['VehicleNumber']);
    } else {
      return null;
    }
  }

  @override
  List<DriverLoginResponse> fromMapList(List dynamicDataList) {
    final List<DriverLoginResponse> commentList = <DriverLoginResponse>[];

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
  Map<String, dynamic> toMap(DriverLoginResponse object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{
        'Id': object.id,
        'Status': object.status,
        'Str1': object.str1,
        'Str2': object.str2,
        'Str3': object.str3,
        'Str4': object.str4,
        'IdCardImage': idCardImage,
        'DrivingLicence': drivingLicence,
        'DriverImage': driverImage,
        'VehicleNumber': vehicleNumber
      };

      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>> toMapList(List<DriverLoginResponse> objectList) {
    final List<Map<String, dynamic>> mapList = <Map<String, dynamic>>[];
    if (objectList != null) {
      for (DriverLoginResponse data in objectList) {
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
