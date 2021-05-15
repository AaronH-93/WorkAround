import 'package:stacked/stacked.dart';
import 'package:uuid/uuid.dart';
import 'package:work_around/models/user_exercise.dart';
import 'package:work_around/models/user_set.dart';
import 'package:work_around/models/user_workout.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/services/repository/exercise_repository.dart';

class AddExerciseViewModel extends BaseViewModel{
  final NavigationService _navigationService;
  final AuthenticationService _authenticationService;
  final ExerciseService _exerciseService;
  final ExerciseRepository _exerciseRepository;
  int sets;
  int reps;
  int weight;

  AddExerciseViewModel(this._navigationService, this._authenticationService, this._exerciseService, this._exerciseRepository);

  get editPath => _exerciseService.isEditPath;

  void addToTempWorkout(UserExercise exercise) {
    _exerciseService.addToTempWorkout(exercise);
  }

  void generateExercise(UserWorkout newWorkout, UserExercise exercise) {
    exercise.exerciseId = Uuid().v4();
    exercise.reps = reps;
    exercise.weight = weight;
    List<UserSet> userSets = [];
    for(int i = 0; i < sets; i++){
      userSets.add(
        UserSet(exerciseId: exercise.exerciseId, setId: Uuid().v4(), effort: _exerciseService.effortMap[exercise.name], isCompleted: false)
      );
    }
    _exerciseRepository.addOrUpdateExercise(_authenticationService.currentId, newWorkout.workoutId, exercise);

    for(UserSet set in userSets){
      _exerciseRepository.addOrUpdateExerciseSets(_authenticationService.currentId, newWorkout.workoutId, set);
    }

    addToTempWorkout(exercise);
  }

  void navigateToCreateWorkoutView(UserWorkout workout) => _navigationService.navigateToCreateWorkoutView(workout);
  void navigateToEditWorkoutView(UserWorkout workout) => _navigationService.navigateToEditWorkoutView(workout);
  void pop() => _navigationService.pop();
}