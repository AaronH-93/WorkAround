import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:work_around/models/user_set.dart';
import 'package:work_around/widgets/exercise_tile_view_model.dart';
import 'package:work_around/widgets/rest_timer.dart';

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
        //Extract these to view model?
        if(!set.isCompleted){
          set.isCompleted = true;
          model.updateSet(set);
        }
        else {
          set.isCompleted = false;
          model.updateSet(set);
        }
        //showRestTimer can display the dismissible snackbar
        //but the workout adjustment is handled separately
        ScaffoldMessenger.of(context).showSnackBar(model.snackBar);
        model.adjustWorkout();
        //_showRestTimer(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          set.setNumber.toString(),
        ),
      ),
    );
  }

  // _showRestTimer(BuildContext context) async {
  //   await showDialog<String>(
  //     context: context,
  //     builder: (_) => RestTimer(context: context),
  //   );
  // }
}
