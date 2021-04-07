import 'package:flutter/material.dart';
import 'package:work_around/components/set_button.dart';
import 'package:work_around/models/ExerciseSet.dart';

class SetsButtons extends StatelessWidget {
  final List<ExerciseSet> sets;

  SetsButtons({this.sets});

  Widget buildRowOfButtons() {
    List<Widget> list = [];
      for(ExerciseSet set in sets){
        list.add(
          SetButton(
              set: set
          ),
        );
    }
    return new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: list,
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildRowOfButtons();
  }
}

