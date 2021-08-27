import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_smart_ride_cas/api/common/ps_resource.dart';
import 'package:get_smart_ride_cas/api/driver_api/driver_api_services.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_all_riding_list.dart';

part 'getdriverridelist_event.dart';
part 'getdriverridelist_state.dart';

class GetdriverridelistBloc
    extends Bloc<GetdRiveRrideListEvent, GetDriverRideListState> {
  GetdriverridelistBloc() : super(GetDiverRideListInitialState());
  ApiServices _apiServices = ApiServices();
  PsResource<List<DriverAllRidingRequest>> resourceList;
  @override
  Stream<GetDriverRideListState> mapEventToState(
    GetdRiveRrideListEvent event,
  ) async* {
    // TODO: implement mapEventToState
    //
    if (event is GetAllDriverRideListEvent) {
      yield GetDiverRideListInitialState();

      print("===== Bloc Event is Trigger ===== ");
      resourceList = await _apiServices.getDriverAllRidingList(event.map);
      print(" List size ---------${resourceList.data}");
      if (resourceList != null) {
        yield GetDriverRideListLoadedState(
          resource: resourceList.data,
        );
      } else {
        print("Error in state ");
        //  yield GetDriverRideListLoadedState(resource: resource);
      }
    }
  }
}
