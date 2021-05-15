import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/services/repository/exercise_repository.dart';
import 'package:work_around/services/repository/history_repository.dart';
import 'package:work_around/services/repository/notes_repository.dart';
import 'package:work_around/services/repository/user_repository.dart';
import 'package:work_around/services/repository/workout_repository.dart';

class WorkAroundViewModel extends BaseViewModel{
  NavigationService navigationService;
  ExerciseService exerciseService;
  AuthenticationService auth;
  UserRepository userRepository;
  WorkoutRepository workoutRepository;
  ExerciseRepository exerciseRepository;
  HistoryRepository historyRepository;
  NotesRepository noteRepository;

  Future<void> initialise() async {
    userRepository = UserRepository(FirebaseFirestore.instance);
    workoutRepository = WorkoutRepository(FirebaseFirestore.instance);
    exerciseRepository = ExerciseRepository(FirebaseFirestore.instance);
    historyRepository = HistoryRepository(FirebaseFirestore.instance);
    noteRepository = NotesRepository(FirebaseFirestore.instance);
    navigationService = NavigationService();
    auth = AuthenticationService(FirebaseAuth.instance, userRepository);
    exerciseService = ExerciseService();
  }
}
