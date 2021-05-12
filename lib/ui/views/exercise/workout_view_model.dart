import 'dart:async';

import 'package:stacked/stacked.dart';
import 'package:uuid/uuid.dart';
import 'package:work_around/models/user_exercise.dart';
import 'package:work_around/models/user_set.dart';
import 'package:work_around/models/user_workout.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/services/repository/exercise_repository.dart';
import 'package:work_around/services/repository/history_repository.dart';
import 'package:work_around/services/repository/workout_repository.dart';


class WorkoutViewModel extends StreamViewModel<List<UserWorkout>>{
  Timer _timer;

  final NavigationService _navigationService;
  final ExerciseService _exerciseService;
  final WorkoutRepository _workoutRepository;
  final AuthenticationService _authenticationService;
  final ExerciseRepository _exerciseRepository;
  final HistoryRepository _historyRepository;

  WorkoutViewModel(this._navigationService, this._exerciseService, this._workoutRepository, this._authenticationService, this._exerciseRepository, this._historyRepository);

  //This will take in duration and workout?
  _startTimer() {
    int _restCounter = 20;
    _timer = Timer(Duration(seconds: _restCounter), (){
        _timer.cancel();
        setNewDuration(newWorkoutDuration());
        navigateToWorkoutView(newWorkoutDuration(), getCurrentWorkoutId());
      }
    );
    return _restCounter;
  }

  _cancelTimer(){
    _timer.cancel();
    setNewDuration(newWorkoutDuration());
    navigateToWorkoutView(newWorkoutDuration(), getCurrentWorkoutId());
  }

  Duration newWorkoutDuration() {
    return getInitialWorkoutDuration() - getWorkoutTimeElapsed();
  }

  int startTimer() => _startTimer();
  int cancelTimer() => _cancelTimer();

  void setNewDuration(Duration duration) => _exerciseService.setWorkoutDuration(duration);
  String getCurrentWorkoutId() =>_exerciseService.getCurrentWorkoutId();
  Duration getWorkoutTimeElapsed() => _exerciseService.getWorkoutTimeElapsed();
  Duration getInitialWorkoutDuration() => _exerciseService.getInitialWorkoutDuration();

  void setWorkoutID(String id) => _exerciseService.setCurrentWorkoutId(id);
  void setWorkoutIdToEdit(String workoutIdToEdit) => _exerciseService.setCurrentEditWorkoutId(workoutIdToEdit);
  void startWorkoutTimer() => _exerciseService.startWorkoutTimer();
  void setInitialWorkoutDuration(Duration duration) => _exerciseService. setInitialWorkoutDuration(duration);

  //Navigation
  void pop() => _navigationService.pop();
  void navigateToSettingsView() => _navigationService.navigateToSettingsView();
  void navigateToHomeView() => _navigationService.navigateToHomeView();
  void navigateToCreateWorkoutView(UserWorkout newWorkout) => _navigationService.navigateToCreateWorkoutView(newWorkout);
  void navigateToNewWorkoutView(Duration duration, String workoutId) => _navigationService.navigateToNewWorkoutView(duration, workoutId);
  void navigateToWorkoutView(Duration duration, String workoutId) => _navigationService.navigateToWorkoutView(duration, workoutId);
  void navigateToEditWorkoutView(UserWorkout workout) => _navigationService.navigateToEditWorkoutView(workout);

  @override
  Stream<List<UserWorkout>> get stream => _workoutRepository.getWorkouts(_authenticationService.currentId);
  List<UserWorkout> get workouts => data;

  void addOrUpdateWorkout(UserWorkout newWorkout) => _workoutRepository.addOrUpdateWorkout(_authenticationService.currentId, newWorkout);
  void deleteWorkout(String workoutId) => _workoutRepository.deleteWorkout(_authenticationService.currentId, workoutId);

  void resetWorkout(String workoutId){
    for(UserSet set in _exerciseService.resetList){
      set.isCompleted = false;
      _exerciseRepository.updateSet(_authenticationService.currentId, workoutId, set);
    }
  }

  void resetResetList() => _exerciseService.resetResetList();

  void setTempWorkoutId(String workoutId) => _exerciseService.setNewTempWorkoutId(workoutId);

  void addWorkoutToHistory(String workoutId) {
    UserWorkout workout = workouts.firstWhere((workout) => workout.workoutId == workoutId);
    workout.workoutId = Uuid().v4();
    workout.workoutDuration = _exerciseService.getInitialWorkoutDuration().toString();
    workout.date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).toString();

    _historyRepository.addOrUpdateWorkout(_authenticationService.currentId, workout);

    for(UserExercise exercise in _exerciseService.historyExercises){
      _historyRepository.addOrUpdateExercise(_authenticationService.currentId, workout.workoutId, exercise);
    }

    for(UserSet set in _exerciseService.historySets){
      _historyRepository.addOrUpdateExerciseSets(_authenticationService.currentId, workout.workoutId, set);
    }
  }
}