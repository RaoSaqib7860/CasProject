import 'package:get_smart_ride_cas/api/common/ps_object.dart';

class DriverAllRidingRequest extends PsObject<DriverAllRidingRequest> {
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
  String requestTimeDate;
  int requestStatus;
  int acceptDriverId;
  String acceptTimeDate;
  dynamic rideStartTime;
  dynamic rideEndTime;
  String rejectedTimeDate;
  double penaltyAmount;
  dynamic penaltyAmountSattledTimeDate;
  dynamic settleId;
  String uUID;
  int actualMTraveled;
  String franchiseName;
  String cityName;
  String ridingClientName;
  String ridingClientPhoneNumber;
  int clientId;
  DriverAllRidingRequest(
      {this.fromLatitude,
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
      this.myId,
      this.requestTimeDate,
      this.ridingClientName,
      this.ridingClientPhoneNumber,
      this.ridingRequestId,
      this.clientId});

  @override
  String toString() {
    return 'DriverRidingRequest(FromLatitude: $fromLatitude, FromLongitude: $fromLongitude, ToLatitude: $toLatitude, ToLongitude: $toLongitude, FromAddress: $fromAddress, ToAddress: $toAddress, VehicleTypeId: $vehicleTypeId, CityId: $cityId, FranchiseId: $franchiseId, RateCostPerKM: $rateCostPerKM, RequestStatus: $requestStatus, AcceptDriverId: $acceptDriverId, AcceptTimeDate: $acceptTimeDate, RideStartTime: $rideStartTime, RideEndTime: $rideEndTime, RejectedTimeDate: $rejectedTimeDate, PenaltyAmount: $penaltyAmount, PenaltyAmountSattledTimeDate: $penaltyAmountSattledTimeDate, SettleId: $settleId, UUID: $uUID, ActualMTraveled: $actualMTraveled, FranchiseName: $franchiseName, CityName: $cityName)';
  }

  @override
  DriverAllRidingRequest fromMap(map) {
    if (map != null) {
      return DriverAllRidingRequest(
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
          myId: map["MyId"],
          requestTimeDate: map['RequestTimeDate'],
          ridingClientName: map['RidingClientName'],
          ridingClientPhoneNumber: map['RidingClientPhoneNumber'],
          ridingRequestId: map['RidingRequestId'],
          clientId: map['ClientId']);
    } else {
      return null;
    }
  }

  @override
  List<DriverAllRidingRequest> fromMapList(List dynamicDataList) {
    final List<DriverAllRidingRequest> commentList = <DriverAllRidingRequest>[];

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
  Map<String, dynamic> toMap(DriverAllRidingRequest object) {
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
        'MyId': myId,
        'RidingClientName': ridingClientName,
        'RidingClientPhoneNumber': ridingClientPhoneNumber,
        'RequestTimeDate': requestTimeDate,
        'RidingRequestId': ridingRequestId,
        'ClientId': clientId
      };

      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>> toMapList(
      List<DriverAllRidingRequest> objectList) {
    final List<Map<String, dynamic>> mapList = <Map<String, dynamic>>[];
    if (objectList != null) {
      for (DriverAllRidingRequest data in objectList) {
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
