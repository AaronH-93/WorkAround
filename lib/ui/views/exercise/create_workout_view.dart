import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:work_around/components/rounded_button.dart';
import 'package:work_around/models/user_workout.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/services/repository/exercise_repository.dart';
import 'package:work_around/services/repository/workout_repository.dart';
import 'create_workout_view_model.dart';

final controller = TextEditingController();

class CreateWorkoutView extends StatefulWidget {
  final UserWorkout newWorkout;

  const CreateWorkoutView({this.newWorkout});

  @override
  _CreateWorkoutViewState createState() => _CreateWorkoutViewState();
}

class _CreateWorkoutViewState extends State<CreateWorkoutView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateWorkoutViewModel>.reactive(
        key: Key('createWorkoutView'),
        builder: (context, model, child) => Scaffold(
                body: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Create a Workout!',
                    style: TextStyle(color: Colors.redAccent, fontSize: 40.0),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RoundedButton(
                        widgetKey: Key('addExerciseButton'),
                        onPressed: () {
                          model.navigateToExercisesView(widget.newWorkout);
                        },
                        color: Colors.redAccent,
                        title: 'Add Exercise',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TempWorkoutList(),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RoundedButton(
                        widgetKey: Key('finishWorkoutCreation'),
                        title: 'Done',
                        color: Colors.redAccent,
                        onPressed: () {
                          model.navigateToHomeView();
                        },
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      RoundedButton(
                        widgetKey: Key('cancelWorkoutCreation'),
                        title: 'Back',
                        color: Colors.redAccent,
                        onPressed: (){
                          // _showDialog();
                          //Maybe add a prompt asking if they're sure
                          model.deleteWorkout(widget.newWorkout.workoutId);
                          model.setTempWorkoutId('');
                          model.navigateToHomeView();
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            )),
        viewModelBuilder: () => CreateWorkoutViewModel(
              Provider.of<ExerciseService>(context, listen: false),
              Provider.of<NavigationService>(context, listen: false),
              Provider.of<ExerciseRepository>(context, listen: false),
              Provider.of<WorkoutRepository>(context, listen: false),
              Provider.of<AuthenticationService>(context, listen: false),
            ));
  }

// _showDialog() async {
//   await showDialog<String>(
//     context: context,
//     builder: (_) => _AlertDialogBox(context: context),
//   );
// }
}

class TempWorkoutList extends ViewModelWidget<CreateWorkoutViewModel> {
  @override
  Widget build(BuildContext context, CreateWorkoutViewModel model) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey[300],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              key: Key('tempWorkoutList'),
              itemBuilder: (context, index) {
                return model.dataReady
                    ? ExerciseTile(name: model.exercises[index].name)
                    : SizedBox();
              },
              itemCount: model.dataReady ? model.exercises.length : 1,
            ),
          ),
        ),
      ),
    );
  }
}

class ExerciseTile extends StatelessWidget {
  final String name;

  ExerciseTile({this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      key: Key('exerciseTile'),
      children: [
        SizedBox(
          height: 20,
        ),
        //Material widgets is repeat code
        Material(
          elevation: 5,
          borderRadius: buildCircleBorderRadius(),
          color: Colors.redAccent,
          child: Column(
            children: [
              ExerciseContainer(
                text: name,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ExerciseContainer extends StatelessWidget {
  final String text;

  ExerciseContainer({this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('exerciseContainer'),
      padding: EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TileText(text: text),
        ],
      ),
    );
  }
}

class TileText extends StatelessWidget {
  final String text;

  TileText({this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
        color: Colors.white,
      ),
    );
  }
}

BorderRadius buildCircleBorderRadius() => BorderRadius.only(
    topRight: Radius.circular(10.0),
    topLeft: Radius.circular(10.0),
    bottomLeft: Radius.circular(10.0),
    bottomRight: Radius.circular(10.0));
