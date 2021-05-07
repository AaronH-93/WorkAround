import 'package:stacked/stacked.dart';
import 'package:work_around/models/user_set.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/services/repository/history_repository.dart';

class SetsHistoryViewModel extends StreamViewModel<List<UserSet>>{
  final NavigationService _navigationService;
  final AuthenticationService _authenticationService;
  final ExerciseService _exerciseService;
  final HistoryRepository _historyRepository;

  SetsHistoryViewModel(this._navigationService, this._authenticationService, this._exerciseService, this._historyRepository);

  @override
  Stream<List<UserSet>> get stream => _historyRepository.getExerciseSets(_authenticationService.currentId, _exerciseService.getWorkoutHistoryId, _exerciseService.getExerciseHistoryId);
  List<UserSet> get sets => data;
}