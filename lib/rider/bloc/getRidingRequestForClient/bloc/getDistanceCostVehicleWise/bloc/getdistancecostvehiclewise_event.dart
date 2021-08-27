part of 'getdistancecostvehiclewise_bloc.dart';

abstract class GetdistancecostvehiclewiseEvent extends Equatable {
  const GetdistancecostvehiclewiseEvent();

  @override
  List<Object> get props => [];
}

class GetdistancecostvehiclewiseInsertEvent
    extends GetdistancecostvehiclewiseEvent {
  final Map<String, dynamic> map;

  GetdistancecostvehiclewiseInsertEvent(this.map);
}
