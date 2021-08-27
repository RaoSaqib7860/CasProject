part of 'driverfromtodayearning_bloc.dart';

abstract class DriverfromToDayEarningState extends Equatable {
  const DriverfromToDayEarningState();

  @override
  List<Object> get props => [];
}

class DriverfromtodayearningInitial extends DriverfromToDayEarningState {}

class DriverFromTodayEarningLoadedState extends DriverfromToDayEarningState {
  PsResource<List<DriverTodayEarning>> list;
  DriverFromTodayEarningLoadedState({
    this.list,
  });
}
