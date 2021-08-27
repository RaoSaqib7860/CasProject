part of 'getpenalty_bloc.dart';

abstract class GetpenaltyEvent extends Equatable {
  const GetpenaltyEvent();

  @override
  List<Object> get props => [];
}

class GetPenaltyInsertEvent extends GetpenaltyEvent {
  final int ridingRequestId;
  GetPenaltyInsertEvent({
    this.ridingRequestId,
  });
}
