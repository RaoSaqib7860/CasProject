import 'dart:convert';

class GetDriverData {
  int driverId;
  String name;
  String phoneNumber;
  String image;
  String vehicleNo;
  String vTypeName;
  String model;
  String color;
  String brand;
  GetDriverData(
      {this.driverId,
      this.name,
      this.phoneNumber,
      this.image,
      this.vehicleNo,
      this.vTypeName,
      this.model,
      this.brand,
      this.color});

  GetDriverData copyWith(
      {int driverId,
      String name,
      String phoneNumber,
      String image,
      String vehicleNo,
      String vTypeName,
      String model,
      String brand,
      String color}) {
    return GetDriverData(
        driverId: driverId ?? this.driverId,
        name: name ?? this.name,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        image: image ?? this.image,
        vehicleNo: vehicleNo ?? this.vehicleNo,
        vTypeName: vTypeName ?? this.vTypeName,
        model: model ?? this.model,
        color: color ?? this.color,
        brand: brand ?? this.brand);
  }

  Map<String, dynamic> toMap() {
    return {
      'DriverId': driverId,
      'Name': name,
      'PhoneNumber': phoneNumber,
      'DriverImage': image,
      'VehicleNumber': vehicleNo,
      'VTypeName': vTypeName,
      'Model': model,
      'Color': color,
      'Brand': brand
    };
  }

  factory GetDriverData.fromMap(Map<String, dynamic> map) {
    return GetDriverData(
        driverId: map['DriverId'],
        name: map['Name'],
        phoneNumber: map['PhoneNumber'],
        image: map['DriverImage'],
        vehicleNo: map['VehicleNumber'],
        vTypeName: map['VTypeName'],
        model: map['Model'],
        color: map['Color'],
        brand: map['Brand']);
  }

  String toJson() => json.encode(toMap());

  factory GetDriverData.fromJson(String source) =>
      GetDriverData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GetDriverData(driverId: $driverId, name: $name, phoneNumber: $phoneNumber, image: $image, vehicleNo: $vehicleNo, vTypeName: $vTypeName, color:$color, model:$model, brand:$brand)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetDriverData &&
        other.driverId == driverId &&
        other.name == name &&
        other.phoneNumber == phoneNumber &&
        other.image == image &&
        other.vehicleNo == vehicleNo &&
        other.vTypeName == vTypeName &&
        other.color == color &&
        other.model == model &&
        other.brand == brand;
  }

  @override
  int get hashCode {
    return driverId.hashCode ^
        name.hashCode ^
        phoneNumber.hashCode ^
        image.hashCode ^
        vehicleNo.hashCode ^
        vTypeName.hashCode ^
        model.hashCode ^
        color.hashCode ^
        brand.hashCode;
  }

  static List<GetDriverData> fromMapList(List<dynamic> jsonList) {
    List<GetDriverData> driverDataList = List();
    for (var json in jsonList) {
      driverDataList.add(GetDriverData.fromMap(json));
    }
    return driverDataList;
  }
}
