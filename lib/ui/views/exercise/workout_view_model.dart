import 'dart:async';

import 'package:stacked/stacked.dart';
import 'package:work_around/models/exercise.dart';
import 'package:work_around/models/user_workout.dart';
import 'package:work_around/models/workout.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/services/repository/workout_repository.dart';

class WorkoutViewModel extends StreamViewModel<List<UserWorkout>>{
  Timer _timer;

  final NavigationService _navigationService;
  final ExerciseService _exerciseService;
  final WorkoutRepository _workoutRepository;
  final AuthenticationService _authenticationService;

  WorkoutViewModel(this._navigationService, this._exerciseService, this._workoutRepository, this._authenticationService);

  //This will take in duration and workout?
  _startTimer() {
    int _restCounter = 20;
    _timer = Timer(Duration(seconds: _restCounter), (){
        _timer.cancel();
        setNewDuration(newWorkoutDuration());
        navigateToNewWorkoutView(newWorkoutDuration(), getCurrentWorkoutId());
      }
    );
    return _restCounter;
  }

  Duration newWorkoutDuration() {
    return getInitialWorkoutDuration() - getWorkoutTimeElapsed();
  }

  int startTimer() => _startTimer();

  void setNewDuration(Duration duration) => _exerciseService.setWorkoutDuration(duration);
  Workout getWorkout(int index) => _exerciseService.getWorkout(index);
  String getCurrentWorkoutId() =>_exerciseService.getCurrentWorkoutId();
  int getNumOfWorkouts() => _exerciseService.getNumOfWorkouts();
  Duration getWorkoutTimeElapsed() => _exerciseService.getWorkoutTimeElapsed();
  Duration getInitialWorkoutDuration() => _exerciseService.getInitialWorkoutDuration();
  //Need to convert the user_exercise object into exercise,
  //maybe in the exercise service?
  void generateSets(Duration duration, List<Exercise> workout) => _exerciseService.generateSets(duration, workout);
  void setWorkoutID(String id) => _exerciseService.setCurrentWorkoutId(id);
  //void setCurrentWorkout(UserWorkout workout) => _exerciseService.setCurrentWorkout(workout);
  void startWorkoutTimer() => _exerciseService.startWorkoutTimer();
  void setInitialWorkoutDuration(Duration duration) => _exerciseService. setInitialWorkoutDuration(duration);

  //Navigation
  void pop() => _navigationService.pop();
  void navigateToSettingsView() => _navigationService.navigateToSettingsView();
  void navigateToHomeView() => _navigationService.navigateToHomeView();
  void navigateToCreateWorkoutView(UserWorkout newWorkout) => _navigationService.navigateToCreateWorkoutView(newWorkout);
  void navigateToNewWorkoutView(Duration duration, String workoutId) => _navigationService.navigateToNewWorkoutView(duration, workoutId);
  void navigateToWorkoutView(Duration duration, String workoutId) => _navigationService.navigateToWorkoutView(duration, workoutId);

  @override
  Stream<List<UserWorkout>> get stream => _workoutRepository.getWorkouts(_authenticationService.currentId);

  List<UserWorkout> get workouts => data;

  void addWorkoutToFirestore(UserWorkout newWorkout) => _workoutRepository.addOrUpdateWorkout(_authenticationService.currentId, newWorkout);

}