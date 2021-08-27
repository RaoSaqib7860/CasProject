import 'dart:convert';

import 'package:get_smart_ride_cas/api/common/ps_object.dart';

class RiderPenalty {
  int driverAccessabilitySettingId;
  int responseTimeDuration;
  double penaltyCharges;
  RiderPenalty({
    this.driverAccessabilitySettingId,
    this.responseTimeDuration,
    this.penaltyCharges,
  });

  // @override
  // RiderPenalty fromMap(dynamicData) {
  //   if (dynamicData != null) {
  //     return RiderPenalty(
  //       driverAccessabilitySettingId:
  //           dynamicData['DriverAccessabilitySettingId'],
  //       penaltyCharges: dynamicData['PenaltyCharges'],
  //       responseTimeDuration: dynamicData['ResponseTimeDuration'],
  //     );
  //   } else {
  //     return null;
  //   }
  // }

  // @override
  // List<RiderPenalty> fromMapList(List dynamicDataList) {
  //   final List<RiderPenalty> commentList = <RiderPenalty>[];

  //   if (dynamicDataList != null) {
  //     for (dynamic dynamicData in dynamicDataList) {
  //       if (dynamicData != null) {
  //         commentList.add(fromMap(dynamicData));
  //       }
  //     }
  //   }
  //   return commentList;
  // }

  // @override
  // Map<String, dynamic> toMap(RiderPenalty object) {
  //   if (object != null) {
  //     final Map<String, dynamic> data = <String, dynamic>{
  //       'ResponseTimeDuration': object.responseTimeDuration,
  //       'PenaltyCharges': object.penaltyCharges,
  //       'DriverAccessabilitySettingId': object.driverAccessabilitySettingId,
  //     };

  //     return data;
  //   } else {
  //     return null;
  //   }
  // }

  // @override
  // List<Map<String, dynamic>> toMapList(List<RiderPenalty> objectList) {
  //   final List<Map<String, dynamic>> mapList = <Map<String, dynamic>>[];
  //   if (objectList != null) {
  //     for (RiderPenalty data in objectList) {
  //       if (data != null) {
  //         mapList.add(toMap(data));
  //       }
  //     }
  //   }

  //   return mapList;
  // }

  // @override
  // String getPrimaryKey() {
  //   // TODO: implement getPrimaryKey
  //   throw UnimplementedError();
  // }

  // RiderPenalty(
  //     {this.driverAccessabilitySettingId,
  //     this.responseTimeDuration,
  //     this.penaltyCharges});

  RiderPenalty copyWith({
    int driverAccessabilitySettingId,
    int responseTimeDuration,
    double penaltyCharges,
  }) {
    return RiderPenalty(
      driverAccessabilitySettingId:
          driverAccessabilitySettingId ?? this.driverAccessabilitySettingId,
      responseTimeDuration: responseTimeDuration ?? this.responseTimeDuration,
      penaltyCharges: penaltyCharges ?? this.penaltyCharges,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'DriverAccessabilitySettingId': driverAccessabilitySettingId,
      'ResponseTimeDuration': responseTimeDuration,
      'PenaltyCharges': penaltyCharges,
    };
  }

  factory RiderPenalty.fromMap(Map<String, dynamic> map) {
    return RiderPenalty(
      driverAccessabilitySettingId: map['DriverAccessabilitySettingId'],
      responseTimeDuration: map['ResponseTimeDuration'],
      penaltyCharges: map['PenaltyCharges'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RiderPenalty.fromJson(String source) =>
      RiderPenalty.fromMap(json.decode(source));

  @override
  String toString() =>
      'RiderPenalty(driverAccessabilitySettingId: $driverAccessabilitySettingId, responseTimeDuration: $responseTimeDuration, penaltyCharges: $penaltyCharges)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RiderPenalty &&
        other.driverAccessabilitySettingId == driverAccessabilitySettingId &&
        other.responseTimeDuration == responseTimeDuration &&
        other.penaltyCharges == penaltyCharges;
  }

  @override
  int get hashCode =>
      driverAccessabilitySettingId.hashCode ^
      responseTimeDuration.hashCode ^
      penaltyCharges.hashCode;

  static List<RiderPenalty> fromMapList(List<dynamic> jsonList) {
    List<RiderPenalty> riderpenality = List();
    for (var json in jsonList) {
      riderpenality.add(RiderPenalty.fromMap(json));
    }
    return riderpenality;
  }
}
