import 'package:stacked/stacked.dart';
import 'package:work_around/models/workout.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';

class HomeViewModel extends BaseViewModel{
  String _title = 'Home View';
  String get title => _title;

  final NavigationService _navigationService;
  final ExerciseService _exerciseService;

  HomeViewModel(this._navigationService, this._exerciseService);

  Workout getWorkout(int index) => _exerciseService.getWorkout(index);
  int getNumOfWorkouts() => _exerciseService.getNumOfWorkouts();
  void pop() => _navigationService.pop();
  void navigateToSettingsView() => _navigationService.navigateToSettingsView();
  void navigateToWorkoutView(int duration, Workout workout) => _navigationService.navigateToWorkoutView(duration, workout);
  void navigateToExercisesView() => _navigationService.navigateToExercisesView();
  void navigateToCreateWorkoutView() => _navigationService.navigateToCreateWorkoutView();


}