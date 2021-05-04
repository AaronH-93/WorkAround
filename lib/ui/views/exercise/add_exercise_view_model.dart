import 'package:stacked/stacked.dart';
import 'package:uuid/uuid.dart';
import 'package:work_around/models/exercise.dart';
import 'package:work_around/models/user_exercise.dart';
import 'package:work_around/models/user_set.dart';
import 'package:work_around/models/user_workout.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/services/repository/exercise_repository.dart';
import 'package:work_around/services/repository/workout_repository.dart';

class AddExerciseViewModel extends BaseViewModel{
  final NavigationService _navigationService;
  final AuthenticationService _authenticationService;
  final ExerciseService _exerciseService;
  final WorkoutRepository _workoutRepository;
  final ExerciseRepository _exerciseRepository;
  int sets;
  int reps;
  int weight;

  AddExerciseViewModel(this._navigationService, this._authenticationService, this._exerciseService, this._workoutRepository, this._exerciseRepository);

  get editPath => _exerciseService.isEditPath;

  void addToTempWorkout(UserExercise exercise) {
    _exerciseService.addToTempWorkout(exercise);
    notifyListeners();
  }

  //Lots of this can probably go in a service
  void generateExercise(UserWorkout newWorkout, Exercise exercise) {
    exercise.exerciseId = Uuid().v4();
    List<UserSet> userSets = [];
    for(int i = 0; i < sets; i++){
      userSets.add(
        UserSet(exerciseId: exercise.exerciseId, setId: Uuid().v4(), effort: exercise.effort, isCompleted: false, setNumber: i + 1, weight: weight)
      );
    }

    UserExercise userExercise = UserExercise(exerciseId: exercise.exerciseId, name: exercise.name, reps: reps, muscleGroup: exercise.muscleGroup);
    _exerciseRepository.addOrUpdateExercise(_authenticationService.currentId, newWorkout.workoutId, userExercise);

    for(UserSet set in userSets){
      _exerciseRepository.addOrUpdateExerciseSets(_authenticationService.currentId, newWorkout.workoutId, set);
    }

    addToTempWorkout(userExercise);
  }

  void navigateToCreateWorkoutView(UserWorkout workout) => _navigationService.navigateToCreateWorkoutView(workout);
  void navigateToEditWorkoutView(UserWorkout workout) => _navigationService.navigateToEditWorkoutView(workout);
}