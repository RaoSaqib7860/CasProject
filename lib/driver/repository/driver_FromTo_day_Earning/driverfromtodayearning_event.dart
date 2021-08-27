part of 'driverfromtodayearning_bloc.dart';

abstract class DriverFromTodayEarningEvent extends Equatable {
  const DriverFromTodayEarningEvent();

  @override
  List<Object> get props => [];
}

class DriverfromToDayEaringLoadedEvent extends DriverFromTodayEarningEvent {
  Map<String, dynamic> map;
  DriverfromToDayEaringLoadedEvent({
    this.map,
  });
}
