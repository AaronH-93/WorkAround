import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:work_around/components/rounded_button.dart';
import 'package:work_around/models/user_exercise.dart';
import 'package:work_around/models/user_workout.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/services/repository/exercise_repository.dart';
import 'package:work_around/ui/views/exercise/edit_workout_view_model.dart';

class EditWorkoutView extends StatefulWidget {
  final UserWorkout workout;

  const EditWorkoutView({this.workout});

  @override
  _EditWorkoutViewState createState() => _EditWorkoutViewState();
}

class _EditWorkoutViewState extends State<EditWorkoutView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditWorkoutViewModel>.reactive(
      key: Key('editWorkoutView'),
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  '${widget.workout.name}',
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.redAccent,
                  ),
                ),
                RoundedButton(onPressed: (){
                  model.setEditPath(true);
                  model.navigateToAddExerciseView(widget.workout);
                },
                  title: 'Add Exercise',
                  color: Colors.redAccent,
                  widgetKey: Key('addExerciseButton'),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Material(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey[300],
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return model.dataReady
                            ? EditExerciseTile(exercise: model.exercises[index], workout: widget.workout)
                            : Container(
                                child: Text('Loading...'),
                              );
                      },
                      itemCount: model.dataReady ? model.exercises.length : 1,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RoundedButton(
                  widgetKey: Key('finishEditExerciseButton'),
                  onPressed: () {
                    model.setEditPath(false);
                    model.navigateToHomeView();
                  },
                  title: 'Done',
                  color: Colors.redAccent,
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => EditWorkoutViewModel(
        Provider.of<AuthenticationService>(context, listen: false),
        Provider.of<NavigationService>(context, listen: false),
        Provider.of<ExerciseService>(context, listen: false),
        Provider.of<ExerciseRepository>(context, listen: false),
      ),
    );
  }
}

class EditExerciseTile extends ViewModelWidget<EditWorkoutViewModel> {
  final UserExercise exercise;
  final UserWorkout workout;

  EditExerciseTile({this.exercise, this.workout});

  @override
  Widget build(BuildContext context, EditWorkoutViewModel model) {
    return EditExerciseContainer(exercise: exercise, workout: workout);
  }
}

class EditExerciseContainer extends ViewModelWidget<EditWorkoutViewModel> {
  final UserExercise exercise;
  final UserWorkout workout;

  EditExerciseContainer({this.exercise, this.workout});

  @override
  Widget build(BuildContext context, EditWorkoutViewModel model) {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          EditTileText(text: exercise.name),
          TextButton(
            key: Key('${exercise.name}_editExerciseButton'),
            onPressed: () {
              model.setEditPath(true);
              model.setExerciseToEditId(exercise.exerciseId);
              model.navigateToEditExerciseView(exercise, workout);
            },
            child: Text('Edit'),
          ),
          TextButton(
            key: Key('${exercise.name}_deleteExerciseButton'),
            onPressed: () {
              model.deleteExercise(exercise.exerciseId);
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class EditTileText extends StatelessWidget {
  final String text;

  EditTileText({this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.redAccent,
        fontSize: 20,
      ),
    );
  }
}

BorderRadius buildCircleBorderRadius() => BorderRadius.only(
    topRight: Radius.circular(10.0),
    topLeft: Radius.circular(10.0),
    bottomLeft: Radius.circular(10.0),
    bottomRight: Radius.circular(10.0));
