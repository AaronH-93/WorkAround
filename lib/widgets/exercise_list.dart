import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/services/repository/exercise_repository.dart';
import 'package:work_around/widgets/exercise_list_view_model.dart';
import 'exercise_tile.dart';

class ExerciseList extends StatefulWidget {
  @override
  _ExerciseListState createState() => _ExerciseListState();
}

class _ExerciseListState extends State<ExerciseList> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExerciseListViewModel>.reactive(
      builder: (context, model, child) => ListView.builder(
        itemBuilder: (context, index) {
          model.dataReady ? model.addToExercisesHistory(model.exercises[index]) : (){};
          return model.dataReady ? ExerciseTile(exercise: model.exercises[index]) : Container(child: Text('Loading Exercise...'));
        },
        itemCount: model.dataReady ? model.exercises.length : 1,
      ),
      viewModelBuilder: () => ExerciseListViewModel(
        Provider.of<NavigationService>(context, listen: false),
        Provider.of<ExerciseService>(context, listen: false),
        Provider.of<AuthenticationService>(context, listen: false),
        Provider.of<ExerciseRepository>(context, listen: false),
      ),
    );
  }
}
