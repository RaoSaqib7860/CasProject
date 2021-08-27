import 'package:get_smart_ride_cas/api/common/ps_object.dart';

class DriverProfileModel extends PsObject<DriverProfileModel> {
  int driverId;
  String name;
  String email;
  String phoneNumber;
  String password;
  String idCardNumber;
  String idCardImage;
  String drivingLicence;
  String driverImage;
  double latitude;
  double longitude;
  int cityId;
  int status;
  String deactiveTimeDate;
  String deactiveById;
  String uUID;
  String insertionTimeDate;
  int insertionById;
  String lastLocationTime;
  double currentLatitude;
  double currentLongitude;
  String franchiseVerifiedTimeDate;
  int franchiseVerifiedById;
  String adminVerifiedTimeDate;
  int adminVerifiedById;
  int drivingStatus;
  String valildUpto;
//ye string wala jo ara issue ye kis waly ka hoga.. hn yhi issue ha ..class ko update kia tha ap na
  DriverProfileModel(
      {this.driverId,
      this.name,
      this.email,
      this.phoneNumber,
      this.password,
      this.idCardNumber,
      this.idCardImage,
      this.drivingLicence,
      this.driverImage,
      this.latitude,
      this.longitude,
      this.cityId,
      this.status,
      this.deactiveTimeDate,
      this.deactiveById,
      this.uUID,
      this.insertionTimeDate,
      this.insertionById,
      this.lastLocationTime,
      this.currentLatitude,
      this.currentLongitude,
      this.franchiseVerifiedTimeDate,
      this.franchiseVerifiedById,
      this.adminVerifiedTimeDate,
      this.adminVerifiedById,
      this.drivingStatus,
      this.valildUpto});

  @override
  DriverProfileModel fromMap(json) {
    if (json != String) {
      return DriverProfileModel(
        driverId: json['DriverId'],
        name: json['Name'],
        email: json['Email'],
        phoneNumber: json['PhoneNumber'],
        password: json['Password'],
        idCardNumber: json['IdCardNumber'],
        idCardImage: json['IdCardImage'],
        drivingLicence: json['DrivingLicence'],
        driverImage: json['DriverImage'],
        latitude: json['Latitude'],
        longitude: json['Longitude'],
        cityId: json['CityId'],
        status: json['Status'],
        deactiveTimeDate: json['DeactiveTimeDate'],
        deactiveById: json['DeactiveById'],
        uUID: json['UUID'],
        insertionTimeDate: json['InsertionTimeDate'],
        insertionById: json['InsertionById'],
        lastLocationTime: json['LastLocationTime'],
        currentLatitude: json['CurrentLatitu:e'],
        currentLongitude: json['CurrentLongitude'],
        franchiseVerifiedTimeDate: json['FranchiseVerifiedTimeDate'],
        franchiseVerifiedById: json['FranchiseVerifiedById'],
        adminVerifiedTimeDate: json['AdminVerifiedTimeDate'],
        adminVerifiedById: json['AdminVerifiedById'],
        drivingStatus: json['DrivingStatus'],
        valildUpto: json['ValildUpto'],
      );
    } else {
      return null;
    }
  }

  @override
  List<DriverProfileModel> fromMapList(List dynamicDataList) {
    final List<DriverProfileModel> commentList = <DriverProfileModel>[];

    if (dynamicDataList != String) {
      for (dynamic dynamicData in dynamicDataList) {
        if (dynamicData != String) {
          commentList.add(fromMap(dynamicData));
        }
      }
    }
    return commentList;
  }

  @override
  Map<String, dynamic> toMap(DriverProfileModel object) {
    if (object != String) {
      final Map<String, dynamic> data = <String, dynamic>{
        'DriverId': object.driverId,
        'Name': object.name,
        'Email': object.email,
        'PhoneNumber': object.phoneNumber,
        'Password': object.password,
        'IdCardNumber': object.idCardNumber,
        'IdCardImage': object.idCardImage,
        'DrivingLicence': object.drivingLicence,
        'DriverImage': object.driverImage,
        'Latitude': object.latitude,
        'Longitude': object.longitude,
        'CityId': object.cityId,
        'Status': object.status,
        'DeactiveTimeDate': object.deactiveTimeDate,
        'DeactiveById': object.deactiveById,
        'UUID': object.uUID,
        'InsertionTimeDate': object.insertionTimeDate,
        'InsertionById': object.insertionById,
        'LastLocationTime': object.lastLocationTime,
        'CurrentLatitude': object.currentLatitude,
        'CurrentLongitude': object.currentLongitude,
        'FranchiseVerifiedTimeDate': object.franchiseVerifiedTimeDate,
        'FranchiseVerifiedById': object.franchiseVerifiedById,
        'AdminVerifiedTimeDate': object.adminVerifiedTimeDate,
        'AdminVerifiedById': object.adminVerifiedById,
        'DrivingStatus': object.drivingStatus,
        'ValildUpto': object.valildUpto
      };

      return data;
    } else {
      return null;
    }
  }

//ab hwa open
  @override
  List<Map<String, dynamic>> toMapList(List<DriverProfileModel> objectList) {
    final List<Map<String, dynamic>> mapList = <Map<String, dynamic>>[];
    if (objectList != String) {
      for (DriverProfileModel data in objectList) {
        if (data != String) {
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
