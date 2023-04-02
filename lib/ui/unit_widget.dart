import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app/ui/pushable_button/pushable_button.dart';

import '../utils/app_colors.dart';

import 'dart:math' as math;

class UnitWidget extends StatefulWidget {
  const UnitWidget({
    super.key,
    required this.title,
    required this.description,
    required this.stepCount,
    required this.steps,
  });

  final String title;
  final String description;
  final int stepCount;
  final List<Widget> steps;

  @override
  State<UnitWidget> createState() => _UnitWidgetState();
}

class _UnitWidgetState extends State<UnitWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.color7e56e8,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontFamily: 'VarelaRound',
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Row(
                    children: [
                      Flexible(
                          flex: 3,
                          child: Text(
                            widget.description,
                            style: TextStyle(
                              fontFamily: 'VarelaRound',
                              fontSize: 14,
                            ),
                          )),
                      Flexible(flex: 1, child: Container())
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: SineWaveWidgets(
            children: widget.steps,
          ),
        ),
      ],
    );
  }
}

class StepWidget extends StatelessWidget {
  const StepWidget({
    super.key,
    required this.type,
    required this.name,
    this.mdFile,
    this.video,
    this.question,
  });

  final String type;
  final String name;
  final String? mdFile;
  final String? video;
  final String? question;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PushableButton(
          child: _buildIcon(),
          height: 60,
          width: 60,
          elevation: 6,
          hslColor: HSLColor.fromAHSL(1.0, 120, 1.0, 0.37),
          onPressed: () {},
        ),
        SizedBox(
          width: 5,
        ),
        Text(name, style: TextStyle(fontSize: 18, fontFamily: 'VarelaRound')),
      ],
    );
  }

  Widget _buildIcon() {
    if (type == 'MDFILE') {
      return Icon(Icons.document_scanner_sharp);
    } else if (type == 'QUESTIONS') {
      return Icon(Icons.question_mark_rounded);
    } else if (type == 'VIDEO') {
      return Icon(Icons.play_arrow);
    }
    return Container();
  }

  void _onPressDo(BuildContext context) {
    if (type == 'MDFILE') {
      // URL OPEN
      return context.go('Routes.mdfile');
    }else if (type == 'QUESTIONS') {
      return context.go('Routes.quiestion');
    } else if (type == 'VIDEO') {
      //URL open
     return context.go('Routes.quiestion');
    };
  }
}

class SineWaveWidgets extends StatefulWidget {
  final List<Widget> children;

  const SineWaveWidgets({super.key, required this.children});
  @override
  _SineWaveWidgetsState createState() => _SineWaveWidgetsState();
}

class _SineWaveWidgetsState extends State<SineWaveWidgets> {
  @override
  Widget build(BuildContext context) {
    final int numberOfWidgets = widget.children.length;
    return SizedBox(
      width: double.infinity,
      height: numberOfWidgets * 60,
      child: CustomPaint(
        child: Stack(
          children: List.generate(
            numberOfWidgets,
            (index) {
              double yScale = 2;
              // Calculate the horizontal x position.
              double yPos = yScale *
                  (index / (numberOfWidgets - 1)) *
                  MediaQuery.of(context).size.width;

              // Calculate the sine wave value for the given x position.
              double sineValue = math
                  .sin(2 * math.pi * yPos / MediaQuery.of(context).size.width);

              // Map the sine value to a y position within the available height.
              double xPos = (MediaQuery.of(context).size.width / 2 - 120) +
                  (1 - sineValue) * 60;

              return Positioned(
                  top: yPos, left: xPos, child: widget.children[index]);
            },
          ),
        ),
      ),
    );
  }
}
