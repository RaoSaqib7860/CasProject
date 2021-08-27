part of 'driverinitialrequirements_bloc.dart';

@immutable
abstract class DriverInitialRequirementsState {
  DriverInitialRequirementsState();
}

class DriverLoadingRequirementsState extends DriverInitialRequirementsState {}

class DriverLoadRequirementsState extends DriverInitialRequirementsState {
  PsResource<DriverLoginResponse> resource;

  DriverLoadRequirementsState({this.resource});
}
