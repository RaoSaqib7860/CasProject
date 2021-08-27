import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_smart_ride_cas/api/common/ps_resource.dart';
import 'package:get_smart_ride_cas/api/driver_api/driver_api_services.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_profile.dart';

part 'driverprofile_event.dart';
part 'driverprofile_state.dart';

class DriverprofileBloc extends Bloc<DriverprofileEvent, DriverProfileState> {
  DriverprofileBloc() : super(DriverProfileInitialState());
  ApiServices _apiServices = ApiServices();

  PsResource<List<DriverProfileModel>> list;
  @override
  Stream<DriverProfileState> mapEventToState(
    DriverprofileEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is DriverProfileSetEvent) {
      yield DriverProfileInitialState();
      list = await _apiServices.getDriverProfileData(event.map);

      if (list != null) {
        yield DriverProfileLoadedState(model: list);
      }
    }
  }
}
