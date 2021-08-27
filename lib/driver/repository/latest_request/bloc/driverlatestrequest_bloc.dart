import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_all_riding_list.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_riding_request.dart';
import 'package:meta/meta.dart';

part 'driverlatestrequest_event.dart';
part 'driverlatestrequest_state.dart';

class DriverlatestRequestBloc
    extends Bloc<DriverlatestRequestEvent, DriverlatestRequestState> {
  DriverlatestRequestBloc() : super(DriverLatestRequestInitialState());

  List<int> _list = List();

  bool notified;

  @override
  Stream<DriverlatestRequestState> mapEventToState(
    DriverlatestRequestEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
