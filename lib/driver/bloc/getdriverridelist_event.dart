part of 'getdriverridelist_bloc.dart';

abstract class GetdRiveRrideListEvent extends Equatable {
  const GetdRiveRrideListEvent();

  @override
  List<Object> get props => [];
}

class GetAllDriverRideListEvent extends GetdRiveRrideListEvent {
  List<DriverAllRidingRequest> list;
  DriverAllRidingRequest model;
  Map<String, dynamic> map;
  int rideRequestId;
  bool islist;
  GetAllDriverRideListEvent(
      {this.list, this.model, this.islist, this.map, this.rideRequestId});
}
