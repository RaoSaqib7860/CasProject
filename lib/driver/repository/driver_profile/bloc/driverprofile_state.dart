part of 'driverprofile_bloc.dart';

abstract class DriverProfileState extends Equatable {
  const DriverProfileState();

  @override
  List<Object> get props => [];
}

class DriverProfileInitialState extends DriverProfileState {}

class DriverProfileLoadedState extends DriverProfileState {
  PsResource<List<DriverProfileModel>> model;
  DriverProfileLoadedState({
    this.model,
  });
}
