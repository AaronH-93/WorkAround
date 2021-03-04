import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/services/workout_service.dart';
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
                Provider<WorkoutService>.value(
                  value: model.workoutService,
                ),
                Provider<ExerciseService>.value(
                  value: model.exerciseService,
                ),
              ],
              child: GetMaterialApp(
                title: 'WorkAround',
                home: WelcomeView(),
              ));
        });
  }
}