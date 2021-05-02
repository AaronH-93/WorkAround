import 'package:stacked/stacked.dart';
import 'package:work_around/models/user_set.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/services/repository/exercise_repository.dart';
import 'package:work_around/services/repository/workout_repository.dart';

class ExerciseTileViewModel extends StreamViewModel<List<UserSet>>{
  final NavigationService _navigationService;
  final ExerciseService _exerciseService;
  final WorkoutRepository _workoutRepository;
  final ExerciseRepository _exerciseRepository;
  final AuthenticationService _authenticationService;
  int _length = 0;

  ExerciseTileViewModel(this._navigationService, this._exerciseService, this._workoutRepository, this._exerciseRepository, this._authenticationService);

  String get exerciseId => _exerciseService.exerciseId;

  void setExerciseId(String id) => _exerciseService.setCurrentExerciseId(id);

  Future<void> deleteSet(String setId) async {
    _exerciseRepository.deleteSet(_authenticationService.currentId, _exerciseService.workoutId, exerciseId, setId);
  }

  bool get setsExist => data != null;

  @override
  Stream<List<UserSet>> get stream => _exerciseRepository.getExerciseSets(_authenticationService.currentId, _exerciseService.workoutId, exerciseId);

  List<UserSet> get userSets => data;

  bool isSetWithinDuration(UserSet set) => _exerciseService.isSetWithinDuration(set);

  void markSet(UserSet set) => _exerciseRepository.markSet(_authenticationService.currentId, _exerciseService.workoutId, set);

  //void generateSets(List<UserSet> userSets) => _exerciseService.generateSetsII(userSets);
  //void generateSets() => _exerciseService.generateSetsII(userSets);
  //
  // @override
  // void onData(List<UserSet> data) {
  //   _exerciseService.generateSetsII(data);
  // }
}
