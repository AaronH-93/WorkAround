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
  final NavigationService _navigationService;
  final ExerciseService _exerciseService;
  final WorkoutRepository _workoutRepository;
  final AuthenticationService _authenticationService;
  final ExerciseRepository _exerciseRepository;
  final HistoryRepository _historyRepository;
  Timer _timer;

  WorkoutViewModel(this._navigationService, this._exerciseService, this._workoutRepository, this._authenticationService, this._exerciseRepository, this._historyRepository);


  _startTimer() {
    int _restCounter = 20;
    _timer = Timer(Duration(seconds: _restCounter), (){
      _timer.cancel();
      setNewDuration(newWorkoutDuration());
      navigateToWorkoutView(getCurrentWorkoutId(), newWorkoutDuration());
    }
    );
    return _restCounter;
  }
  _cancelTimer(){
    _timer.cancel();
    setNewDuration(newWorkoutDuration());
    navigateToWorkoutView(getCurrentWorkoutId(), newWorkoutDuration());
  }
  int startTimer() => _startTimer();
  int cancelTimer() => _cancelTimer();


  void addOrUpdateWorkout(UserWorkout newWorkout) => _workoutRepository.addOrUpdateWorkout(_authenticationService.currentId, newWorkout);
  void deleteWorkout(String workoutId) => _workoutRepository.deleteWorkout(_authenticationService.currentId, workoutId);
  @override
  Stream<List<UserWorkout>> get stream => _workoutRepository.getWorkouts(_authenticationService.currentId);
  List<UserWorkout> get workouts => data;

  Duration newWorkoutDuration() {
    return getInitialWorkoutDuration() - getWorkoutTimeElapsed();
  }
  void resetWorkout(String workoutId){
    for(UserSet set in _exerciseService.resetList){
      set.isCompleted = false;
      _exerciseRepository.updateSet(_authenticationService.currentId, workoutId, set);
    }
  }
  void resetResetList() => _exerciseService.resetResetList();
  String getCurrentWorkoutId() =>_exerciseService.getCurrentWorkoutId();
  Duration getWorkoutTimeElapsed() => _exerciseService.getWorkoutTimeElapsed();
  Duration getInitialWorkoutDuration() => _exerciseService.getInitialWorkoutDuration();
  void setNewDuration(Duration duration) => _exerciseService.setWorkoutDuration(duration);
  void setWorkoutID(String id) => _exerciseService.setCurrentWorkoutId(id);
  void setWorkoutIdToEdit(String workoutIdToEdit) => _exerciseService.setCurrentEditWorkoutId(workoutIdToEdit);
  void startWorkoutTimer() => _exerciseService.startWorkoutTimer();
  void setInitialWorkoutDuration(Duration duration) => _exerciseService.setInitialWorkoutDuration(duration);
  void setTempWorkoutId(String workoutId) => _exerciseService.setNewTempWorkoutId(workoutId);
  void resetWorkoutTimer() => _exerciseService.resetWorkoutTimer();
  void pop() => _navigationService.pop();
  void navigateToSettingsView() => _navigationService.navigateToSettingsView();
  void navigateToHomeView() => _navigationService.navigateToHomeView();
  void navigateToCreateWorkoutView(UserWorkout newWorkout) => _navigationService.navigateToCreateWorkoutView(newWorkout);
  void navigateToWorkoutView(String workoutId, Duration duration) => _navigationService.navigateToWorkoutView(workoutId, duration);
  void navigateToEditWorkoutView(UserWorkout workout) => _navigationService.navigateToEditWorkoutView(workout);

  void addWorkoutToHistory(String workoutId) {
    UserWorkout workout = workouts.firstWhere((workout) => workout.workoutId == workoutId);
    workout.workoutId = Uuid().v4();
    workout.workoutDuration = _exerciseService.getInitialWorkoutDuration().toString();
    workout.date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour, DateTime.now().minute, DateTime.now().second).toString();

    _historyRepository.addOrUpdateWorkout(_authenticationService.currentId, workout);

    for(UserExercise exercise in _exerciseService.historyExercises){
      _historyRepository.addOrUpdateExercise(_authenticationService.currentId, workout.workoutId, exercise);
    }

    for(UserSet set in _exerciseService.historySets){
      _historyRepository.addOrUpdateExerciseSets(_authenticationService.currentId, workout.workoutId, set);
    }
  }
}