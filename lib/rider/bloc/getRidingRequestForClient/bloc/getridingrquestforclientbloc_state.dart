part of 'getridingrquestforclientbloc_bloc.dart';

abstract class GetridingrquestforclientblocState extends Equatable {
  const GetridingrquestforclientblocState();

  @override
  List<Object> get props => [];
}

class GetridingrquestforclientblocInitial
    extends GetridingrquestforclientblocState {}

class GetridingrquestforclientblocLoaded
    extends GetridingrquestforclientblocState {
  final List<DriverRidingModel> driverRidingList;
  @override
  List<Object> get props => driverRidingList;

  GetridingrquestforclientblocLoaded(this.driverRidingList);
}
