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
    return model.isBusy ? Container(child: Text('Loading sets')) : buildRowOfButtons(model);
  }

  Widget buildRowOfButtons(ExerciseTileViewModel model) {
    List<Widget> list = [];
    List<UserSet> setList = model.userSets;
    for(UserSet set in setList) {
      if (model.isSetWithinDuration(set) == true) {
        list.add(
          //it looks like its not updating the new page with the original duration - elapsed time, look at that
          //
          SetButton(
              set: set
          ),
        );
      }
    }
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: list,
    );
  }
}

  // @override
  // Widget build(BuildContext context, ExerciseTileViewModel model) {
  //   return ListView.builder(
  //     scrollDirection: Axis.horizontal,
  //     itemBuilder: (context, index) {
  //       final set = model.userSets[index];
  //       return model.isBusy
  //           ? Container(child: Text('Loading Set'))
  //           : SetButton(set: set);
  //     },
  //     itemCount: model.userSets.length,
  //   );
  // }