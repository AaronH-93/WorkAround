import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/services/repository/exercise_repository.dart';
import 'package:work_around/ui/views/exercise/exercises_view_model.dart';
import 'exercise_tile.dart';

class ExerciseList extends StatefulWidget {
  final Duration workoutDuration;
  final String workoutId;

  ExerciseList({this.workoutDuration, this.workoutId});

  @override
  _ExerciseListState createState() => _ExerciseListState();
}

class _ExerciseListState extends State<ExerciseList> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExerciseViewModel>.reactive(
      onModelReady: (model) {
        model.setWorkoutId(widget.workoutId);
        //model.generateSets(widget.workoutDuration, model.exercises);
      },
      builder: (context, model, child) => ListView.builder(
        itemBuilder: (context, index) {
          return model.dataReady
              ? ExerciseTile(
                  name: model.exercises[index].name,
                  exerciseId: model.exercises[index].exerciseId,
                  reps: model.exercises[index].reps,
                  workoutDuration: widget.workoutDuration,
                )
              : Container(
                  child: Text('Loading Exercise...'),
                );
        },
        itemCount: model.dataReady ? model.exercises.length : 1,
      ),
      viewModelBuilder: () => ExerciseViewModel(
        Provider.of<NavigationService>(context, listen: false),
        Provider.of<ExerciseService>(context, listen: false),
        Provider.of<AuthenticationService>(context, listen: false),
        Provider.of<ExerciseRepository>(context, listen: false),
      ),
    );
  }
}
