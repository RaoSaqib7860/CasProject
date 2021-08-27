import 'package:get_smart_ride_cas/api/common/ps_object.dart';

class DriverPenalty extends PsObject<DriverPenalty> {
  int driverAccessabilitySettingId;
  int responseTimeDuration;
  double penaltyCharges;

  @override
  DriverPenalty fromMap(dynamicData) {
    if (dynamicData != null) {
      return DriverPenalty(
        driverAccessabilitySettingId:
            dynamicData['DriverAccessabilitySettingId'],
        penaltyCharges: dynamicData['PenaltyCharges'],
        responseTimeDuration: dynamicData['ResponseTimeDuration'],
      );
    } else {
      return null;
    }
  }

  @override
  List<DriverPenalty> fromMapList(List dynamicDataList) {
    final List<DriverPenalty> commentList = <DriverPenalty>[];

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
  Map<String, dynamic> toMap(DriverPenalty object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{
        'ResponseTimeDuration': object.responseTimeDuration,
        'PenaltyCharges': object.penaltyCharges,
        'DriverAccessabilitySettingId': object.driverAccessabilitySettingId,
      };

      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>> toMapList(List<DriverPenalty> objectList) {
    final List<Map<String, dynamic>> mapList = <Map<String, dynamic>>[];
    if (objectList != null) {
      for (DriverPenalty data in objectList) {
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

  DriverPenalty(
      {this.driverAccessabilitySettingId,
      this.responseTimeDuration,
      this.penaltyCharges});
}
