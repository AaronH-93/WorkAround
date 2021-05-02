import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:work_around/models/ExerciseSet.dart';
import 'package:work_around/models/exercise.dart';
import 'package:work_around/models/exercise_data.dart';
import 'package:work_around/models/user_exercise.dart';
import 'package:work_around/models/user_set.dart';
import 'package:work_around/models/workout.dart';
import 'package:work_around/models/workout_data.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/repository/exercise_repository.dart';
import 'package:work_around/services/repository/workout_repository.dart';

class ExerciseService {
  final AuthenticationService _authenticationService;
  final ExerciseRepository _exerciseRepository;
  final WorkoutRepository _workoutRepository;
  final ExerciseData _exerciseData;
  final WorkoutData _workoutData;

  //MAKE THESE PRIVATE
  List<UserExercise> newExercises = [];
  List<UserSet> newExercisesSets = [];
  String workoutId;
  String get currentWorkoutId => workoutId;

  String exerciseId;
  String get currentExerciseId => exerciseId;

  String setId;
  String get currentSetId => setId;

  String tempWorkoutId;
  String get newWorkoutId => tempWorkoutId;

  String tempExerciseId;
  String get newExerciseId => tempExerciseId;

  String tempSetId;
  String get newSetId => tempSetId;

  //Workout currentWorkout = Workout();

  void setCurrentWorkoutId(String id) {
    workoutId = id;
  }

  void setCurrentExerciseId(String id) {
    exerciseId = id;
  }

  void setCurrentSetId(String id) {
    setId = id;
  }

  void setNewWorkoutId(String id) {
    tempWorkoutId = id;
  }

  void setNewExerciseId(String id) {
    tempExerciseId = id;
  }

  void setNewSetId(String id) {
    tempExerciseId = id;
  }

  ExerciseService(this._authenticationService, this._exerciseData,
      this._workoutData, this._exerciseRepository, this._workoutRepository);

  //this will eventually need to be refactored when exerciseData is merged with exerciseService
  //and the user has the ability to define the reps and sets they wish to do
  //The result of this means there will be a difference between the exerciseService/Collection exercise and a workout exercise
  UnmodifiableListView<Exercise> get exercises => _exerciseData.exercises;
  List<Exercise> get exerciseInformation => _exerciseData.exerciseInformation;

  get workouts => _workoutData.workouts;
  get temp => _workoutData.temp;

  Stopwatch _workoutTimer = Stopwatch();
  Duration _initialWorkoutDuration;
  Duration _workoutDuration;

  void setTemp(Workout temp) => _workoutData.setTempWorkout(temp);

  void addWorkout(String workoutName) {
    _workoutData.temp.name = workoutName;
    _workoutData.workouts.add(_workoutData.temp);
  }

  void addToTempWorkout(UserExercise exercise) {
    newExercises.add(exercise);
  }

  UserExercise getTempWorkout(int index) {
    return newExercises[index];
  }

  Workout getWorkout(int index) {
    return _workoutData.workouts[index];
  }

  int getNumOfExercises() {
    return _workoutData.temp.exerciseList.length;
  }

  int getNumOfWorkouts() {
    return _workoutData.workouts.length;
  }

  void generateSets(Duration duration, List<Exercise> workout) {
    _exerciseData.generateSets(duration, workout);
  }

  String getCurrentWorkoutId() {
    return workoutId;
  }

  // void setCurrentWorkout(workout){
  //   _workoutData.setCurrentWorkout(workout);
  // }
  //
  // UserWorkout getCurrentWorkout(){
  //   return _workoutData.currentWorkout;
  // }

  void startWorkoutTimer() {
    _workoutTimer.start();
  }

  Duration getWorkoutTimeElapsed() {
    return _workoutTimer.elapsed;
  }

  void setInitialWorkoutDuration(Duration duration) {
    _initialWorkoutDuration = duration;
    _workoutDuration = duration;
  }

  void setWorkoutDuration(Duration duration) {
    _workoutDuration = duration;
  }

  Duration getInitialWorkoutDuration() {
    return _initialWorkoutDuration;
  }

  // void generateSetsII(List<UserSet> userSet) {
  //   for (UserSet set in userSet) {
  //     if (set.isCompleted) {
  //       set.markedForRemove = false;
  //     }
  //     if (!set.isCompleted) {
  //       set.markedForRemove = true;
  //       if (_workoutDuration -
  //               Duration(seconds: int.parse(set.effort.toString())) >=
  //           Duration.zero) {
  //         set.markedForRemove = false;
  //         _workoutDuration -=
  //             Duration(seconds: int.parse(set.effort.toString()));
  //       }
  //     }
  //   }
  //   for (UserSet set in userSet) {
  //     if (set.markedForRemove) {
  //       //_exerciseRepository.deleteSet(_authenticationService.currentId, workoutId, exerciseId, set.setId);
  //     }
  //   }
  // }

  bool isSetWithinDuration(UserSet set) {
    bool withinDuration;
    if (set.isCompleted) {
      withinDuration = true;
      return withinDuration;
    }
    if(_workoutDuration - Duration(seconds: int.parse(set.effort.toString())) >= Duration.zero) {
      _workoutDuration -= Duration(seconds: int.parse(set.effort.toString()));
      withinDuration = true;
      return withinDuration;
    }
    return false;
  }
}
