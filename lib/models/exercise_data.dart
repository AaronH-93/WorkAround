import 'package:flutter/cupertino.dart';
import 'package:work_around/models/exercise.dart';
import 'dart:collection';

class ExerciseData extends ChangeNotifier{
  List<Exercise> _exercises = [
    Exercise(name: 'Bicep Curl', sets: 0, reps: 10, effort: 2),
    Exercise(name: 'Hammer Curl', sets: 0, reps: 20,effort: 3),
    Exercise(name: 'Tricep Curl', sets: 0, reps: 10, effort: 2),
  ];

  UnmodifiableListView<Exercise> get exercises{
    return UnmodifiableListView(_exercises);
  }

  void generateSets(int duration){
    for(var i = 0; i < _exercises.length; i++){
      for(Exercise exercise in _exercises){
        if(duration - exercise.effort > 0) {
          exercise.sets += 1;
          duration -= exercise.effort;
        }
      }
    }
  }
}
