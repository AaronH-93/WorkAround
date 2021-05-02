import 'package:stacked/stacked.dart';
import 'package:work_around/models/exercise_data.dart';
import 'package:work_around/models/user_exercise.dart';
import 'package:work_around/models/user_workout.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/repository/exercise_repository.dart';
import 'package:work_around/services/repository/workout_repository.dart';

import 'authentication_service.dart';

class WorkoutService{
  final WorkoutRepository _workoutRepository;
  final ExerciseRepository _exerciseRepository;
  final AuthenticationService _authenticationService;
  final ExerciseService _exerciseService;

  WorkoutService(this._workoutRepository, this._exerciseRepository, this._authenticationService, this._exerciseService);

}