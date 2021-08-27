import 'package:get_smart_ride_cas/api/common/ps_object.dart';

class DriverTodayEarning extends PsObject<DriverTodayEarning> {
  int rideBillId;
  int rideRequestId;
  String billTimeDate;
  double billTotalAmount;
  double currentRideAmount;
  double penaltyAmount;
  int status;
  String ridingClientName;
  String ridingClientPhoneNumber;
  String rideStartTime;
  String rideEndTime;
  DriverTodayEarning({
    this.rideBillId,
    this.rideRequestId,
    this.billTimeDate,
    this.billTotalAmount,
    this.currentRideAmount,
    this.penaltyAmount,
    this.status,
    this.ridingClientName,
    this.ridingClientPhoneNumber,
    this.rideStartTime,
    this.rideEndTime,
  });
  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }

  @override
  DriverTodayEarning fromMap(map) {
    if (map != null) {
      return DriverTodayEarning(
        billTimeDate: map['BillTimeDate'],
        billTotalAmount: map['BillTotalAmount'],
        penaltyAmount: map['PenaltyAmount'],
        currentRideAmount: map['CurrentRideAmount'],
        rideBillId: map['RideBillId'],
        rideEndTime: map['RideEndTime'],
        rideRequestId: map['RideRequestId'],
        rideStartTime: map['RideStartTime'],
        ridingClientName: map['RidingClientName'],
        ridingClientPhoneNumber: map['RidingClientPhoneNumber'],
        status: map['Status'],
      );
    } else {
      return null;
    }
  }

  @override
  List<DriverTodayEarning> fromMapList(List dynamicDataList) {
    final List<DriverTodayEarning> commentList = <DriverTodayEarning>[];

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
  Map<String, dynamic> toMap(DriverTodayEarning object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{
        'BillTimeDate': object.billTimeDate,
        'BillTotalAmount': object.billTotalAmount,
        'PenaltyAmount': object.penaltyAmount,
        'CurrentRideAmount': object.currentRideAmount,
        'RideBillId': object.rideBillId,
        'RideEndTime': object.rideEndTime,
        'RideRequestId': object.rideRequestId,
        'RideStartTime': object.rideStartTime,
        'RidingClientName': object.ridingClientName,
        'RidingClientPhoneNumber': object.ridingClientPhoneNumber,
        'Status': object.status
      };

      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>> toMapList(List<DriverTodayEarning> objectList) {
    final List<Map<String, dynamic>> mapList = <Map<String, dynamic>>[];
    if (objectList != null) {
      for (DriverTodayEarning data in objectList) {
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
