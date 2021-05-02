import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:work_around/models/user_workout.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/services/repository/exercise_repository.dart';
import 'package:work_around/services/repository/workout_repository.dart';
import 'create_workout_view_model.dart';

final controller = TextEditingController();

class CreateWorkoutView extends StatefulWidget {
  //This should go into exercise service
  final UserWorkout newWorkout;

  const CreateWorkoutView({this.newWorkout});


  @override
  _CreateWorkoutViewState createState() => _CreateWorkoutViewState();
}

class _CreateWorkoutViewState extends State<CreateWorkoutView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateWorkoutViewModel>.reactive(
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
                      Material(
                        elevation: 5,
                        color: Colors.redAccent,
                        child: TextButton(
                          onPressed: () {
                            model.navigateToExercisesView(widget.newWorkout);
                          },
                          child: Text(
                            'ADD EXERCISE',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  TempWorkoutList(),

                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Material(
                        elevation: 5,
                        color: Colors.redAccent,
                        child: TextButton(
                          onPressed: () {
                            // _showDialog();
                            //Maybe add a prompt asking if they're sure
                            model.deleteWorkout(widget.newWorkout.workoutId);
                            model.navigateToHomeView();
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Material(
                        elevation: 5,
                        color: Colors.redAccent,
                        child: TextButton(
                          onPressed: () {
                            // _showDialog();
                            //Maybe add a prompt asking if they're sure
                            model.navigateToHomeView();
                          },
                          child: Text(
                            'Done!',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
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
      child: ListView.builder(
        itemBuilder: (context, index) {
          final workout = model.getTempWorkout(index);
          return ExerciseTile(name: workout.name);
        },
        itemCount: model.getNumOfExercises(),
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
      children: [
        SizedBox(
          height: 20,
        ),
        //Material widgets is repeat code
        Material(
          elevation: 5,
          borderRadius: buildCircleBorderRadius(),
          color: Colors.white,
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
      ),
    );
  }
}

// class _AlertDialogBox extends StatelessWidget {
//   final BuildContext context;
//
//   _AlertDialogBox({this.context});
//
//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<CreateWorkoutViewModel>.reactive(
//         builder: (context, model, child) => AlertDialog(
//               contentPadding: EdgeInsets.all(16.0),
//               content: Row(
//                 children: <Widget>[
//                   Expanded(
//                     child: TextField(
//                       controller: controller,
//                       autofocus: true,
//                       decoration: InputDecoration(
//                           labelText: 'Enter Workout Name',
//                           hintText: 'Workout 1'),
//                     ),
//                   )
//                 ],
//               ),
//               actions: <Widget>[
//                 _AlertDialogButton(
//                   text: 'Cancel',
//                   onPressed: () {
//                     model.pop();
//                   },
//                 ),
//                 _AlertDialogButton(
//                   text: 'Confirm',
//                   onPressed: () {
//                     model.addWorkout(controller.text);
//                     model.navigateToHomeView();
//                   },
//                 ),
//               ],
//             ),
//         viewModelBuilder: () => CreateWorkoutViewModel(
//               Provider.of<ExerciseService>(context, listen: false),
//               Provider.of<NavigationService>(context, listen: false),
//               Provider.of<ExerciseRepository>(context, listen: false),
//               Provider.of<WorkoutRepository>(context, listen: false),
//             ));
//   }
// }
//
// class _AlertDialogButton extends StatelessWidget {
//   final String text;
//   final Function onPressed;
//
//   _AlertDialogButton({this.text, this.onPressed});
//
//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       child: Text(text),
//       onPressed: onPressed,
//     );
//   }
// }

BorderRadius buildCircleBorderRadius() => BorderRadius.only(
    topRight: Radius.circular(10.0),
    topLeft: Radius.circular(10.0),
    bottomLeft: Radius.circular(10.0),
    bottomRight: Radius.circular(10.0));
