import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_smart_ride_cas/api/common/ps_resource.dart';
import 'package:get_smart_ride_cas/api/driver_api/driver_api_services.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_login_reponse.dart';
import 'package:meta/meta.dart';

part 'driverinitialrequirements_event.dart';
part 'driverinitialrequirements_state.dart';

class DriverinitialrequirementsBloc extends Bloc<DriverInitialRequirementsEvent,
    DriverInitialRequirementsState> {
  DriverinitialrequirementsBloc() : super(DriverLoadingRequirementsState());

  @override
  Stream<DriverInitialRequirementsState> mapEventToState(
    DriverInitialRequirementsEvent event,
  ) async* {
    // TODO: implement mapEventToState

    if (event is InsertModel) {
      yield DriverLoadingRequirementsState();

      ApiServices _api = ApiServices();
      PsResource<DriverLoginResponse> _resource =
          await _api.driverLogin(event.map);

      if (_resource != null) {
        print("Resource Model Bloc------${_resource.data.status}");
        yield DriverLoadRequirementsState(resource: _resource);
      }
      //  yield DriverLoadRequirementsState(resource: _resource);
    }
  }
}
