import 'package:stacked/stacked.dart';
import 'package:work_around/models/user_workout.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/services/repository/history_repository.dart';

class WorkoutHistoryViewModel extends StreamViewModel<List<UserWorkout>>{
  final NavigationService _navigationService;
  final AuthenticationService _authenticationService;
  final ExerciseService _exerciseService;
  final HistoryRepository _historyRepository;

  WorkoutHistoryViewModel(this._navigationService, this._authenticationService, this._exerciseService, this._historyRepository);

  @override
  Stream<List<UserWorkout>> get stream => _historyRepository.getWorkouts(_authenticationService.currentId);
  List<UserWorkout> get workouts => data;

  void navigateToExerciseHistoryView() => _navigationService.navigateToExerciseHistoryView();
  void navigateToHomeView() => _navigationService.navigateToHomeView();
  void setWorkoutHistoryId(String workoutId) => _exerciseService.setWorkoutHistoryId(workoutId);
}