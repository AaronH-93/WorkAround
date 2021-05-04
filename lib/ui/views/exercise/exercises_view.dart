import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:work_around/models/user_workout.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/services/repository/exercise_repository.dart';
import 'exercises_view_model.dart';

class ExerciseView extends StatefulWidget {
  final UserWorkout workout;
  ExerciseView({this.workout});
  
  @override
  _ExerciseViewState createState() => _ExerciseViewState();
}

class _ExerciseViewState extends State<ExerciseView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExerciseViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    //Implement Search Feature
                    Container(
                      child: ExercisesList(workout: widget.workout),
                    ),
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => ExerciseViewModel(
              Provider.of<NavigationService>(context, listen: false),
              Provider.of<ExerciseService>(context, listen: false),
              Provider.of<AuthenticationService>(context, listen: false),
              Provider.of<ExerciseRepository>(context, listen: false),
            ));
  }
}

class ExercisesList extends ViewModelWidget<ExerciseViewModel> {
  final UserWorkout workout;
  ExercisesList({this.workout});

  @override
  Widget build(BuildContext context, ExerciseViewModel model) {
    return Expanded(
      child: ListView.builder(
          itemBuilder: (context, index) {
            final exercise = model.exerciseList[index];
            return TextButton(
                onPressed: () {
                  model.navigateToAddExerciseView(workout, exercise);
                },
                child: ExerciseTile(name: exercise.name));
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
          borderRadius: buildBorderRadiusTop(),
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

BorderRadius buildBorderRadiusTop() => BorderRadius.only(
    topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0));

BorderRadius buildBorderRadiusBottom() => BorderRadius.only(
    bottomLeft: Radius.circular(10.0), bottomRight: Radius.circular(10.0));
