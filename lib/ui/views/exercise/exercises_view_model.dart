import 'package:stacked/stacked.dart';
import 'package:work_around/models/exercise.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';

class ExerciseViewModel extends BaseViewModel{
  String _title = 'Exercise View';
  String get title => _title;

  final NavigationService _navigationService;
  final ExerciseService _exerciseService;

  ExerciseViewModel(this._navigationService, this._exerciseService);

  void pop() => _navigationService.pop();
  void navigateToSettingsView() => _navigationService.navigateToSettingsView();
  //void navigateToWorkoutView() => _navigationService.navigateToWorkoutView();
  void navigateToCreateWorkoutView() => _navigationService.navigateToCreateWorkoutView();

  void addToTempWorkout(Exercise exercise){
    _exerciseService.addToTempWorkout(exercise);
    notifyListeners();
  }

  Exercise getExercise(int index){
    return _exerciseService.exercises[index];
  }

  int getNumOfExercises(){
    return _exerciseService.exercises.length;
  }

}