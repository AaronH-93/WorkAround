import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:work_around/components/rounded_button.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/services/repository/exercise_repository.dart';
import 'package:work_around/services/repository/history_repository.dart';
import 'package:work_around/services/repository/workout_repository.dart';
import 'package:work_around/widgets/exercise_list.dart';
import 'workout_view_model.dart';

class WorkoutView extends StatelessWidget {
  final Duration duration;
  final String workoutId;

  WorkoutView(this.duration, this.workoutId);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WorkoutViewModel>.reactive(
      key: Key('workoutView'),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.grey,
        body: Column(
          children: [
            Expanded(
              child: Container(
                child: ExerciseList(
                  workoutDuration: duration,
                  workoutId: workoutId,
                ),
              ),
            ),
            //Maybe make Finish Workout button its own widget?
            RoundedButton(
                widgetKey: Key('finishWorkoutButton'),
                title: 'Finish Workout',
                color: Colors.red[300],
                onPressed: () {
                  model.addWorkoutToHistory(workoutId);
                  model.resetWorkout(workoutId);
                  model.resetResetList();
                  model.navigateToHomeView();
                }),
          ],
        ),
      ),
      viewModelBuilder: () => WorkoutViewModel(
        Provider.of<NavigationService>(context, listen: false),
        Provider.of<ExerciseService>(context, listen: false),
        Provider.of<WorkoutRepository>(context, listen: false),
        Provider.of<AuthenticationService>(context, listen: false),
        Provider.of<ExerciseRepository>(context, listen: false),
        Provider.of<HistoryRepository>(context, listen: false),
      ),
    );
  }
}
