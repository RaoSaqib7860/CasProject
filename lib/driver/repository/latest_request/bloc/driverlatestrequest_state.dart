part of 'driverlatestrequest_bloc.dart';

@immutable
abstract class DriverlatestRequestState {}

class DriverLatestRequestInitialState extends DriverlatestRequestState {}

// ignore: must_be_immutable
class DriverlatestRequestLoadedState extends DriverlatestRequestState {
  List<DriverRidingRequestById> list;
  bool seen;
  DriverlatestRequestLoadedState({
    this.list,
    this.seen,
  });
}
