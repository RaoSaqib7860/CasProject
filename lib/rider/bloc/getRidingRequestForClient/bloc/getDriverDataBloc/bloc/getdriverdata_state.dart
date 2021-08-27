part of 'getdriverdata_bloc.dart';

abstract class GetdriverdataState extends Equatable {
  const GetdriverdataState();

  @override
  List<Object> get props => [];
}

class GetdriverdataInitial extends GetdriverdataState {}

class GetDriverDataLoadedState extends GetdriverdataState {
  final List<GetDriverData> driverDataList;
  final int rideRequestID;
  @override
  List<Object> get props => driverDataList;

  GetDriverDataLoadedState({this.driverDataList, this.rideRequestID});
}

class GetDriverDataEmptyState extends GetdriverdataState {
  @override
  List<Object> get props => [];

  GetDriverDataEmptyState();
}
