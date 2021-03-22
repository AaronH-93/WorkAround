import 'dart:async';

import 'package:stacked/stacked.dart';
import 'package:work_around/models/exercise.dart';
import 'package:work_around/models/workout.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';

class WorkoutViewModel extends BaseViewModel{
  Timer _timer;

  final NavigationService _navigationService;
  final ExerciseService _exerciseService;

  WorkoutViewModel(this._navigationService, this._exerciseService);

  //This will take in duration and workout?
  _startTimer(Workout workout) {
    int _restCounter = 60;
    _timer = Timer(Duration(seconds: _restCounter), (){
        _timer.cancel();
        navigateToNewWorkoutView(newWorkoutDuration(), getCurrentWorkout());
      }
    );
    return _restCounter;
  }

  Duration newWorkoutDuration() {
    return getInitialWorkoutDuration() - getWorkoutTimeElapsed();
  }

  int startTimer(Workout workout) => _startTimer(workout);

  Workout getWorkout(int index) => _exerciseService.getWorkout(index);
  Workout getCurrentWorkout() =>_exerciseService.getCurrentWorkout();
  int getNumOfWorkouts() => _exerciseService.getNumOfWorkouts();
  Duration getWorkoutTimeElapsed() => _exerciseService.getWorkoutTimeElapsed();
  Duration getInitialWorkoutDuration() => _exerciseService.getWorkoutDuration();
  void generateSets(Duration duration, List<Exercise> workout) => _exerciseService.generateSets(duration, workout);
  void pop() => _navigationService.pop();
  void navigateToSettingsView() => _navigationService.navigateToSettingsView();
  void navigateToExercisesView() => _navigationService.navigateToExercisesView();
  void navigateToCreateWorkoutView() => _navigationService.navigateToCreateWorkoutView();
  void navigateToNewWorkoutView(Duration duration, Workout workout) => _navigationService.navigateToNewWorkoutView(duration, workout);


}