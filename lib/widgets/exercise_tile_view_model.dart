import 'package:stacked/stacked.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';

class ExerciseTileViewModel extends BaseViewModel{
  final NavigationService _navigationService;
  final ExerciseService _exerciseService;

  ExerciseTileViewModel(this._navigationService, this._exerciseService);

  void navigateToViewNotesView(String exerciseName) => _navigationService.navigateToViewNoteView(exerciseName);

  void setExerciseIdForNotes(String exerciseId) => _exerciseService.setExerciseIdForNotes(exerciseId);

}
