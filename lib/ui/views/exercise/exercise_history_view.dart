import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:work_around/components/rounded_button.dart';
import 'package:work_around/models/user_exercise.dart';
import 'package:work_around/models/user_set.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/services/repository/history_repository.dart';
import 'package:work_around/ui/views/exercise/sets_history_view_model.dart';

import 'exercise_history_view_model.dart';

class ExerciseHistoryView extends StatefulWidget {
  @override
  _ExerciseHistoryViewState createState() => _ExerciseHistoryViewState();
}

class _ExerciseHistoryViewState extends State<ExerciseHistoryView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExerciseHistoryViewModel>.reactive(
      key: Key('exerciseHistoryView'),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.grey,
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return model.dataReady
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ExerciseHistoryContainer(model.exercises[index]),
                        )
                      : SizedBox();
                },
                itemCount: model.dataReady ? model.exercises.length : 1,
              ),
            ),
            RoundedButton(
              widgetKey: Key('exerciseHistoryBackButton'),
              title: 'Back',
              color: Colors.redAccent,
              onPressed: () {
                model.pop();
              },
            )
          ],
        ),
      ),
      viewModelBuilder: () => ExerciseHistoryViewModel(
        Provider.of<NavigationService>(context, listen: false),
        Provider.of<AuthenticationService>(context, listen: false),
        Provider.of<ExerciseService>(context, listen: false),
        Provider.of<HistoryRepository>(context, listen: false),
      ),
    );
  }
}

class ExerciseHistoryContainer extends ViewModelWidget<ExerciseHistoryViewModel> {
  final UserExercise exercise;
  ExerciseHistoryContainer(this.exercise);

  @override
  Widget build(BuildContext context, ExerciseHistoryViewModel model) {
    model.setExerciseHistoryId(exercise.exerciseId);
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ExerciseContainer(
                text: exercise.name,
              ),
              ExerciseContainer(
                text: 'Sets by ${exercise.reps} reps',
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
              model.dataReady ? SetsButtons(exercise.exerciseId) : SizedBox(),
            ],
          ),
        ),
      ],
    );
  }
}

class SetsButtons extends StatefulWidget {
  final String exerciseId;
  SetsButtons(this.exerciseId);

  @override
  _SetsButtonsState createState() => _SetsButtonsState();
}

class _SetsButtonsState extends State<SetsButtons> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SetsHistoryViewModel>.reactive(
      builder: (context, model, child) => model.dataReady
          ? buildRowOfButtons(model)
          : SizedBox(),
      viewModelBuilder: () => SetsHistoryViewModel(
        Provider.of<NavigationService>(context, listen: false),
        Provider.of<AuthenticationService>(context, listen: false),
        Provider.of<ExerciseService>(context, listen: false),
        Provider.of<HistoryRepository>(context, listen: false),
      ),
    );
  }

  Widget buildRowOfButtons(SetsHistoryViewModel model) {
    Color defaultColor = Colors.grey[400];
    List<Widget> list = [];
    List<UserSet> setList = model.sets;
    for (UserSet set in setList) {
      list.add(
        MaterialButton(
          color: set.isCompleted ? Colors.green : defaultColor,
          shape: CircleBorder(),
          onPressed: (){},
        ),
      );
    }
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: list,
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
