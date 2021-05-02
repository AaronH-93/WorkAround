import 'package:stacked/stacked.dart';
import 'package:work_around/models/ExerciseSet.dart';
import 'package:work_around/models/exercise.dart';
import 'package:work_around/models/user_exercise.dart';
import 'package:work_around/models/user_workout.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/services/repository/exercise_repository.dart';

class ExerciseViewModel extends StreamViewModel<List<UserExercise>> {
  final NavigationService _navigationService;
  final ExerciseService _exerciseService;
  final AuthenticationService _authenticationService;
  final ExerciseRepository _exerciseRepository;
  String _workoutId;

  ExerciseViewModel(this._navigationService, this._exerciseService,
      this._authenticationService, this._exerciseRepository);

  void generateSets(Duration duration, List<Exercise> workout) =>
      _exerciseService.generateSets(duration, workout);

  void pop() => _navigationService.pop();
  void navigateToSettingsView() => _navigationService.navigateToSettingsView();
  void navigateToAddExerciseView(UserWorkout newWorkout, Exercise exercise) => _navigationService.navigateToAddExerciseView(newWorkout, exercise);
  //void navigateToWorkoutView() => _navigationService.navigateToWorkoutView();

  void addToTempWorkout(UserExercise exercise) {
    _exerciseService.addToTempWorkout(exercise);
    notifyListeners();
  }

  int getNumOfExercises() {
    return _exerciseService.exercises.length;
  }

  @override
  Stream<List<UserExercise>> get stream => _exerciseRepository.getExercises(
      _authenticationService.currentId, _exerciseService.workoutId);

  List<Exercise> get exerciseList => _exerciseService.exercises;

  List<UserExercise> get exercises => data;

  void setWorkoutId(String workoutId) {
    _workoutId = workoutId;
  }

  void setExerciseId(String id) => _exerciseService.setCurrentExerciseId(id);
}
