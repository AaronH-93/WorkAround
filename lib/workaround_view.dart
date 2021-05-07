import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/services/repository/exercise_repository.dart';
import 'package:work_around/services/repository/history_repository.dart';
import 'package:work_around/services/repository/user_repository.dart';
import 'package:work_around/services/repository/workout_repository.dart';
import 'package:work_around/ui/views/home/welcome_view.dart';
import 'package:work_around/workaround_view_model.dart';

class WorkAroundView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WorkAroundViewModel>.reactive(
        viewModelBuilder: () => WorkAroundViewModel(),
        onModelReady: (model) => model.initialise(),
        builder: (context, model, child) {
          return MultiProvider(
              providers: [
                Provider<NavigationService>.value(
                  value: model.navigationService,
                ),
                Provider<ExerciseService>.value(
                  value: model.exerciseService,
                ),
                Provider<AuthenticationService>.value(
                  value: model.auth,
                ),
                Provider<UserRepository>.value(
                  value: model.userRepository,
                ),
                Provider<WorkoutRepository>.value(
                  value: model.workoutRepository,
                ),
                Provider<ExerciseRepository>.value(
                  value: model.exerciseRepository,
                ),
                Provider<HistoryRepository>.value(
                  value: model.historyRepository,
                ),
              ],
              child: GetMaterialApp(
                title: 'WorkAround',
                //home: model.isUserLoggedIn ? HomeView() : SignInView(),
                home: WelcomeView(),
              ));
        });
  }
}