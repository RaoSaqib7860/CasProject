part of 'getpenalty_bloc.dart';

abstract class GetpenaltyState extends Equatable {
  const GetpenaltyState();
  
  @override
  List<Object> get props => [];
}

class GetpenaltyInitial extends GetpenaltyState {}
class GetPenaltyLoadedState extends GetpenaltyState {
  final List<RiderPenalty> riderPenaltyList;
   @override
  List<Object> get props => riderPenaltyList;
  GetPenaltyLoadedState({
     this.riderPenaltyList,
  });
  


}
