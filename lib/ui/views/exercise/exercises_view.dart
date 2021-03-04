import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'exercises_view_model.dart';

class ExerciseView extends StatefulWidget {
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
                    Container(
                      child: ExercisesList(),
                    ),
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => ExerciseViewModel(
              Provider.of<NavigationService>(context, listen: false),
              Provider.of<ExerciseService>(context, listen: false),
            ));
  }
}

class ExercisesList extends StatefulWidget {
  @override
  _ExerciseListState createState() => _ExerciseListState();
}

class _ExerciseListState extends State<ExercisesList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ViewModelBuilder<ExerciseViewModel>.reactive(
        builder: (context, model, child) => ListView.builder(
          itemBuilder: (context, index) {
            final exercise = model.getExercise(index);
            return TextButton(
                onPressed: (){
                  print("clicked");
                  model.addToTempWorkout(exercise);
                  model.navigateToCreateWorkoutView();
                  },
                child: ExerciseTile(name: exercise.name));
          },
          itemCount: model.getNumOfExercises(),
        ),
        viewModelBuilder: () => ExerciseViewModel(
          Provider.of<NavigationService>(context, listen: false),
          Provider.of<ExerciseService>(context, listen: false),
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
