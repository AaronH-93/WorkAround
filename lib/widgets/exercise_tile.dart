import 'package:flutter/material.dart';
import 'sets_buttons.dart';

class ExerciseTile extends StatelessWidget {
  final String name;
  final int effort;
  final int reps;
  final int workoutDuration;
  final int sets;

  ExerciseTile(
      {this.name, this.sets, this.reps, this.effort, this.workoutDuration});

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
              ExerciseContainer(
                text: 'Sets by $reps reps',
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
              SetsButtons(sets: sets),
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
