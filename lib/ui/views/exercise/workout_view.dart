import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:work_around/models/workout.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/widgets/exercise_list.dart';
import 'workout_view_model.dart';

class WorkoutView extends StatelessWidget {
  final Duration duration;
  final Workout workout;

  WorkoutView(this.duration, this.workout);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WorkoutViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.grey,
              body: ExerciseList(
                workoutDuration: duration,
                workout: workout,
              ),
            ),
        viewModelBuilder: () => WorkoutViewModel(
              Provider.of<NavigationService>(context, listen: false),
              Provider.of<ExerciseService>(context, listen: false),
            ));
  }
}
