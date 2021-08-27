import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_smart_ride_cas/rider/bloc/getRidingRequestForClient/bloc/getDriverDataBloc/bloc/getDriverDataRepository.dart';
import 'package:get_smart_ride_cas/rider/objects/getDriverData.dart';

part 'getdriverdata_event.dart';
part 'getdriverdata_state.dart';

class GetdriverdataBloc extends Bloc<GetdriverdataEvent, GetdriverdataState> {
  GetdriverdataBloc() : super(GetdriverdataInitial());
  List<GetDriverData> getDriverDataList;
  GetDriverDataRepository getDriverDataRepository = GetDriverDataRepository();
  static GetdriverdataBloc driverDataBloc;
  static GetdriverdataBloc getDriverDataBlocInstance() {
    if (driverDataBloc == null) {
      driverDataBloc = GetdriverdataBloc();
    }
    return driverDataBloc;
  }

  @override
  Stream<GetdriverdataState> mapEventToState(
    GetdriverdataEvent event,
  ) async* {
    if (event is GetdriverdataInsertEvent) {
      yield GetdriverdataInitial();
      getDriverDataList =
          await getDriverDataRepository.loadDriverDataList(event.driverId);
      if (getDriverDataList != null) {
        yield GetDriverDataLoadedState(
            driverDataList: getDriverDataList,
            rideRequestID: event.rideRequestId);
      }
    }
    if (event is GetdriverdataEmptyListEvent) {
      if (getDriverDataList != null) {
        getDriverDataList = null;
      }
      yield GetDriverDataEmptyState();
      print("DRIVER LIST IN BLOCCC ..........$getDriverDataList");
    }
    // TODO: implement mapEventToState
  }
}
