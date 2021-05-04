import 'package:stacked/stacked.dart';
import 'package:work_around/models/user.dart';
import 'package:work_around/models/user_workout.dart';
import 'package:work_around/models/workout.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/services/repository/user_repository.dart';

class HomeViewModel extends FutureViewModel<User>{
  final NavigationService _navigationService;
  final ExerciseService _exerciseService;
  final AuthenticationService _authenticationService;
  final UserRepository _userRepository;


  HomeViewModel(this._navigationService, this._exerciseService, this._authenticationService, this._userRepository);


  void pop() => _navigationService.pop();
  void navigateToSettingsView() => _navigationService.navigateToSettingsView();
  void navigateToWorkoutView(Duration duration, String workoutId) => _navigationService.navigateToWorkoutView(duration, workoutId);
  void navigateToCreateWorkoutView(UserWorkout newWorkout) => _navigationService.navigateToCreateWorkoutView(newWorkout);
  void navigateToViewExercisesView() => _navigationService.navigateToViewExercisesView();

  void setWorkoutID(String id) => _exerciseService.setCurrentWorkoutId(id);
  //void setCurrentWorkout(UserWorkout workout) => _exerciseService.setCurrentWorkout(workout);
  void startWorkoutTimer() => _exerciseService.startWorkoutTimer();
  void setInitialWorkoutDuration(Duration duration) => _exerciseService. setInitialWorkoutDuration(duration);

  Workout getWorkout(int index) => _exerciseService.getWorkout(index);
  int getNumOfWorkouts() => _exerciseService.getNumOfWorkouts();


  @override
  Future<User> futureToRun() async {
    return _userRepository.getUser(_authenticationService.currentId);
  }



}