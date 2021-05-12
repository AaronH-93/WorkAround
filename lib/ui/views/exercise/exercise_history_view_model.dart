import 'package:stacked/stacked.dart';
import 'package:work_around/models/user_exercise.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/services/repository/history_repository.dart';

class ExerciseHistoryViewModel extends StreamViewModel<List<UserExercise>>{
  final NavigationService _navigationService;
  final AuthenticationService _authenticationService;
  final ExerciseService _exerciseService;
  final HistoryRepository _historyRepository;

  ExerciseHistoryViewModel(this._navigationService, this._authenticationService, this._exerciseService, this._historyRepository);

  void setExerciseHistoryId(String exerciseId) => _exerciseService.setExerciseHistoryId(exerciseId);

  @override
  Stream<List<UserExercise>> get stream => _historyRepository.getExercises(_authenticationService.currentId, _exerciseService.getWorkoutHistoryId);
  List<UserExercise> get exercises => data;

  void pop() => _navigationService.pop();

}