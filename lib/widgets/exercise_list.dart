import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';
import 'package:work_around/models/workout.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/ui/views/exercise/workout_view_model.dart';
import 'exercise_tile.dart';

class ExerciseList extends StatefulWidget {
  final Duration workoutDuration;
  final Workout workout;

  ExerciseList({this.workoutDuration, this.workout});

  @override
  _ExerciseListState createState() => _ExerciseListState();
}

class _ExerciseListState extends State<ExerciseList> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WorkoutViewModel>.reactive(
      onModelReady: (model) => model.generateSets(widget.workoutDuration, widget.workout.workoutList),
      builder: (context, model, child) => ListView.builder(
        itemBuilder: (context, index) {
          final exercise = widget.workout.workoutList[index];
          return ExerciseTile(
            name: exercise.name,
            sets: exercise.sets,
            reps: exercise.reps,
            effort: exercise.effort,
            workoutDuration: widget.workoutDuration,
          );
        },
        itemCount: widget.workout.workoutList.length,
      ),
      viewModelBuilder: () => WorkoutViewModel(
        Provider.of<NavigationService>(context, listen: false),
        Provider.of<ExerciseService>(context, listen: false),
      ),
    );
  }
}
