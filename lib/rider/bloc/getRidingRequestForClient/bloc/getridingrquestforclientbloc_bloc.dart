import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_Riding_List.dart';
import 'package:get_smart_ride_cas/rider/bloc/getRidingRequestForClient/bloc/getRidingRequestRepsitory.dart';

part 'getridingrquestforclientbloc_event.dart';
part 'getridingrquestforclientbloc_state.dart';

class GetridingrquestforclientblocBloc extends Bloc<
    GetridingrquestforclientblocEvent, GetridingrquestforclientblocState> {
  GetridingrquestforclientblocBloc()
      : super(GetridingrquestforclientblocInitial());
  List<DriverRidingModel> driverRdingList;
  GetRidingRequestRepository getRidingRequestRepository =
      GetRidingRequestRepository();

  @override
  Stream<GetridingrquestforclientblocState> mapEventToState(
    GetridingrquestforclientblocEvent event,
  ) async* {
    if (event is GetRidingRequestForClientBlocEvent) {
      yield GetridingrquestforclientblocInitial();
      driverRdingList = await getRidingRequestRepository.loadRidingRequestList(
          event.str1, event.str2, event.str3);
      if (driverRdingList != null) {
        yield GetridingrquestforclientblocLoaded(driverRdingList);
      }
    }
  }
}
