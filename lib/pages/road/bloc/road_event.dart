part of 'road_bloc.dart';

@immutable
abstract class RoadEvent {}

class RoadLoadedEvent extends RoadEvent {
  final List<Unit> units;

  RoadLoadedEvent({required this.units});
}