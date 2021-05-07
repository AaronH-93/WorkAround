import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:work_around/models/exercise_data.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/services/repository/exercise_repository.dart';
import 'package:work_around/services/repository/history_repository.dart';
import 'package:work_around/services/repository/user_repository.dart';
import 'package:work_around/services/repository/workout_repository.dart';
import 'package:work_around/services/workout_service.dart';
import 'package:work_around/widgets/exercise_tile_view_model.dart';

import 'models/workout_data.dart';

class WorkAroundViewModel extends BaseViewModel{
  NavigationService navigationService;
  ExerciseService exerciseService;
  ExerciseTileViewModel exerciseTileViewModel;
  ExerciseData exerciseData;
  WorkoutData workoutData;
  AuthenticationService auth;
  UserRepository userRepository;
  WorkoutRepository workoutRepository;
  ExerciseRepository exerciseRepository;
  HistoryRepository historyRepository;

  bool _isUserLoggedIn;

  bool get isUserLoggedIn => _isUserLoggedIn;

  Future<void> initialise() async {
    //setBusy(true);
    userRepository = UserRepository(FirebaseFirestore.instance);
    workoutRepository = WorkoutRepository(FirebaseFirestore.instance);
    exerciseRepository = ExerciseRepository(FirebaseFirestore.instance);
    historyRepository = HistoryRepository(FirebaseFirestore.instance);
    exerciseData = ExerciseData();
    workoutData = WorkoutData();
    navigationService = NavigationService();
    auth = AuthenticationService(FirebaseAuth.instance, userRepository);
    exerciseService = ExerciseService(auth, exerciseData, workoutData, exerciseRepository, workoutRepository);

    _isUserLoggedIn = await auth.isUserLoggedIn();

    //setBusy(false);
  }
}