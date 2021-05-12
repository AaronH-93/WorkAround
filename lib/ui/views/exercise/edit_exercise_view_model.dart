import 'package:stacked/stacked.dart';
import 'package:uuid/uuid.dart';
import 'package:work_around/models/user_exercise.dart';
import 'package:work_around/models/user_set.dart';
import 'package:work_around/models/user_workout.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/services/repository/exercise_repository.dart';

class EditExerciseViewModel extends StreamViewModel<List<UserSet>>{
  final AuthenticationService _authenticationService;
  final NavigationService _navigationService;
  final ExerciseService _exerciseService;
  final ExerciseRepository _exerciseRepository;
  int weight;
  int reps;
  int sets;

  EditExerciseViewModel(this._authenticationService, this._navigationService, this._exerciseService, this._exerciseRepository);

  @override
  Stream<List<UserSet>> get stream => _exerciseRepository.getExerciseSets(_authenticationService.currentId, _exerciseService.getWorkoutIdToEdit, _exerciseService.getExerciseIdToEdit);
  List<UserSet> get oldUserSets => data;

  void updateExercise(UserExercise exercise) {
      List<UserSet> userSets = [];
      for(int i = 0; i < sets; i++){
        userSets.add(
            UserSet(
                exerciseId: exercise.exerciseId,
                setId: Uuid().v4(),
                effort: _exerciseService.effortMap[exercise.name],
                isCompleted: false,
            ),
        );
      }

      UserExercise userExercise = UserExercise(exerciseId: exercise.exerciseId, name: exercise.name, reps: reps, weight: weight, muscleGroup: exercise.muscleGroup);
      _exerciseRepository.addOrUpdateExercise(_authenticationService.currentId, _exerciseService.getWorkoutIdToEdit, userExercise);

      _exerciseRepository.clearSets(_authenticationService.currentId, _exerciseService.getWorkoutIdToEdit, _exerciseService.getExerciseIdToEdit);

      for(UserSet set in userSets){
        _exerciseRepository.addOrUpdateExerciseSets(_authenticationService.currentId, _exerciseService.getWorkoutIdToEdit, set);
      }
  }

  void navigateToEditWorkoutView(UserWorkout workout) => _navigationService.navigateToEditWorkoutView(workout);

  void pop() => _navigationService.pop();
}


