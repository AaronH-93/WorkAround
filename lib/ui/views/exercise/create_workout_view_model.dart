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

class CreateWorkoutViewModel extends StreamViewModel<List<UserExercise>>{
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

  void deleteWorkout(String workoutId) => _workoutRepository.deleteWorkout(_authenticationService.currentId, workoutId);

  @override
  Stream<List<UserExercise>> get stream => _exerciseRepository.getExercises(_authenticationService.currentId, _exerciseService.getNewTempWorkoutId);
  List<UserExercise> get exercises => data;

  void setTempWorkoutId(String id) => _exerciseService.setNewTempWorkoutId(id);
}