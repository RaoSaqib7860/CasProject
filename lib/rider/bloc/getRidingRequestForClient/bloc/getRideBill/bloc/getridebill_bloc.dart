import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_smart_ride_cas/rider/bloc/getRidingRequestForClient/bloc/getRideBill/getRideBillRepository.dart';
import 'package:get_smart_ride_cas/rider/objects/getRideBill.dart';

part 'getridebill_event.dart';
part 'getridebill_state.dart';

class GetridebillBloc extends Bloc<GetridebillEvent, GetridebillState> {
  GetridebillBloc() : super(GetridebillInitial());
  List<GetRideBill> getRideBillList;
  GetRideBillRepository getRideBillRepository = GetRideBillRepository();

  @override
  Stream<GetridebillState> mapEventToState(
    GetridebillEvent event,
  ) async* {
    if (event is GetRideBillInsertEvent) {
      yield GetridebillInitial();
      getRideBillList = await getRideBillRepository
          .loadGetRideBillList(event.ridingRequestId);
      if (getRideBillList != null) {
        yield GetRideBillLoadedState(getRideBillList);
        print("LOADED STATETE,....................");
      }
    }
    // TODO: implement mapEventToState
  }
}
