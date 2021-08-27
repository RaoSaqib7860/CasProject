part of 'getdriverdata_bloc.dart';

abstract class GetdriverdataEvent extends Equatable {
  const GetdriverdataEvent();

  @override
  List<Object> get props => [];
}

class GetdriverdataInsertEvent extends GetdriverdataEvent {
  final int driverId;
  final int rideRequestId;
  GetdriverdataInsertEvent({this.driverId, this.rideRequestId});
}

class GetdriverdataEmptyListEvent extends GetdriverdataEvent {
//   final int driverId;
// final int rideRequestId;
  // GetdriverdataEmptyListEvent();
}
