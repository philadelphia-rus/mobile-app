import 'dart:isolate';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../models/unit_model.dart';
import '../../../service/road_service.dart';
import '../../../ui/unit_widget.dart';

part 'road_event.dart';
part 'road_state.dart';

class RoadBloc extends Bloc<RoadEvent, RoadState> {
  final UnitService unitService;
  List<Unit> _units = [];
  List<Unit> get units => _units;

  RoadBloc({required this.unitService}) : super(RoadLoading()) {

    _initUnits();
    on<RoadEvent>((event, emit) {
      if (event is RoadLoadedEvent) {
        emit(RoadLoaded(units: _units));
      }
    });
  }
  Future<void> _initUnits() async {
    _units = await Isolate.run(unitService.getFullUnits);

    add(RoadLoadedEvent(
      units: _units,
    ));
  }
}
