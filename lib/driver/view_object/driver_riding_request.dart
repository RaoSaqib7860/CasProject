import 'dart:convert';

import 'package:get_smart_ride_cas/api/common/ps_object.dart';

/*class DriverRidingRequestById extends PsObject<DriverRidingRequestById> {
  int ridingRequestId;
  double fromLatitude;
  double fromLongitude;
  double toLatitude;
  double toLongitude;
  String fromAddress;
  String toAddress;
  int vehicleTypeId;
  int cityId;
  int franchiseId;
  double rateCostPerKM;
  int requestStatus;
  int acceptDriverId;
  String acceptTimeDate;
  String rideStartTime;
  String rideEndTime;
  String rejectedTimeDate;
  double penaltyAmount;
  double penaltyAmountSattledTimeDate;
  int settleId;
  String uUID;
  String actualMTraveled;
  String franchiseName;
  String cityName;
  DriverRidingRequestById({
    this.fromLatitude,
    this.fromLongitude,
    this.toLatitude,
    this.toLongitude,
    this.fromAddress,
    this.toAddress,
    this.vehicleTypeId,
    this.cityId,
    this.franchiseId,
    this.rateCostPerKM,
    this.requestStatus,
    this.acceptDriverId,
    this.acceptTimeDate,
    this.rideStartTime,
    this.rideEndTime,
    this.rejectedTimeDate,
    this.penaltyAmount,
    this.penaltyAmountSattledTimeDate,
    this.settleId,
    this.uUID,
    this.actualMTraveled,
    this.franchiseName,
    this.cityName,
  });

  @override
  String toString() {
    return 'DriverRidingRequest(FromLatitude: $fromLatitude, FromLongitude: $fromLongitude, ToLatitude: $toLatitude, ToLongitude: $toLongitude, FromAddress: $fromAddress, ToAddress: $toAddress, VehicleTypeId: $vehicleTypeId, CityId: $cityId, FranchiseId: $franchiseId, RateCostPerKM: $rateCostPerKM, RequestStatus: $requestStatus, AcceptDriverId: $acceptDriverId, AcceptTimeDate: $acceptTimeDate, RideStartTime: $rideStartTime, RideEndTime: $rideEndTime, RejectedTimeDate: $rejectedTimeDate, PenaltyAmount: $penaltyAmount, PenaltyAmountSattledTimeDate: $penaltyAmountSattledTimeDate, SettleId: $settleId, UUID: $uUID, ActualMTraveled: $actualMTraveled, FranchiseName: $franchiseName, CityName: $cityName)';
  }

  @override
  DriverRidingRequestById fromMap(map) {
    if (map != null) {
      return DriverRidingRequestById(
        fromLatitude: map['FromLatitude'],
        fromLongitude: map['FromLongitude'],
        toLatitude: map['ToLatitude'],
        toLongitude: map['ToLongitude'],
        fromAddress: map['FromAddress'],
        toAddress: map['ToAddress'],
        vehicleTypeId: map['VehicleTypeId'],
        cityId: map['CityId'],
        franchiseId: map['FranchiseId'],
        rateCostPerKM: map['RateCostPerKM'],
        requestStatus: map['RequestStatus'],
        acceptDriverId: map['AcceptDriverId'],
        acceptTimeDate: map['AcceptTimeDate'],
        rideStartTime: map['RideStartTime'],
        rideEndTime: map['RideEndTime'],
        rejectedTimeDate: map['RejectedTimeDate'],
        penaltyAmount: map['PenaltyAmount'],
        penaltyAmountSattledTimeDate: map['PenaltyAmountSattledTimeDate'],
        settleId: map['SettleId'],
        uUID: map['UUID'],
        actualMTraveled: map['ActualMTraveled'],
        franchiseName: map['FranchiseName'],
        cityName: map['CityName'],
      );
    } else {
      return null;
    }
  }

  @override
  List<DriverRidingRequestById> fromMapList(List dynamicDataList) {
    final List<DriverRidingRequestById> commentList =
        <DriverRidingRequestById>[];

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
  Map<String, dynamic> toMap(DriverRidingRequestById object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{
        'FromLatitude': fromLatitude,
        'FromLongitude': fromLongitude,
        'ToLatitude': toLatitude,
        'ToLongitude': toLongitude,
        'FromAddress': fromAddress,
        'ToAddress': toAddress,
        'VehicleTypeId': vehicleTypeId,
        'CityId': cityId,
        'FranchiseId': franchiseId,
        'RateCostPerKM': rateCostPerKM,
        'RequestStatus': requestStatus,
        'AcceptDriverId': acceptDriverId,
        'AcceptTimeDate': acceptTimeDate,
        'RideStartTime': rideStartTime,
        'RideEndTime': rideEndTime,
        'RejectedTimeDate': rejectedTimeDate,
        'PenaltyAmount': penaltyAmount,
        'PenaltyAmountSattledTimeDate': penaltyAmountSattledTimeDate,
        'SettleId': settleId,
        'UUID': uUID,
        'ActualMTraveled': actualMTraveled,
        'FranchiseName': franchiseName,
        'CityName': cityName,
      };

      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>> toMapList(
      List<DriverRidingRequestById> objectList) {
    final List<Map<String, dynamic>> mapList = <Map<String, dynamic>>[];
    if (objectList != null) {
      for (DriverRidingRequestById data in objectList) {
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
*/
class DriverRidingRequestById {
  int ridingRequestId;
  double fromLatitude;
  double fromLongitude;
  double toLatitude;
  double toLongitude;
  String fromAddress;
  String toAddress;
  int vehicleTypeId;
  int cityId;
  int franchiseId;
  double rateCostPerKM;
  int requestStatus;
  int acceptDriverId;
  String acceptTimeDate;
  String rideStartTime;
  String rideEndTime;
  String rejectedTimeDate;
  double penaltyAmount;
  double penaltyAmountSattledTimeDate;
  int settleId;
  String uUID;
  int actualMTraveled;
  String franchiseName;
  String cityName;
  DriverRidingRequestById({
    this.ridingRequestId,
    this.fromLatitude,
    this.fromLongitude,
    this.toLatitude,
    this.toLongitude,
    this.fromAddress,
    this.toAddress,
    this.vehicleTypeId,
    this.cityId,
    this.franchiseId,
    this.rateCostPerKM,
    this.requestStatus,
    this.acceptDriverId,
    this.acceptTimeDate,
    this.rideStartTime,
    this.rideEndTime,
    this.rejectedTimeDate,
    this.penaltyAmount,
    this.penaltyAmountSattledTimeDate,
    this.settleId,
    this.uUID,
    this.actualMTraveled,
    this.franchiseName,
    this.cityName,
  });

  DriverRidingRequestById copyWith({
    int ridingRequestId,
    double fromLatitude,
    double fromLongitude,
    double toLatitude,
    double toLongitude,
    String fromAddress,
    String toAddress,
    int vehicleTypeId,
    int cityId,
    int franchiseId,
    double rateCostPerKM,
    int requestStatus,
    int acceptDriverId,
    String acceptTimeDate,
    String rideStartTime,
    String rideEndTime,
    String rejectedTimeDate,
    double penaltyAmount,
    double penaltyAmountSattledTimeDate,
    int settleId,
    String uUID,
    int actualMTraveled,
    String franchiseName,
    String cityName,
  }) {
    return DriverRidingRequestById(
      ridingRequestId: ridingRequestId ?? this.ridingRequestId,
      fromLatitude: fromLatitude ?? this.fromLatitude,
      fromLongitude: fromLongitude ?? this.fromLongitude,
      toLatitude: toLatitude ?? this.toLatitude,
      toLongitude: toLongitude ?? this.toLongitude,
      fromAddress: fromAddress ?? this.fromAddress,
      toAddress: toAddress ?? this.toAddress,
      vehicleTypeId: vehicleTypeId ?? this.vehicleTypeId,
      cityId: cityId ?? this.cityId,
      franchiseId: franchiseId ?? this.franchiseId,
      rateCostPerKM: rateCostPerKM ?? this.rateCostPerKM,
      requestStatus: requestStatus ?? this.requestStatus,
      acceptDriverId: acceptDriverId ?? this.acceptDriverId,
      acceptTimeDate: acceptTimeDate ?? this.acceptTimeDate,
      rideStartTime: rideStartTime ?? this.rideStartTime,
      rideEndTime: rideEndTime ?? this.rideEndTime,
      rejectedTimeDate: rejectedTimeDate ?? this.rejectedTimeDate,
      penaltyAmount: penaltyAmount ?? this.penaltyAmount,
      penaltyAmountSattledTimeDate:
          penaltyAmountSattledTimeDate ?? this.penaltyAmountSattledTimeDate,
      settleId: settleId ?? this.settleId,
      uUID: uUID ?? this.uUID,
      actualMTraveled: actualMTraveled ?? this.actualMTraveled,
      franchiseName: franchiseName ?? this.franchiseName,
      cityName: cityName ?? this.cityName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'FromLatitude': fromLatitude,
      'FromLongitude': fromLongitude,
      'ToLatitude': toLatitude,
      'ToLongitude': toLongitude,
      'FromAddress': fromAddress,
      'ToAddress': toAddress,
      'VehicleTypeId': vehicleTypeId,
      'CityId': cityId,
      'FranchiseId': franchiseId,
      'RateCostPerKM': rateCostPerKM,
      'RequestStatus': requestStatus,
      'AcceptDriverId': acceptDriverId,
      'AcceptTimeDate': acceptTimeDate,
      'RideStartTime': rideStartTime,
      'RideEndTime': rideEndTime,
      'RejectedTimeDate': rejectedTimeDate,
      'PenaltyAmount': penaltyAmount,
      'PenaltyAmountSattledTimeDate': penaltyAmountSattledTimeDate,
      'SettleId': settleId,
      'UUID': uUID,
      'ActualMTraveled': actualMTraveled,
      'FranchiseName': franchiseName,
      'CityName': cityName,
    };
  }

  factory DriverRidingRequestById.fromMap(Map<String, dynamic> map) {
    return DriverRidingRequestById(
      fromLatitude: map['FromLatitude'],
      fromLongitude: map['FromLongitude'],
      toLatitude: map['ToLatitude'],
      toLongitude: map['ToLongitude'],
      fromAddress: map['FromAddress'],
      toAddress: map['ToAddress'],
      vehicleTypeId: map['VehicleTypeId'],
      cityId: map['CityId'],
      franchiseId: map['FranchiseId'],
      rateCostPerKM: map['RateCostPerKM'],
      requestStatus: map['RequestStatus'],
      acceptDriverId: map['AcceptDriverId'],
      acceptTimeDate: map['AcceptTimeDate'],
      rideStartTime: map['RideStartTime'],
      rideEndTime: map['RideEndTime'],
      rejectedTimeDate: map['RejectedTimeDate'],
      penaltyAmount: map['PenaltyAmount'],
      penaltyAmountSattledTimeDate: map['PenaltyAmountSattledTimeDate'],
      settleId: map['SettleId'],
      uUID: map['UUID'],
      actualMTraveled: map['ActualMTraveled'],
      franchiseName: map['FranchiseName'],
      cityName: map['CityName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DriverRidingRequestById.fromJson(String source) =>
      DriverRidingRequestById.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DriverRidingRequestById(ridingRequestId: $ridingRequestId, fromLatitude: $fromLatitude, fromLongitude: $fromLongitude, toLatitude: $toLatitude, toLongitude: $toLongitude, fromAddress: $fromAddress, toAddress: $toAddress, vehicleTypeId: $vehicleTypeId, cityId: $cityId, franchiseId: $franchiseId, rateCostPerKM: $rateCostPerKM, requestStatus: $requestStatus, acceptDriverId: $acceptDriverId, acceptTimeDate: $acceptTimeDate, rideStartTime: $rideStartTime, rideEndTime: $rideEndTime, rejectedTimeDate: $rejectedTimeDate, penaltyAmount: $penaltyAmount, penaltyAmountSattledTimeDate: $penaltyAmountSattledTimeDate, settleId: $settleId, uUID: $uUID, actualMTraveled: $actualMTraveled, franchiseName: $franchiseName, cityName: $cityName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DriverRidingRequestById &&
        other.ridingRequestId == ridingRequestId &&
        other.fromLatitude == fromLatitude &&
        other.fromLongitude == fromLongitude &&
        other.toLatitude == toLatitude &&
        other.toLongitude == toLongitude &&
        other.fromAddress == fromAddress &&
        other.toAddress == toAddress &&
        other.vehicleTypeId == vehicleTypeId &&
        other.cityId == cityId &&
        other.franchiseId == franchiseId &&
        other.rateCostPerKM == rateCostPerKM &&
        other.requestStatus == requestStatus &&
        other.acceptDriverId == acceptDriverId &&
        other.acceptTimeDate == acceptTimeDate &&
        other.rideStartTime == rideStartTime &&
        other.rideEndTime == rideEndTime &&
        other.rejectedTimeDate == rejectedTimeDate &&
        other.penaltyAmount == penaltyAmount &&
        other.penaltyAmountSattledTimeDate == penaltyAmountSattledTimeDate &&
        other.settleId == settleId &&
        other.uUID == uUID &&
        other.actualMTraveled == actualMTraveled &&
        other.franchiseName == franchiseName &&
        other.cityName == cityName;
  }

  @override
  int get hashCode {
    return ridingRequestId.hashCode ^
        fromLatitude.hashCode ^
        fromLongitude.hashCode ^
        toLatitude.hashCode ^
        toLongitude.hashCode ^
        fromAddress.hashCode ^
        toAddress.hashCode ^
        vehicleTypeId.hashCode ^
        cityId.hashCode ^
        franchiseId.hashCode ^
        rateCostPerKM.hashCode ^
        requestStatus.hashCode ^
        acceptDriverId.hashCode ^
        acceptTimeDate.hashCode ^
        rideStartTime.hashCode ^
        rideEndTime.hashCode ^
        rejectedTimeDate.hashCode ^
        penaltyAmount.hashCode ^
        penaltyAmountSattledTimeDate.hashCode ^
        settleId.hashCode ^
        uUID.hashCode ^
        actualMTraveled.hashCode ^
        franchiseName.hashCode ^
        cityName.hashCode;
  }

  static List<DriverRidingRequestById> fromMapList(List<dynamic> jsonList) {
    List<DriverRidingRequestById> driverRidingRequestByIdList = List();
    for (var json in jsonList) {
      driverRidingRequestByIdList.add(DriverRidingRequestById.fromMap(json));
    }
    return driverRidingRequestByIdList;
  }
}
