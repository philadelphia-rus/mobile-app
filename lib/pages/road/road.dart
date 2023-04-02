import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:mobile_app/service/road_service.dart';

import '../../models/unit.dart';
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
              child: Column(children: _units),
            )
          ],
        ),
      ),
    );
  }

  // List<UnitWidget> _genereateUnits(List<Unit> units) {
  //   return List.generate(
  //     units.length,
  //     (index) {
  //       return UnitWidget(
  //         title: units[index].name,
  //         description: '',
  //         stepCount: units[index].steps.length,
  //         steps: _genereateSteps(units, index),
  //       );
  //     },
  //   );
  // }

  // List<StepWidget> _genereateSteps(List<Unit> units, int index1) {
  //   return List.generate(
  //     units[index1].steps.length,
  //     (index) {
  //       return StepWidget(
  //         type: units[index1].steps[index].type.toString(),
  //         name: units[index1].steps[index].name,
  //         mdFile: units[index1].steps[index].mdFile,
  //         video: units[index1].steps[index].video,
  //         question: units[index1].steps[index].question,
  //       );
  //     },
  //   );
  // }

  final List<UnitWidget> _units = const [
    UnitWidget(
      title: 'Обучить сотрудников ТБ',
      description:
          'Здесь вы научитесь правилам безопасности при работе в компании',
      stepCount: 4,
      steps: [
        StepWidget(
          type: 'MDFILE',
          name: 'О технике безопасности',
          mdFile:
              'https://github.com/NerouN1919/philadelphia_api/blob/main/md/unit1_1.md',
          video: null,
          question: null,
        ),
        StepWidget(
          type: 'VIDEO',
          name: 'Видео о технике безопасности',
          mdFile: null,
          video: 'https://youtu.be/k72g5H-YaUE',
          question: null,
        ),
        StepWidget(
          type: 'QUESTIONS',
          name: 'Рурика вопросы',
          mdFile: null,
          video: null,
          question: null,
        ),
        StepWidget(
            type: "QUESTIONS",
            name: "Рубрика вопросы",
            video: null,
            mdFile: null,
            question: null),
      ],
    ),
    UnitWidget(
      title:
          'Первичный инструктаж при приеме на работу: инструкции от HR–специалиста',
      description: 'Первый инструктаж',
      stepCount: 3,
      steps: [
        StepWidget(
            type: "MDFILE",
            name: "Инструктаж от HR",
            video: null,
            mdFile:
                "https://github.com/NerouN1919/philadelphia_api/blob/main/md/unit2_1.md",
            question: null),
        StepWidget(
            type: 'VIDEO',
            name: "Знакомство с компанией",
            video: "https://youtu.be/yqn4uqEkmkw",
            mdFile: null,
            question: null),
        StepWidget(
          type: "QUESTIONS",
          name: "Рубрика вопросы",
          video: null,
          mdFile: null,
          question: null,
        ),
        StepWidget(
          type: "MDFILE",
          name: "Наш офис",
          video: null,
          mdFile:
              "https://github.com/NerouN1919/philadelphia_api/blob/main/md/unit5_1.md",
          question: null,
        )
      ],
    ),
    UnitWidget(
      title: 'Знакомство с Системой RNS Web',
      description: '',
      stepCount: 3,
      steps: [
        StepWidget(
          type: "MDFILE",
          name: "Система RNS WEB",
          video: null,
          mdFile:
              "https://github.com/NerouN1919/philadelphia_api/blob/main/md/unit3_1.md",
          question: null,
        ),
        StepWidget(
            type: "VIDEO",
            name: "Пример сайта",
            video: "https://youtu.be/Q_E3ubazHGg",
            mdFile: null,
            question: null),
        StepWidget(
            type: "QUESTIONS",
            name: "Рубрика вопросы",
            video: null,
            mdFile: null,
            question: null),
        StepWidget(
          type: "MDFILE",
          name: "О компании",
          video: null,
          mdFile:
              "https://github.com/NerouN1919/philadelphia_api/blob/main/md/unit4_1.md",
          question: null,
        ),
      ],
    ),
  ];
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
