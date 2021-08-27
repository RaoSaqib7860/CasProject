part of 'getridebill_bloc.dart';

abstract class GetridebillEvent extends Equatable {
  const GetridebillEvent();

  @override
  List<Object> get props => [];
}

class GetRideBillInsertEvent extends GetridebillEvent {
  final int ridingRequestId;

  GetRideBillInsertEvent(this.ridingRequestId);
}
