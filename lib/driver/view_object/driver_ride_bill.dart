import 'package:get_smart_ride_cas/api/common/ps_object.dart';

class DriverRideBill extends PsObject<DriverRideBill> {
  int rideBillId;
  int rideRequestId;
  String billTimeDate;
  double billTotalAmount;
  double currentRideAmount;
//  String bill;
  double penaltyAmount;
  double rateCostPerKM;
  String rideStartTime;
  int actualMTraveled;
  DriverRideBill({
    this.rideBillId,
    this.rideRequestId,
    this.billTimeDate,
    this.billTotalAmount,
    this.currentRideAmount,
    this.penaltyAmount,
    this.rateCostPerKM,
    this.rideStartTime,
    this.actualMTraveled,
  });

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }

  @override
  DriverRideBill fromMap(map) {
    if (map != null) {
      return DriverRideBill(
        actualMTraveled: map['ActualMTraveled'],
        billTimeDate: map['BillTimeDate'],
        billTotalAmount: map['BillTotalAmount'],
        currentRideAmount: map['CurrentRideAmount'],
        penaltyAmount: map['PenaltyAmount'],
        rateCostPerKM: map['RateCostPerKM'],
        rideBillId: map['RideBillId'],
        rideRequestId: map['RideRequestId'],
        rideStartTime: map['RideStartTime'],
      );
    } else {
      return null;
    }
  }

  @override
  List<DriverRideBill> fromMapList(List dynamicDataList) {
    final List<DriverRideBill> commentList = <DriverRideBill>[];

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
  Map<String, dynamic> toMap(DriverRideBill object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{
        'ActualMTraveled': object.actualMTraveled,
        'BillTimeDate': object.billTimeDate,
        'BillTotalAmount': object.billTotalAmount,
        'CurrentRideAmount': object.currentRideAmount,
        'PenaltyAmount': object.penaltyAmount,
        'RateCostPerKM': object.rateCostPerKM,
        'RideBillId': object.rideBillId,
        'RideRequestId': object.rideRequestId,
        'RideStartTime': object.rideStartTime
      };

      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>> toMapList(List<DriverRideBill> objectList) {
    final List<Map<String, dynamic>> mapList = <Map<String, dynamic>>[];
    if (objectList != null) {
      for (DriverRideBill data in objectList) {
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
