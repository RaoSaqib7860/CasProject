import 'dart:convert';

class DriverRidingModel {
  int myId;
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
  String rejectionBy;
  double penaltyAmount;
  dynamic penaltyAmountSattledTimeDate;
  dynamic settleId;
  String uUID;
  int actualMTraveled;
  String franchiseName;
  String cityName;
  String ridingClientName;
  String ridingClientPhoneNumber;
  String requestTimeDate;
  DriverRidingModel({
    this.myId,
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
    this.rejectionBy,
    this.rideEndTime,
    this.rejectedTimeDate,
    this.penaltyAmount,
    this.penaltyAmountSattledTimeDate,
    this.settleId,
    this.uUID,
    this.actualMTraveled,
    this.franchiseName,
    this.cityName,
    this.ridingClientName,
    this.ridingClientPhoneNumber,
    this.requestTimeDate,
  });

  DriverRidingModel copyWith({
    int myId,
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
    String rejectionBy,
    double penaltyAmount,
    dynamic penaltyAmountSattledTimeDate,
    dynamic settleId,
    String uUID,
    int actualMTraveled,
    String franchiseName,
    String cityName,
    String ridingClientName,
    String ridingClientPhoneNumber,
    String requestTimeDate,
  }) {
    return DriverRidingModel(
      myId: myId ?? this.myId,
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
      rejectionBy: rejectionBy ?? this.rejectionBy,
      penaltyAmount: penaltyAmount ?? this.penaltyAmount,
      penaltyAmountSattledTimeDate:
          penaltyAmountSattledTimeDate ?? this.penaltyAmountSattledTimeDate,
      settleId: settleId ?? this.settleId,
      uUID: uUID ?? this.uUID,
      actualMTraveled: actualMTraveled ?? this.actualMTraveled,
      franchiseName: franchiseName ?? this.franchiseName,
      cityName: cityName ?? this.cityName,
      ridingClientName: ridingClientName ?? this.ridingClientName,
      ridingClientPhoneNumber:
          ridingClientPhoneNumber ?? this.ridingClientPhoneNumber,
      requestTimeDate: requestTimeDate ?? this.requestTimeDate,
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
      "RejectionBy": rejectionBy,
      'PenaltyAmount': penaltyAmount,
      'PenaltyAmountSattledTimeDate': penaltyAmountSattledTimeDate,
      'SettleId': settleId,
      'UUID': uUID,
      'ActualMTraveled': actualMTraveled,
      'FranchiseName': franchiseName,
      'CityName': cityName,
      'MyId': myId,
      'RidingClientName': ridingClientName,
      'RidingClientPhoneNumber': ridingClientPhoneNumber,
      'RequestTimeDate': requestTimeDate,
      'RidingRequestId': ridingRequestId
    };
  }

  factory DriverRidingModel.fromMap(Map<String, dynamic> map) {
    return DriverRidingModel(
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
        rejectionBy: map['RejectionBy'],
        penaltyAmount: map['PenaltyAmount'],
        penaltyAmountSattledTimeDate: map['PenaltyAmountSattledTimeDate'],
        settleId: map['SettleId'],
        uUID: map['UUID'],
        actualMTraveled: map['ActualMTraveled'],
        franchiseName: map['FranchiseName'],
        cityName: map['CityName'],
        myId: map["MyId"],
        requestTimeDate: map['RequestTimeDate'],
        ridingClientName: map['RidingClientName'],
        ridingClientPhoneNumber: map['RidingClientPhoneNumber'],
        ridingRequestId: map['RidingRequestId']);
  }

  String toJson() => json.encode(toMap());

  factory DriverRidingModel.fromJson(String source) =>
      DriverRidingModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DriverRidingModel(myId: $myId, ridingRequestId: $ridingRequestId, fromLatitude: $fromLatitude, fromLongitude: $fromLongitude, toLatitude: $toLatitude, toLongitude: $toLongitude, fromAddress: $fromAddress, toAddress: $toAddress, vehicleTypeId: $vehicleTypeId, cityId: $cityId, franchiseId: $franchiseId, rateCostPerKM: $rateCostPerKM, requestStatus: $requestStatus, acceptDriverId: $acceptDriverId, acceptTimeDate: $acceptTimeDate, rideStartTime: $rideStartTime, rideEndTime: $rideEndTime, rejectedTimeDate: $rejectedTimeDate, penaltyAmount: $penaltyAmount, penaltyAmountSattledTimeDate: $penaltyAmountSattledTimeDate, settleId: $settleId, uUID: $uUID, actualMTraveled: $actualMTraveled, franchiseName: $franchiseName, cityName: $cityName, ridingClientName: $ridingClientName, ridingClientPhoneNumber: $ridingClientPhoneNumber, requestTimeDate: $requestTimeDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DriverRidingModel &&
        other.myId == myId &&
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
        other.cityName == cityName &&
        other.ridingClientName == ridingClientName &&
        other.ridingClientPhoneNumber == ridingClientPhoneNumber &&
        other.requestTimeDate == requestTimeDate;
  }

  @override
  int get hashCode {
    return myId.hashCode ^
        ridingRequestId.hashCode ^
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
        cityName.hashCode ^
        ridingClientName.hashCode ^
        ridingClientPhoneNumber.hashCode ^
        requestTimeDate.hashCode;
  }

  static List<DriverRidingModel> fromMapList(List<dynamic> jsonList) {
    List<DriverRidingModel> ridingList = List();
    for (var json in jsonList) {
      ridingList.add(DriverRidingModel.fromMap(json));
    }
    return ridingList;
  }
}
