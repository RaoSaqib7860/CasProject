import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_smart_ride_cas/rider/objects/penalty.dart';

import 'getPenaltyRepository.dart';

part 'getpenalty_event.dart';
part 'getpenalty_state.dart';

class GetpenaltyBloc extends Bloc<GetpenaltyEvent, GetpenaltyState> {
  GetpenaltyBloc() : super(GetpenaltyInitial());

  List<RiderPenalty> riderPenaltyList = List();
  GetRiderPenaltyRepository getRiderPenaltyRepository =
      GetRiderPenaltyRepository();

  @override
  Stream<GetpenaltyState> mapEventToState(
    GetpenaltyEvent event,
  ) async* {
    if (event is GetPenaltyInsertEvent) {
      yield GetpenaltyInitial();
      riderPenaltyList = await getRiderPenaltyRepository
          .loadRiderPenaltyList(event.ridingRequestId);
      print("/////////////${riderPenaltyList.length}");
      if (riderPenaltyList != null) {
        yield GetPenaltyLoadedState(riderPenaltyList: riderPenaltyList);
      }
    }
  }
}
