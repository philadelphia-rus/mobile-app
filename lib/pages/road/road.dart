import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:mobile_app/service/road_service.dart';

import '../../models/unit_model.dart';
import '../../service/api_requests.dart';
import '../../ui/unit_widget.dart';
import 'bloc/road_bloc.dart';

class RoadPage extends StatelessWidget {
  RoadPage({super.key});
  final UnitService unitService = Injector().get<UnitService>();
  final authService = Injector().get<AuthService>();
  

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RoadBloc(unitService: unitService),
      child: BlocConsumer<RoadBloc, RoadState>(
        listener: (context, state) {
          if (state is RoadError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is RoadLoaded) {
            return _buildLoadedBody(state.units);
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _buildLoadedBody(List<Unit> units) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(children: _genereateUnits(units)),
            )
          ],
        ),
      ),
    );
  }

  List<UnitWidget> _genereateUnits(List<Unit> units) {
    return List.generate(
      units.length,
      (index) {
        return UnitWidget(
          title: units[index].name,
          description: '',
          stepCount: units[index].steps.length,
          steps: _genereateSteps(units, index),
        );
      },
    );
  }

  List<StepWidget> _genereateSteps(List<Unit> units, int index1) {
    return List.generate(
      units[index1].steps.length,
      (index) {
        return StepWidget(
          type: units[index1].steps[index].type.toString(),
          name: units[index1].steps[index].name,
          mdFile: units[index1].steps[index].mdFile,
          video: units[index1].steps[index].video,
          question: units[index1].steps[index].question,
        );
      },
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());

  _showSnackBar({required BuildContext context, required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          textAlign: TextAlign.center,
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
