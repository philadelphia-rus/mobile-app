part of 'road_bloc.dart';


abstract class RoadState {}

class RoadInitial extends RoadState {}

class RoadLoading extends RoadState {}

class RoadLoaded extends RoadState {
  final List<Unit> units;

  RoadLoaded({
    required this.units,
  });
}

class RoadError extends RoadState {
  final String error;

  RoadError({required this.error});
}