import 'dart:core';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import 'package:stacked/stacked.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/services/repository/workout_repository.dart';
import 'package:work_around/ui/views/exercise/workout_view_model.dart';

class RestTimer extends StatefulWidget {
  final BuildContext context;

  RestTimer({this.context});

  @override
  _RestTimerState createState() => _RestTimerState();
}

class _RestTimerState extends State<RestTimer> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WorkoutViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AlertDialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              content: Center(
                child: Text(
                  model.startTimer().toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => WorkoutViewModel(
        Provider.of<NavigationService>(context, listen: false),
        Provider.of<ExerciseService>(context, listen: false),
        Provider.of<WorkoutRepository>(context, listen: false),
        Provider.of<AuthenticationService>(context, listen: false),
      ),
    );
  }
}
