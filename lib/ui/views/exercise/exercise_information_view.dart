import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:work_around/models/exercise.dart';

class ExerciseInformationView extends StatelessWidget {
  final Exercise exercise;
  ExerciseInformationView({this.exercise});

  //This page will display all the information for an exercise, check musclewiki for ideas
  //Include how-to instructions, gif/videos from musclewiki?, description of exercise
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(exercise.name),
            ),
          ],
        ),
      ),
    );
  }
}
