import 'package:stacked/stacked.dart';
import 'package:work_around/models/exercise.dart';
import 'package:work_around/models/user_exercise.dart';
import 'package:work_around/models/user_workout.dart';
import 'package:work_around/models/workout.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/services/repository/exercise_repository.dart';
import 'package:work_around/services/repository/workout_repository.dart';

class CreateWorkoutViewModel extends BaseViewModel{
  String _title = 'Create Workout View';
  String get title => _title;

  final NavigationService _navigationService;
  final ExerciseService _exerciseService;
  final ExerciseRepository _exerciseRepository;
  final WorkoutRepository _workoutRepository;
  final AuthenticationService _authenticationService;


  CreateWorkoutViewModel(this._exerciseService, this._navigationService, this._exerciseRepository, this._workoutRepository, this._authenticationService);

  void pop() => _navigationService.pop();
  void navigateToExercisesView(UserWorkout newWorkout) => _navigationService.navigateToExercisesView(newWorkout);
  void navigateToHomeView() => _navigationService.navigateToHomeView();
  UserExercise getTempWorkout(index) => _exerciseService.getTempWorkout(index);
  int getNumOfExercises() => _exerciseService.getNumOfExercises();

  void addWorkout(String workoutName){
    _exerciseService.addWorkout(workoutName);
    _exerciseService.setTemp(Workout(name: 'Temp', exerciseList: []));
    notifyListeners();
  }

  void deleteWorkout(String workoutId) => _workoutRepository.deleteWorkout(_authenticationService.currentId, workoutId);
}