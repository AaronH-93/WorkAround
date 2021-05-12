import 'package:stacked/stacked.dart';
import 'package:work_around/models/user_exercise.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';

class ViewExercisesViewModel extends BaseViewModel {
  final NavigationService _navigationService;
  final ExerciseService _exerciseService;

  ViewExercisesViewModel(this._navigationService, this._exerciseService);

  List<UserExercise> get searchableList => _exerciseService.exercises;
  List<UserExercise> searchList = [];

  void initList() {
    searchList.addAll(searchableList);
  }

  void navigateToExerciseInformationView(UserExercise exercise) =>
      _navigationService.navigateToExerciseInformationView(exercise);

  void filterSearchResults(String query) {
    final exercises = searchableList
        .where((exercise) {
          final exerciseNameLower = exercise.name.toLowerCase();
          final muscleGroupLower = exercise.muscleGroup.toLowerCase();
          final equipmentLower = exercise.equipment.toLowerCase();
          final searchQuery = query.toLowerCase();

          return exerciseNameLower.contains(searchQuery) || muscleGroupLower.contains(searchQuery) || equipmentLower.contains(searchQuery);
        }).toList();
    searchList = exercises;
    notifyListeners();
  }
}
