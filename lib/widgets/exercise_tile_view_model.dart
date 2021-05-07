import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:work_around/models/user_set.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/services/repository/exercise_repository.dart';
import 'package:work_around/services/repository/workout_repository.dart';

class ExerciseTileViewModel extends StreamViewModel<List<UserSet>>{
  final NavigationService _navigationService;
  final ExerciseService _exerciseService;
  final WorkoutRepository _workoutRepository;
  final ExerciseRepository _exerciseRepository;
  final AuthenticationService _authenticationService;
  int _length = 0;

  ExerciseTileViewModel(this._navigationService, this._exerciseService, this._workoutRepository, this._exerciseRepository, this._authenticationService);

  String get exerciseId => _exerciseService.exerciseId;

  void setExerciseId(String id) => _exerciseService.setCurrentExerciseId(id);

  Future<void> deleteSet(String setId) async {
    _exerciseRepository.deleteSet(_authenticationService.currentId, _exerciseService.workoutId, exerciseId, setId);
  }

  bool get setsExist => data != null;

  @override
  Stream<List<UserSet>> get stream => _exerciseRepository.getExerciseSets(_authenticationService.currentId, _exerciseService.workoutId, exerciseId);

  List<UserSet> get userSets => data;

  bool isSetWithinDuration(UserSet set) => _exerciseService.isSetWithinDuration(set);

  void updateSet(UserSet set) => _exerciseRepository.updateSet(_authenticationService.currentId, _exerciseService.workoutId, set);

  void addSetToBeResetAfterWorkout(UserSet set) => _exerciseService.addSetToResetList(set);

  final snackBar = SnackBar(
    content: Text('Rest!'),
    action: SnackBarAction(
      label: 'OK',
      onPressed: (){

      },
    ),
  );

  String getCurrentWorkoutId() =>_exerciseService.getCurrentWorkoutId();
  void navigateToNewWorkoutView(Duration duration, String workoutId) => _navigationService.navigateToNewWorkoutView(duration, workoutId);
  void setNewDuration(Duration duration) => _exerciseService.setWorkoutDuration(duration);
  Duration getWorkoutTimeElapsed() => _exerciseService.getWorkoutTimeElapsed();
  Duration getInitialWorkoutDuration() => _exerciseService.getInitialWorkoutDuration();
  void navigateToWorkoutView(Duration duration, String workoutId) => _navigationService.navigateToWorkoutView(duration, workoutId);

  void adjustWorkout() {
    setNewDuration(newWorkoutDuration());
    navigateToWorkoutView(newWorkoutDuration(), getCurrentWorkoutId());
  }

  Duration newWorkoutDuration() {
    return getInitialWorkoutDuration() - getWorkoutTimeElapsed();
  }

  void addToSetHistory(UserSet set) => _exerciseService.addToHistoricSets(set);
}
