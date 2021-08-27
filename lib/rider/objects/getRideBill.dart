import 'dart:convert';

class GetRideBill {
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
  GetRideBill({
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

  GetRideBill copyWith({
    int rideBillId,
    int rideRequestId,
    String billTimeDate,
    double billTotalAmount,
    double currentRideAmount,
    double penaltyAmount,
    double rateCostPerKM,
    String rideStartTime,
    int actualMTraveled,
  }) {
    return GetRideBill(
      rideBillId: rideBillId ?? this.rideBillId,
      rideRequestId: rideRequestId ?? this.rideRequestId,
      billTimeDate: billTimeDate ?? this.billTimeDate,
      billTotalAmount: billTotalAmount ?? this.billTotalAmount,
      currentRideAmount: currentRideAmount ?? this.currentRideAmount,
      penaltyAmount: penaltyAmount ?? this.penaltyAmount,
      rateCostPerKM: rateCostPerKM ?? this.rateCostPerKM,
      rideStartTime: rideStartTime ?? this.rideStartTime,
      actualMTraveled: actualMTraveled ?? this.actualMTraveled,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'RideBillId': rideBillId,
      'RideRequestId': rideRequestId,
      'BillTimeDate': billTimeDate,
      'BillTotalAmount': billTotalAmount,
      'CurrentRideAmount': currentRideAmount,
      'PenaltyAmount': penaltyAmount,
      'RateCostPerKM': rateCostPerKM,
      'RideStartTime': rideStartTime,
      'ActualMTraveled': actualMTraveled,
    };
  }

  factory GetRideBill.fromMap(Map<String, dynamic> map) {
    return GetRideBill(
      rideBillId: map['RideBillId'],
      rideRequestId: map['RideRequestId'],
      billTimeDate: map['BillTimeDate'],
      billTotalAmount: map['BillTotalAmount'],
      currentRideAmount: map['CurrentRideAmount'],
      penaltyAmount: map['PenaltyAmount'],
      rateCostPerKM: map['RateCostPerKM'],
      rideStartTime: map['RideStartTime'],
      actualMTraveled: map['ActualMTraveled'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GetRideBill.fromJson(String source) =>
      GetRideBill.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GetRideBill(rideBillId: $rideBillId, rideRequestId: $rideRequestId, billTimeDate: $billTimeDate, billTotalAmount: $billTotalAmount, currentRideAmount: $currentRideAmount, penaltyAmount: $penaltyAmount, rateCostPerKM: $rateCostPerKM, rideStartTime: $rideStartTime, actualMTraveled: $actualMTraveled)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetRideBill &&
        other.rideBillId == rideBillId &&
        other.rideRequestId == rideRequestId &&
        other.billTimeDate == billTimeDate &&
        other.billTotalAmount == billTotalAmount &&
        other.currentRideAmount == currentRideAmount &&
        other.penaltyAmount == penaltyAmount &&
        other.rateCostPerKM == rateCostPerKM &&
        other.rideStartTime == rideStartTime &&
        other.actualMTraveled == actualMTraveled;
  }

  @override
  int get hashCode {
    return rideBillId.hashCode ^
        rideRequestId.hashCode ^
        billTimeDate.hashCode ^
        billTotalAmount.hashCode ^
        currentRideAmount.hashCode ^
        penaltyAmount.hashCode ^
        rateCostPerKM.hashCode ^
        rideStartTime.hashCode ^
        actualMTraveled.hashCode;
  }

  static List<GetRideBill> fromMapList(List<dynamic> jsonList) {
    List<GetRideBill> rideBillList = List();
    for (var json in jsonList) {
      rideBillList.add(GetRideBill.fromMap(json));
    }
    return rideBillList;
  }
}
