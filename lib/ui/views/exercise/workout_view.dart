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

class WorkoutView extends StatefulWidget {
  final String workoutId;
  final Duration workoutDuration;

  WorkoutView(this.workoutId, this.workoutDuration);

  @override
  _WorkoutViewState createState() => _WorkoutViewState();
}

class _WorkoutViewState extends State<WorkoutView> {
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExerciseList(workoutDuration: widget.workoutDuration,),
                ),
              ),
            ),
            //Maybe make Finish Workout button its own widget?
            RoundedButton(
                widgetKey: Key('finishWorkoutButton'),
                title: 'Finish Workout',
                color: Colors.red[300],
                onPressed: () {
                  model.addWorkoutToHistory(widget.workoutId);
                  model.resetWorkout(widget.workoutId);
                  model.resetResetList();
                  model.resetWorkoutTimer();
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

