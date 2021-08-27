part of 'driverinitialrequirements_bloc.dart';

@immutable
abstract class DriverInitialRequirementsEvent {}

class InsertModel extends DriverInitialRequirementsEvent {
  Map map;

  InsertModel({this.map});
}
