import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/services/repository/exercise_repository.dart';
import 'package:work_around/services/repository/workout_repository.dart';
import 'exercise_tile_view_model.dart';
import 'sets_buttons.dart';

class ExerciseTile extends StatefulWidget {
  final String exerciseId;
  final String name;
  final int reps;
  final Duration workoutDuration;
  final String instructions;

  ExerciseTile(
      {this.exerciseId,
      this.name,
      this.reps,
      this.workoutDuration,
      this.instructions});

  @override
  _ExerciseTileState createState() => _ExerciseTileState();
}

class _ExerciseTileState extends State<ExerciseTile> {
  @override
  void initState() {
    super.initState();
    Provider.of<ExerciseService>(context, listen: false).exerciseId =
        widget.exerciseId;
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExerciseTileViewModel>.reactive(
      viewModelBuilder: () => ExerciseTileViewModel(
        Provider.of<NavigationService>(context, listen: false),
        Provider.of<ExerciseService>(context, listen: false),
        Provider.of<WorkoutRepository>(context, listen: false),
        Provider.of<ExerciseRepository>(context, listen: false),
        Provider.of<AuthenticationService>(context, listen: false),
      ),
      builder: (context, model, child) => Column(
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.info_sharp),
                      color: Colors.redAccent,
                      onPressed: () {
                        _showExerciseInstructions(widget.instructions);
                      },
                    ),
                    ExerciseContainer(
                      text: widget.name,
                    ),
                    IconButton(
                      icon: Icon(Icons.notes_sharp),
                      color: Colors.redAccent,
                      onPressed: () {

                        //Open Exercise info/instructions
                      },
                    ),
                  ],
                ),
                ExerciseContainer(
                  text: 'Sets by ${widget.reps} reps',
                ),
              ],
            ),
          ),
          Material(
            borderRadius: buildBorderRadiusBottom(),
            elevation: 5,
            color: Colors.red[300],
            child: Column(
              children: [
                model.dataReady
                    ? SetsButtons(workoutDuration: widget.workoutDuration)
                    : SizedBox(),
                //Change this to render a loading indicator instead of a blank sizedbox
              ],
            ),
          ),
        ],
      ),
    );
  }

  _showExerciseInstructions(String instructions) async {
    await showDialog<String>(
      context: context,
      builder: (_) => _InstructionsDialogBox(
        context: context,
        instructions: instructions,
      ),
    );
  }
}

class _InstructionsDialogBox extends StatelessWidget {
  final BuildContext context;
  final String instructions;

  _InstructionsDialogBox({this.context, this.instructions});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        children: [
          Text(
            instructions,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'OK',
            ),
          )
        ],
      ),
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
