part of 'getdistancecostvehiclewise_bloc.dart';

abstract class GetdistancecostvehiclewiseState extends Equatable {
  const GetdistancecostvehiclewiseState();

  @override
  List<Object> get props => [];
}

class GetdistancecostvehiclewiseInitial
    extends GetdistancecostvehiclewiseState {}

class GetdistancecostvehiclewiseLoadedState
    extends GetdistancecostvehiclewiseState {
  final PsResource<List<DistanceCostVehicleVise>> resource;

  GetdistancecostvehiclewiseLoadedState(this.resource);
}
