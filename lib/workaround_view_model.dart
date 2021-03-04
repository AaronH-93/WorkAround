import 'package:stacked/stacked.dart';
import 'package:work_around/models/exercise_data.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/services/workout_service.dart';

import 'models/workout_data.dart';

class WorkAroundViewModel extends BaseViewModel{
  NavigationService navigationService;
  WorkoutService workoutService;
  ExerciseService exerciseService;
  ExerciseData exerciseData;
  WorkoutData workoutData;

  Future<void> initialise() async {
    //setBusy(true);
    exerciseData = ExerciseData();
    workoutData = WorkoutData();
    navigationService = NavigationService();
    workoutService = WorkoutService(exerciseData);
    exerciseService = ExerciseService(exerciseData, workoutData);
    //setBusy(false);
  }
}