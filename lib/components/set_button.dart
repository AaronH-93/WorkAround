import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:work_around/models/user_set.dart';
import 'package:work_around/widgets/sets_buttons_view_model.dart';

class SetButton extends ViewModelWidget<SetsButtonsViewModel> {
  final UserSet set;
  SetButton({this.set});

  @override
  Widget build(BuildContext context, SetsButtonsViewModel model) {
    Color defaultColor = Colors.grey[400];
    return model.dataReady ? MaterialButton(
      color: set.isCompleted ? Colors.green : defaultColor,
      shape: CircleBorder(),
      onPressed: () {
        model.addSetToBeResetAfterWorkout(set);
        if(set.isCompleted) {
          set.isCompleted = false;
        }
        else {
          set.isCompleted = true;
        }
        ScaffoldMessenger.of(context).showSnackBar(model.snackBar);
        model.updateSet(set);
        model.adjustWorkout();
      },
    ) : SizedBox();
  }
}
