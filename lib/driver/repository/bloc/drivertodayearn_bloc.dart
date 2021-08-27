import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'drivertodayearn_event.dart';
part 'drivertodayearn_state.dart';

class DrivertodayearnBloc extends Bloc<DrivertodayearnEvent, DrivertodayearnState> {
  DrivertodayearnBloc() : super(DrivertodayearnInitial());

  @override
  Stream<DrivertodayearnState> mapEventToState(
    DrivertodayearnEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
