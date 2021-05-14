import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:work_around/components/set_button.dart';
import 'package:work_around/models/user_set.dart';

import 'exercise_tile_view_model.dart';

class SetsButtons extends ViewModelWidget<ExerciseTileViewModel> {
  final Duration workoutDuration;
  SetsButtons({this.workoutDuration});

  @override
  Widget build(BuildContext context, ExerciseTileViewModel model) {
    return model.dataReady
        ? buildRowOfButtons(model)
        : Container(child: Text('Loading sets'));
  }

  Widget buildRowOfButtons(ExerciseTileViewModel model) {
    List<Widget> list = [];
    List<UserSet> setList = model.userSets;
    for (UserSet set in setList) {
      model.addToSetHistory(set);
      if (model.isSetWithinDuration(set) == true) {
        list.add(
          SetButton(set: set),
        );
      }
    }
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: list,
    );
  }
}
