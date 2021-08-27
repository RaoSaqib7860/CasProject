import 'package:get_smart_ride_cas/api/common/ps_object.dart';

class DriverFranchiseResponse extends PsObject<DriverFranchiseResponse> {
  String franchiseName;
  String phoneNumber;
  String email;
  String address;
  double latitude;
  double longitude;
  int cityId;
  String cityName;
  DriverFranchiseResponse(
      {this.cityName,
      this.address,
      this.cityId,
      this.email,
      this.franchiseName,
      this.latitude,
      this.longitude,
      this.phoneNumber});
  @override
  String getPrimaryKey() {
    return '0';
  }

  @override
  DriverFranchiseResponse fromMap(dynamicData) {
    if (dynamicData != null) {
      return DriverFranchiseResponse(
        address: dynamicData['Address'],
        cityId: dynamicData['CityId'],
        cityName: dynamicData['CityName'],
        email: dynamicData['Email'],
        franchiseName: dynamicData['FranchiseName'],
        latitude: dynamicData['Latitude'],
        longitude: dynamicData['Longitude'],
        phoneNumber: dynamicData['PhoneNumber'],
      );
    } else {
      return null;
    }
  }

  @override
  List<DriverFranchiseResponse> fromMapList(List dynamicDataList) {
    final List<DriverFranchiseResponse> commentList =
        <DriverFranchiseResponse>[];

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
  Map<String, dynamic> toMap(DriverFranchiseResponse object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{
        'Address': object.address,
        'CityId': object.cityId,
        'CityName': object.cityName,
        'Email': object.email,
        'FranchiseName': object.franchiseName,
        'Latitude': object.latitude,
        'Longitude': object.longitude,
        'PhoneNumber': object.phoneNumber,
      };

      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>> toMapList(
      List<DriverFranchiseResponse> objectList) {
    final List<Map<String, dynamic>> mapList = <Map<String, dynamic>>[];
    if (objectList != null) {
      for (DriverFranchiseResponse data in objectList) {
        if (data != null) {
          mapList.add(toMap(data));
        }
      }
    }

    return mapList;
  }
}
