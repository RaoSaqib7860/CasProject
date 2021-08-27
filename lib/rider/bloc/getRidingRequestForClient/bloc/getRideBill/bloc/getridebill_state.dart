part of 'getridebill_bloc.dart';

abstract class GetridebillState extends Equatable {
  const GetridebillState();

  @override
  List<Object> get props => [];
}

class GetridebillInitial extends GetridebillState {}

class GetRideBillLoadedState extends GetridebillState {
  final List<GetRideBill> getRideBillList;
  @override
  List<Object> get props => getRideBillList;

  GetRideBillLoadedState(this.getRideBillList);
}
