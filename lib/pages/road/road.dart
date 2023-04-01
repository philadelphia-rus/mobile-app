import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../ui/unit_widget.dart';

class RoadPage extends StatelessWidget {
  const RoadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  Unit(
                    description:
                        'Этот юнит предназначен для того, что бы стать часть компании',
                    stepCount: 5,
                    steps: [],
                    title: 'Раздел 1',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
