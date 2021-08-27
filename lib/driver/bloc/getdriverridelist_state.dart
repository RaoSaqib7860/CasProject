part of 'getdriverridelist_bloc.dart';

abstract class GetDriverRideListState extends Equatable {
  const GetDriverRideListState();

  @override
  List<Object> get props => [];
}

class GetDiverRideListInitialState extends GetDriverRideListState {}

class GetDriverRideListLoadedState extends GetDriverRideListState {
  List<DriverAllRidingRequest> resource = List();
  DriverAllRidingRequest model;

  bool islist;
  GetDriverRideListLoadedState({
    this.resource,
    this.model,
    this.islist,
  });
}
