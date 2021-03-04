import 'package:stacked/stacked.dart';
import 'package:work_around/models/exercise.dart';
import 'package:work_around/models/workout.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';

class CreateWorkoutViewModel extends BaseViewModel{
  String _title = 'Create Workout View';
  String get title => _title;

  final NavigationService _navigationService;
  final ExerciseService _exerciseService;

  CreateWorkoutViewModel(this._exerciseService, this._navigationService);

  void pop() => _navigationService.pop();
  void navigateToExercisesView() => _navigationService.navigateToExercisesView();
  void navigateToHomeView() => _navigationService.navigateToHomeView();
  Exercise getTempWorkout(index) => _exerciseService.getTempWorkout(index);
  int getNumOfExercises() => _exerciseService.getNumOfExercises();

  void addWorkout(String workoutName){
    _exerciseService.addWorkout(workoutName);
    _exerciseService.setTemp(Workout(name: 'Temp', workoutList: []));
    notifyListeners();
  }
}