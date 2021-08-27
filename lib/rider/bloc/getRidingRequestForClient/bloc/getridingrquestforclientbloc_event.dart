part of 'getridingrquestforclientbloc_bloc.dart';

abstract class GetridingrquestforclientblocEvent extends Equatable {
  const GetridingrquestforclientblocEvent();

  @override
  List<Object> get props => [];
}

class GetRidingRequestForClientBlocEvent
    extends GetridingrquestforclientblocEvent {
  final String str1, str2, str3;

  GetRidingRequestForClientBlocEvent(this.str1, this.str2, this.str3);
}
