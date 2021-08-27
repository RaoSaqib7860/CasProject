part of 'driverlatestrequest_bloc.dart';

@immutable
abstract class DriverlatestRequestEvent extends Equatable {
  @override

  List<Object> get props => throw UnimplementedError();
}

// ignore: must_be_immutable
class DriverComingRideRequestEvent extends DriverlatestRequestEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

  List<DriverRidingRequestById> list;
  bool seen;
  DriverComingRideRequestEvent({
    this.list,
    this.seen,
  });
}
