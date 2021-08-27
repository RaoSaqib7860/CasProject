import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_smart_ride_cas/api/common/ps_resource.dart';
import 'package:get_smart_ride_cas/api/driver_api/driver_api_services.dart';
import 'package:get_smart_ride_cas/driver/repository/driver_FromTo_day_Earning/DriverFomToDayEarningRepository.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_today_earnings.dart';

part 'driverfromtodayearning_event.dart';
part 'driverfromtodayearning_state.dart';

class DriverfromtodayearningBloc
    extends Bloc<DriverFromTodayEarningEvent, DriverfromToDayEarningState> {
  DriverfromtodayearningBloc() : super(DriverfromtodayearningInitial());

  PsResource<List<DriverTodayEarning>> getFromTodayEarningList;
  ApiServices _api = ApiServices();
  @override
  Stream<DriverfromToDayEarningState> mapEventToState(
    DriverFromTodayEarningEvent event,
  ) async* {
    if (event is DriverfromToDayEaringLoadedEvent) {
      yield DriverfromtodayearningInitial();

      getFromTodayEarningList =
          await _api.getDriverFromToTotalEarning(event.map);

      print("=======bloc List -------${getFromTodayEarningList.data.length}");
      if (getFromTodayEarningList != null) {
        yield DriverFromTodayEarningLoadedState(list: getFromTodayEarningList);
      }
    }
  }
}
