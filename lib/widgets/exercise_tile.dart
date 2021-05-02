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

  ExerciseTile({this.exerciseId, this.name, this.reps, this.workoutDuration});

  @override
  _ExerciseTileState createState() => _ExerciseTileState();
}

class _ExerciseTileState extends State<ExerciseTile> {
  @override
  void initState() {
    super.initState();
    Provider.of<ExerciseService>(context, listen: false).exerciseId = widget.exerciseId;
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
              children: [
                ExerciseContainer(
                  text: widget.name,
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
                SetsButtons(workoutDuration: widget.workoutDuration)
                //Instead of using usersets, maybe just turn the usersets into Exercise sets?
                //Alternatively, exercises can have a field called sets that's just a number, and we generate the sets from this number and do it the old way
                //TO GET GENERATE SETS TO WORK, TRY SENDING IN THE EXERCISE ID AND CALL USERSETS FROM IN THE SETSBUTTONS OR MAKE A NEW SET OR SOMETHING, THINK ABOUT IT
              ],
            ),
          ),
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
