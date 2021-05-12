import 'package:stacked/stacked.dart';
import 'package:work_around/models/user_exercise.dart';
import 'package:work_around/models/user_workout.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/services/repository/exercise_repository.dart';

class EditWorkoutViewModel extends StreamViewModel<List<UserExercise>>{
  final AuthenticationService _authenticationService;
  final NavigationService _navigationService;
  final ExerciseService _exerciseService;
  final ExerciseRepository _exerciseRepository;

  bool setEditPath(bool editPath) => _exerciseService.setEditPath(editPath);

  EditWorkoutViewModel(this._authenticationService, this._navigationService, this._exerciseService, this._exerciseRepository);

  @override
  Stream<List<UserExercise>> get stream => _exerciseRepository.getExercises(_authenticationService.currentId, _exerciseService.getWorkoutIdToEdit);
  List<UserExercise> get exercises => data;

  void navigateToHomeView() => _navigationService.navigateToHomeView();
  void navigateToAddExerciseView(UserWorkout workout) => _navigationService.navigateToExercisesView(workout);
  void navigateToEditExerciseView(UserExercise exercise, UserWorkout workout) => _navigationService.navigateToEditExerciseView(workout, exercise);
  void setExerciseToEditId(String id) => _exerciseService.setCurrentExerciseIdToEdit(id);
  void deleteExercise(String exerciseId) => _exerciseRepository.deleteExercise(_authenticationService.currentId, _exerciseService.getWorkoutIdToEdit, exerciseId);



}