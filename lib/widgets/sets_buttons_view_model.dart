import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:work_around/models/user_set.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/services/repository/exercise_repository.dart';

class SetsButtonsViewModel extends StreamViewModel<List<UserSet>>{
  final NavigationService _navigationService;
  final ExerciseService _exerciseService;
  final ExerciseRepository _exerciseRepository;
  final AuthenticationService _authenticationService;

  SetsButtonsViewModel(this._navigationService, this._exerciseService, this._exerciseRepository, this._authenticationService);

  String get exerciseId => _exerciseService.currentExerciseId;

  @override
  Stream<List<UserSet>> get stream => _exerciseRepository.getExerciseSets(_authenticationService.currentId, _exerciseService.currentWorkoutId, exerciseId);
  List<UserSet> get userSets => data;

  bool isSetWithinDuration(UserSet set) => _exerciseService.isSetWithinDuration(set);
  void updateSet(UserSet set) => _exerciseRepository.updateSet(_authenticationService.currentId, _exerciseService.currentWorkoutId, set);
  void addSetToBeResetAfterWorkout(UserSet set) => _exerciseService.addSetToResetList(set);
  final snackBar = SnackBar(
    content: Text('Don\'t forget to rest!'),
    action: SnackBarAction(
      label: 'OK',
      onPressed: (){},
    ),
  );

  void addToSetHistory(UserSet set) => _exerciseService.addToHistoricSets(set);
  String getCurrentWorkoutId() =>_exerciseService.getCurrentWorkoutId();
  void setNewDuration(Duration duration) => _exerciseService.setWorkoutDuration(duration);
  Duration getWorkoutTimeElapsed() => _exerciseService.getWorkoutTimeElapsed();
  Duration getInitialWorkoutDuration() => _exerciseService.getInitialWorkoutDuration();
  void navigateToWorkoutView(String workoutId, Duration duration) => _navigationService.navigateToWorkoutView(workoutId, duration);

  void adjustWorkout() {
    setNewDuration(newWorkoutDuration());
    navigateToWorkoutView(getCurrentWorkoutId(), newWorkoutDuration());
  }

  Duration newWorkoutDuration() {
    return getInitialWorkoutDuration() - getWorkoutTimeElapsed();
  }


}