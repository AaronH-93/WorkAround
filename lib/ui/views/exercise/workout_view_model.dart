import 'package:stacked/stacked.dart';
import 'package:work_around/models/exercise.dart';
import 'package:work_around/models/workout.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';

class WorkoutViewModel extends BaseViewModel{
  String _title = 'Workout View';
  String get title => _title;

  final NavigationService _navigationService;
  final ExerciseService _exerciseService;

  WorkoutViewModel(this._navigationService, this._exerciseService);

  Workout getWorkout(int index) => _exerciseService.getWorkout(index);
  int getNumOfWorkouts() => _exerciseService.getNumOfWorkouts();
  void generateSets(int duration, List<Exercise> workout) => _exerciseService.generateSets(duration, workout);
  void pop() => _navigationService.pop();
  void navigateToSettingsView() => _navigationService.navigateToSettingsView();
  void navigateToExercisesView() => _navigationService.navigateToExercisesView();
  void navigateToCreateWorkoutView() => _navigationService.navigateToCreateWorkoutView();
}