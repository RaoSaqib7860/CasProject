import 'package:get_smart_ride_cas/api/common/ps_object.dart';

class DistanceCostVehicleVise extends PsObject<DistanceCostVehicleVise> {
  int distanceCostId;
  double costPerKM;

  @override
  String getPrimaryKey() {
    return '0';
  }

  @override
  DistanceCostVehicleVise fromMap(dynamicData) {
    if (dynamicData != null) {
      return DistanceCostVehicleVise(
        distanceCostId: dynamicData['DistanceCostId'],
        costPerKM: dynamicData['CostPerKM'],
      );
    } else {
      return null;
    }
  }

  @override
  List<DistanceCostVehicleVise> fromMapList(List dynamicDataList) {
    final List<DistanceCostVehicleVise> commentList =
        <DistanceCostVehicleVise>[];

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
  Map<String, dynamic> toMap(DistanceCostVehicleVise object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{
        'DistanceCostId': object.distanceCostId,
        'CostPerKM': object.costPerKM,
      };

      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>> toMapList(
      List<DistanceCostVehicleVise> objectList) {
    final List<Map<String, dynamic>> mapList = <Map<String, dynamic>>[];
    if (objectList != null) {
      for (DistanceCostVehicleVise data in objectList) {
        if (data != null) {
          mapList.add(toMap(data));
        }
      }
    }

    return mapList;
  }

  DistanceCostVehicleVise({
    this.distanceCostId,
    this.costPerKM,
  });
}
