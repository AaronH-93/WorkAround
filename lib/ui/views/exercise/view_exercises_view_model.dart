import 'package:stacked/stacked.dart';
import 'package:work_around/models/exercise.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';

class ViewExercisesViewModel extends BaseViewModel {
  final NavigationService _navigationService;
  final ExerciseService _exerciseService;

  ViewExercisesViewModel(this._navigationService, this._exerciseService);

  List<Exercise> get searchableList => _exerciseService.exerciseInformation;
  List<Exercise> searchList = [];

  void initList(){
    searchList.addAll(searchableList);
  }

  void navigateToExerciseInformationView(Exercise exercise) =>
      _navigationService.navigateToExerciseInformationView(exercise);

  void filterSearchResults(String query) {
    final exercises = searchableList.where((exercise) {
      final exerciseNameLower = exercise.name.toLowerCase();
      final searchQuery = query.toLowerCase();

      return exerciseNameLower.contains(searchQuery);
    }).toList();
    searchList = exercises;
    notifyListeners();
  }

// void filterSearchResults(String query) {
  //   List<Exercise> dummySearchList = [];
  //   dummySearchList.addAll(searchableList);
  //   if(query.isNotEmpty) {
  //     List<Exercise> dummyListData = [];
  //     dummySearchList.forEach((item) {
  //       if(item.name.contains(query)) {
  //         dummyListData.add(item);
  //       }
  //     });
  //     searchableList.clear();
  //     searchableList.addAll(dummyListData);
  //     return;
  //   } else {
  //     searchableList.clear();
  //     searchableList.addAll(searchableList);
  //   }
  // }
}
