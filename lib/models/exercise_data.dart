import 'package:flutter/cupertino.dart';
import 'package:work_around/models/exercise.dart';
import 'dart:collection';

import 'ExerciseSet.dart';

class ExerciseData extends ChangeNotifier {

  List<Exercise> _exercises = [
    Exercise(
        name: 'Bicep Curl',
        instructions: '1. Stand up straight with a dumbbell in each hand at arm\'s length.\n2. Raise one dumbbell and twist your forearm until it is vertical and your palm faces the shoulder.\n3. Lower to original position and repeat with opposite arm',
        gifUrl: 'https://musclewiki.com/media/uploads/BicepCurl-Front-021316.gif',
        effort: 60,
        sets: [
          ExerciseSet(setNumber: 1, effort: Duration(seconds: 45), isCompleted: false, markedForRemove: true),
          ExerciseSet(setNumber: 2, effort: Duration(seconds: 45), isCompleted: false, markedForRemove: true),
          ExerciseSet(setNumber: 3, effort: Duration(seconds: 45), isCompleted: false, markedForRemove: true),
        ],
        reps: 10,
        muscleGroup: 'Biceps'),
    Exercise(
        name: 'Hammer Curl',
        effort: 60,
        sets: [
          ExerciseSet(setNumber: 1, effort: Duration(seconds: 60), isCompleted: false, markedForRemove: true),
          ExerciseSet(setNumber: 2, effort: Duration(seconds: 60), isCompleted: false, markedForRemove: true),
          ExerciseSet(setNumber: 3, effort: Duration(seconds: 60), isCompleted: false, markedForRemove: true),
        ],
        reps: 20,
        muscleGroup: 'Biceps'),
    Exercise(
        name: 'Tricep Curl',
        effort: 60,
        sets: [
          ExerciseSet(setNumber: 1, effort: Duration(seconds: 45), isCompleted: false, markedForRemove: true),
          ExerciseSet(setNumber: 2, effort: Duration(seconds: 45), isCompleted: false, markedForRemove: true),
          ExerciseSet(setNumber: 3, effort: Duration(seconds: 45), isCompleted: false, markedForRemove: true),
        ],
        reps: 10,
        muscleGroup: 'Triceps'),
    Exercise(
        name: 'Squat',
        effort: 60,
        sets: [
          ExerciseSet(setNumber: 1, effort: Duration(minutes: 1), isCompleted: false, markedForRemove: true),
          ExerciseSet(setNumber: 2, effort: Duration(minutes: 1), isCompleted: false, markedForRemove: true),
          ExerciseSet(setNumber: 3, effort: Duration(minutes: 1), isCompleted: false, markedForRemove: true),
        ],
        reps: 10,
        muscleGroup: 'Hamstrings Glutes Quadriceps'),
    Exercise(
        name: 'Good Mornings',
        effort: 60,
        sets: [
          ExerciseSet(setNumber: 1, effort: Duration(minutes: 1), isCompleted: false, markedForRemove: true),
          ExerciseSet(setNumber: 2, effort: Duration(minutes: 1), isCompleted: false, markedForRemove: true),
          ExerciseSet(setNumber: 3, effort: Duration(minutes: 1), isCompleted: false, markedForRemove: true),
        ],
        reps: 20,
        muscleGroup: 'Lower'),
    Exercise(
        name: 'Crunches',
        effort: 60,
        sets: [
          ExerciseSet(setNumber: 1, effort: Duration(minutes: 1), isCompleted: false, markedForRemove: true),
          ExerciseSet(setNumber: 2, effort: Duration(minutes: 1), isCompleted: false, markedForRemove: true),
          ExerciseSet(setNumber: 3, effort: Duration(minutes: 1), isCompleted: false, markedForRemove: true),
        ],
        reps: 10,
        muscleGroup: 'Abdominals'),
    Exercise(
        name: 'Laying Leg Raises',
        effort: 60,
        sets: [
          ExerciseSet(setNumber: 1, effort: Duration(minutes: 1), isCompleted: false, markedForRemove: true),
          ExerciseSet(setNumber: 2, effort: Duration(minutes: 1), isCompleted: false, markedForRemove: true),
          ExerciseSet(setNumber: 3, effort: Duration(minutes: 1), isCompleted: false, markedForRemove: true),
        ],
        reps: 10,
        muscleGroup: 'Abdominals'),
    Exercise(
        name: 'Push ups',
        effort: 60,
        sets: [
          ExerciseSet(setNumber: 1, effort: Duration(minutes: 1), isCompleted: false, markedForRemove: true),
          ExerciseSet(setNumber: 2, effort: Duration(minutes: 1), isCompleted: false, markedForRemove: true),
          ExerciseSet(setNumber: 3, effort: Duration(minutes: 1), isCompleted: false, markedForRemove: true),
        ],
        reps: 20,
        muscleGroup: 'Upper'),
    Exercise(
        name: 'Incline Push Ups',
        effort: 60,
        sets: [
          ExerciseSet(setNumber: 1, effort: Duration(minutes: 1), isCompleted: false, markedForRemove: true),
          ExerciseSet(setNumber: 2, effort: Duration(minutes: 1), isCompleted: false, markedForRemove: true),
          ExerciseSet(setNumber: 3, effort: Duration(minutes: 1), isCompleted: false, markedForRemove: true),
        ],
        reps: 10,
        muscleGroup: 'Upper'),
  ];

  UnmodifiableListView<Exercise> get exercises {
    return UnmodifiableListView(_exercises);
  }

  List<Exercise> get exerciseInformation {
    return _exercises;
  }

  //Might need to refactor effort back into exercise as a value representing the
  //time in seconds it should take to complete one set
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
