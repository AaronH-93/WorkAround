import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:work_around/components/rounded_button.dart';
import 'package:work_around/models/user_workout.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/services/repository/history_repository.dart';
import 'package:work_around/ui/views/exercise/exercise_information_view.dart';
import 'package:work_around/ui/views/exercise/workout_history_view_model.dart';

class WorkoutHistoryView extends StatefulWidget {
  @override
  _WorkoutHistoryViewState createState() => _WorkoutHistoryViewState();
}

class _WorkoutHistoryViewState extends State<WorkoutHistoryView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WorkoutHistoryViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Workout History',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey[300],
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return model.dataReady
                          ? HistoricWorkoutContainer(model.workouts[index])
                          : SizedBox();
                    },
                    itemCount: model.dataReady ? model.workouts.length : 1,
                  ),
                ),
              ),
            ),
            RoundedButton(
              title: "Back",
              color: Colors.redAccent,
              onPressed: () {
                model.navigateToHomeView();
              },
            ),
          ],
        ),
      ),
      viewModelBuilder: () => WorkoutHistoryViewModel(
        Provider.of<NavigationService>(context, listen: false),
        Provider.of<AuthenticationService>(context, listen: false),
        Provider.of<ExerciseService>(context, listen: false),
        Provider.of<HistoryRepository>(context, listen: false),
      ),
    );
  }
}

class HistoricWorkoutContainer extends ViewModelWidget<WorkoutHistoryViewModel> {
  final UserWorkout workout;
  HistoricWorkoutContainer(this.workout);

  @override
  Widget build(BuildContext context, WorkoutHistoryViewModel model) {
    return TextButton(
      onPressed: () {
        model.navigateToExerciseHistoryView();
        model.setWorkoutHistoryId(workout.workoutId);
      },
      style: TextButton.styleFrom(
        primary: Colors.black,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Material(
              elevation: 5,
              borderRadius: buildBorderRadiusTop(),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        workout.name,
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Material(
              borderRadius: buildBorderRadiusBottom(),
              elevation: 5,
              color: Colors.red[300],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Date Completed: ${workout.date.split(' ')[0]}',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Workout Duration: ${workout.workoutDuration}',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

BorderRadius buildBorderRadiusTop() => BorderRadius.only(
    topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0));

BorderRadius buildBorderRadiusBottom() => BorderRadius.only(
    bottomLeft: Radius.circular(10.0), bottomRight: Radius.circular(10.0));
