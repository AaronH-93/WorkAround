import 'package:flutter/cupertino.dart';
import 'package:work_around/models/exercise.dart';
import 'dart:collection';

class ExerciseData extends ChangeNotifier{
  List<Exercise> _exercises = [
    Exercise(name: 'Bicep Curl', sets: 0, reps: 10, effort: 2, muscleGroup: 'Arms'),
    Exercise(name: 'Hammer Curl', sets: 0, reps: 20,effort: 3, muscleGroup: 'Arms'),
    Exercise(name: 'Tricep Curl', sets: 0, reps: 10, effort: 2, muscleGroup: 'Arms'),
    Exercise(name: 'Squat', sets: 0, reps: 10, effort: 3, muscleGroup: 'Lower'),
    Exercise(name: 'Good Mornings', sets: 0, reps: 20,effort: 2, muscleGroup: 'Lower'),
    Exercise(name: 'Crunches', sets: 0, reps: 10, effort: 2, muscleGroup: 'Abdominals'),
    Exercise(name: 'Laying Leg Raises', sets: 0, reps: 10, effort: 3, muscleGroup: 'Abdominals'),
    Exercise(name: 'Push ups', sets: 0, reps: 20,effort: 3, muscleGroup: 'Upper'),
    Exercise(name: 'Incline Push Ups', sets: 0, reps: 10, effort: 2, muscleGroup: 'Upper'),
  ];

  UnmodifiableListView<Exercise> get exercises{
    return UnmodifiableListView(_exercises);
  }

  void generateSets(int duration, List<Exercise> workout){
    for(var i = 0; i < workout.length; i++){
      for(Exercise exercise in workout){
        if(duration - exercise.effort > 0) {
          exercise.sets += 1;
          duration -= exercise.effort;
        }
      }
    }
  }
}
