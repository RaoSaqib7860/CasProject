import 'package:get_smart_ride_cas/api/common/ps_object.dart';

class DriverSignUp extends PsObject<DriverSignUp> {
  String name;
  String email;
  String phoneNumber;
  String password;
  String idCardNumber;
  String uuid;
  String id;

  double latitude;
  double longitude;
  String city;

  DriverSignUp(
      {this.email,
      this.idCardNumber,
      this.name,
      this.password,
      this.phoneNumber,
      this.uuid,
      this.id,
      this.city,
      this.latitude,
      this.longitude});

  @override
  String getPrimaryKey() {
    return id;
  }

  @override
  DriverSignUp fromMap(dynamicData) {
    if (dynamicData != null) {
      return DriverSignUp(
          email: dynamicData['Email'],
          idCardNumber: dynamicData['IdCardNumber'],
          name: dynamicData['Name'],
          password: dynamicData['Password'],
          phoneNumber: dynamicData['PhoneNumber'],
          uuid: dynamicData['UUID'],
          city: dynamicData['City'],
          latitude: dynamicData['Latitude'],
          longitude: dynamicData['Longitude']);
    } else {
      return null;
    }
  }

  @override
  List<DriverSignUp> fromMapList(List dynamicDataList) {
    final List<DriverSignUp> commentList = <DriverSignUp>[];

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
  Map<String, dynamic> toMap(DriverSignUp object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{
        'Name': object.name,
        'Email': object.email,
        'Password': object.password,
        'PhoneNumber': object.phoneNumber,
        'IdCardNumber': object.idCardNumber,
        'UUID': uuid,
        'City': city,
        'Latitude': latitude,
        'Longitude': longitude,
      };

      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>> toMapList(List<DriverSignUp> objectList) {
    final List<Map<String, dynamic>> mapList = <Map<String, dynamic>>[];
    if (objectList != null) {
      for (DriverSignUp data in objectList) {
        if (data != null) {
          mapList.add(toMap(data));
        }
      }
    }

    return mapList;
  }
}
