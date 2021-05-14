import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:work_around/models/user_set.dart';
import 'package:work_around/widgets/exercise_tile_view_model.dart';

class SetButton extends ViewModelWidget<ExerciseTileViewModel> {
  final UserSet set;

  SetButton({this.set});

  @override
  Widget build(BuildContext context, ExerciseTileViewModel model) {
    Color defaultColor = Colors.grey[400];
    return MaterialButton(
      color: set.isCompleted ? Colors.green : defaultColor,
      shape: CircleBorder(),
      onPressed: () {
        model.addSetToBeResetAfterWorkout(set);
        if(!set.isCompleted){
          set.isCompleted = true;
          model.updateSet(set);
        }
        if(set.isCompleted) {
          set.isCompleted = false;
          model.updateSet(set);
        }
        ScaffoldMessenger.of(context).showSnackBar(model.snackBar);
        model.adjustWorkout();
      },
    );
  }
}
