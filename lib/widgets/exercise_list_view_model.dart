import 'package:stacked/stacked.dart';
import 'package:work_around/models/user_exercise.dart';
import 'package:work_around/models/user_workout.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/services/repository/exercise_repository.dart';

class ExerciseListViewModel extends StreamViewModel<List<UserExercise>> {
  final NavigationService _navigationService;
  final ExerciseService _exerciseService;
  final AuthenticationService _authenticationService;
  final ExerciseRepository _exerciseRepository;
  String _workoutId;

  ExerciseListViewModel(this._navigationService, this._exerciseService,
      this._authenticationService, this._exerciseRepository);


  void pop() => _navigationService.pop();
  void navigateToSettingsView() => _navigationService.navigateToSettingsView();
  void navigateToAddExerciseView(UserWorkout newWorkout, UserExercise exercise) => _navigationService.navigateToAddExerciseView(newWorkout, exercise);

  void addToTempWorkout(UserExercise exercise) {
    _exerciseService.addToTempWorkout(exercise);
    notifyListeners();
  }

  int getNumOfExercises() {
    return _exerciseService.exercises.length;
  }

  @override
  Stream<List<UserExercise>> get stream => _exerciseRepository.getExercises(_authenticationService.currentId, _exerciseService.currentWorkoutId);
  List<UserExercise> get exercises => data;
  List<UserExercise> get exerciseList => _exerciseService.exercises;

  void setWorkoutId(String workoutId) {
    _workoutId = workoutId;
  }
  void setExerciseId(String id) => _exerciseService.setCurrentExerciseId(id);
  void addToExercisesHistory(UserExercise exercise) => _exerciseService.addToHistoricExercises(exercise);
}
