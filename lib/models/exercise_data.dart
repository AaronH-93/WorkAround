import 'package:flutter/cupertino.dart';
import 'package:work_around/models/exercise.dart';
import 'dart:collection';
import 'workout.dart';

import 'ExerciseSet.dart';

class ExerciseData extends ChangeNotifier {
  List<Exercise> _exercises = [
    Exercise(
        name: 'Bicep Curl',
        sets: [
          ExerciseSet(setNumber: 1, effort: Duration(seconds: 45), isCompleted: false, markedForRemove: true),
          ExerciseSet(setNumber: 2, effort: Duration(seconds: 45), isCompleted: false, markedForRemove: true),
          ExerciseSet(setNumber: 3, effort: Duration(seconds: 45), isCompleted: false, markedForRemove: true),
        ],
        reps: 10,
        muscleGroup: 'Arms'),
    Exercise(
        name: 'Hammer Curl',
        sets: [
          ExerciseSet(setNumber: 1, effort: Duration(seconds: 60), isCompleted: false, markedForRemove: true),
          ExerciseSet(setNumber: 2, effort: Duration(seconds: 60), isCompleted: false, markedForRemove: true),
          ExerciseSet(setNumber: 3, effort: Duration(seconds: 60), isCompleted: false, markedForRemove: true),
        ],
        reps: 20,
        muscleGroup: 'Arms'),
    Exercise(
        name: 'Tricep Curl',
        sets: [
          ExerciseSet(setNumber: 1, effort: Duration(seconds: 45), isCompleted: false, markedForRemove: true),
          ExerciseSet(setNumber: 2, effort: Duration(seconds: 45), isCompleted: false, markedForRemove: true),
          ExerciseSet(setNumber: 3, effort: Duration(seconds: 45), isCompleted: false, markedForRemove: true),
        ],
        reps: 10,
        muscleGroup: 'Arms'),
    Exercise(
        name: 'Squat',
        sets: [
          ExerciseSet(setNumber: 1, effort: Duration(minutes: 1), isCompleted: false, markedForRemove: false),
          ExerciseSet(setNumber: 2, effort: Duration(minutes: 1), isCompleted: false, markedForRemove: false),
          ExerciseSet(setNumber: 3, effort: Duration(minutes: 1), isCompleted: false, markedForRemove: false),
        ],
        reps: 10,
        muscleGroup: 'Lower'),
    Exercise(
        name: 'Good Mornings',
        sets: [
          ExerciseSet(setNumber: 1, effort: Duration(minutes: 1), isCompleted: false, markedForRemove: false),
          ExerciseSet(setNumber: 2, effort: Duration(minutes: 1), isCompleted: false, markedForRemove: false),
          ExerciseSet(setNumber: 3, effort: Duration(minutes: 1), isCompleted: false, markedForRemove: false),
        ],
        reps: 20,
        muscleGroup: 'Lower'),
    Exercise(
        name: 'Crunches',
        sets: [
          ExerciseSet(setNumber: 1, effort: Duration(minutes: 1), isCompleted: false, markedForRemove: false),
          ExerciseSet(setNumber: 2, effort: Duration(minutes: 1), isCompleted: false, markedForRemove: false),
          ExerciseSet(setNumber: 3, effort: Duration(minutes: 1), isCompleted: false, markedForRemove: false),
        ],
        reps: 10,
        muscleGroup: 'Abdominals'),
    Exercise(
        name: 'Laying Leg Raises',
        sets: [
          ExerciseSet(setNumber: 1, effort: Duration(minutes: 1), isCompleted: false, markedForRemove: false),
          ExerciseSet(setNumber: 2, effort: Duration(minutes: 1), isCompleted: false, markedForRemove: false),
          ExerciseSet(setNumber: 3, effort: Duration(minutes: 1), isCompleted: false, markedForRemove: false),
        ],
        reps: 10,
        muscleGroup: 'Abdominals'),
    Exercise(
        name: 'Push ups',
        sets: [
          ExerciseSet(setNumber: 1, effort: Duration(minutes: 1), isCompleted: false, markedForRemove: false),
          ExerciseSet(setNumber: 2, effort: Duration(minutes: 1), isCompleted: false, markedForRemove: false),
          ExerciseSet(setNumber: 3, effort: Duration(minutes: 1), isCompleted: false, markedForRemove: false),
        ],
        reps: 20,
        muscleGroup: 'Upper'),
    Exercise(
        name: 'Incline Push Ups',
        sets: [
          ExerciseSet(setNumber: 1, effort: Duration(minutes: 1), isCompleted: false, markedForRemove: false),
          ExerciseSet(setNumber: 2, effort: Duration(minutes: 1), isCompleted: false, markedForRemove: false),
          ExerciseSet(setNumber: 3, effort: Duration(minutes: 1), isCompleted: false, markedForRemove: false),
        ],
        reps: 10,
        muscleGroup: 'Upper'),
  ];

  UnmodifiableListView<Exercise> get exercises {
    return UnmodifiableListView(_exercises);
  }

  void generateSets(Duration duration, List<Exercise> workout) {
    for (var i = 0; i < workout.length; i++) {
      for (ExerciseSet set in workout[i].sets) {
        if(set.isCompleted){
          set.markedForRemove = false;
        }
        if (!set.isCompleted) {
          set.markedForRemove = true;
          if (duration - set.effort >= Duration.zero) {
            set.markedForRemove = false;
            duration -= set.effort;
          }
        }
      }
    }
    for(Exercise exercise in workout){
      exercise.sets.removeWhere((set) => set.markedForRemove == true);
    }
  }

}
