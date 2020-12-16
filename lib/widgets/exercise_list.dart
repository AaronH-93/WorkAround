import 'package:flutter/material.dart';
import 'package:work_around/models/exercise_data.dart';
import 'package:provider/provider.dart';
import 'exercise_tile.dart';

class ExerciseList extends StatefulWidget {
  final int workoutDuration;

  ExerciseList({this.workoutDuration});

  @override
  _ExerciseListState createState() => _ExerciseListState();
}

class _ExerciseListState extends State<ExerciseList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExerciseData>(
      builder: (context, exerciseData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            exerciseData.generateSets(widget.workoutDuration);
            final exercise = exerciseData.exercises[index];
            return ExerciseTile(
              name: exercise.name,
              sets: exercise.sets, //Todo: This needs to be dynamic
              effort: exercise.effort,
              workoutDuration: widget.workoutDuration,
            );
          },
          itemCount: exerciseData.exercises.length,
        );
      },
    );
  }
}
