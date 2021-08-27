import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'penaltyafteraccept_event.dart';
part 'penaltyafteraccept_state.dart';

class PenaltyafteracceptBloc extends Bloc<PenaltyafteracceptEvent, PenaltyafteracceptState> {
  PenaltyafteracceptBloc() : super(PenaltyafteracceptInitial());

  @override
  Stream<PenaltyafteracceptState> mapEventToState(
    PenaltyafteracceptEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
