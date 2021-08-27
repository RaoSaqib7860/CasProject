part of 'driverprofile_bloc.dart';

abstract class DriverprofileEvent extends Equatable {
  const DriverprofileEvent();

  @override
  List<Object> get props => [];
}

class DriverProfileSetEvent extends DriverprofileEvent {
  List<DriverProfileModel> model;

  Map<String, dynamic> map;
  DriverProfileSetEvent({this.model, this.map});
}
