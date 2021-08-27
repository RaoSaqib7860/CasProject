import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_smart_ride_cas/api/common/ps_resource.dart';
import 'package:get_smart_ride_cas/api/driver_api/driver_api_services.dart';
import 'package:get_smart_ride_cas/api/rider_api/rider_api_services.dart';
import 'package:get_smart_ride_cas/rider/objects/GetDistanceCostVechicleVise.dart';

part 'getdistancecostvehiclewise_event.dart';
part 'getdistancecostvehiclewise_state.dart';

class GetdistancecostvehiclewiseBloc extends Bloc<
    GetdistancecostvehiclewiseEvent, GetdistancecostvehiclewiseState> {
  GetdistancecostvehiclewiseBloc() : super(GetdistancecostvehiclewiseInitial());
  RiderApiServices _apiServices = RiderApiServices();

  List<DistanceCostVehicleVise> _list = List();
  @override
  Stream<GetdistancecostvehiclewiseState> mapEventToState(
    GetdistancecostvehiclewiseEvent event,
  ) async* {
    if (event is GetdistancecostvehiclewiseInsertEvent) {
      yield GetdistancecostvehiclewiseInitial();
      PsResource<List<DistanceCostVehicleVise>> resourceList =
          await _apiServices.getDistanceCostVehicleVise(event.map);
      if (resourceList != null) {
        yield GetdistancecostvehiclewiseLoadedState(resourceList);
        //    print("RESOURCE LIST.......................${resourceList.data}");
      }
    }
  }
}
