import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:work_around/components/rounded_button.dart';
import 'package:work_around/models/user_exercise.dart';
import 'package:work_around/models/user_workout.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/services/repository/exercise_repository.dart';
import 'package:work_around/ui/views/exercise/add_exercise_view_model.dart';

class AddExerciseView extends StatefulWidget {
  final UserWorkout workout;
  final UserExercise exercise;
  AddExerciseView(this.workout, this.exercise);

  @override
  _AddExerciseViewState createState() => _AddExerciseViewState();
}

class _AddExerciseViewState extends State<AddExerciseView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      key: Key('addExerciseView'),
      builder: (context, model, child) => Scaffold(
        body: Form(
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  _SetsField(),
                  SizedBox(
                    height: 20,
                  ),
                  _RepsField(),
                  SizedBox(
                    height: 20,
                  ),
                  _WeightField(),
                  SizedBox(
                    height: 20,
                  ),
                  _CompleteButton(widget.workout, widget.exercise),
                  RoundedButton(
                    title: 'Back',
                    color: Colors.redAccent,
                    onPressed: () {
                      model.pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => AddExerciseViewModel(
        Provider.of<NavigationService>(context, listen: false),
        Provider.of<AuthenticationService>(context, listen: false),
        Provider.of<ExerciseService>(context, listen: false),
        Provider.of<ExerciseRepository>(context, listen: false),
      ),
    );
  }
}

class _CompleteButton extends ViewModelWidget<AddExerciseViewModel> {
  final UserWorkout workout;
  final UserExercise exercise;

  _CompleteButton(this.workout, this.exercise);

  @override
  Widget build(BuildContext context, AddExerciseViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: RoundedButton(
        widgetKey: Key('submitExerciseButton'),
        color: Colors.redAccent,
        title: 'Done',
        onPressed: (){
          model.generateExercise(workout, exercise);
          model.editPath
              ? model.navigateToEditWorkoutView(workout)
              : model.navigateToCreateWorkoutView(workout);
        },
      ),
    );
  }
}

class _WeightField extends ViewModelWidget<AddExerciseViewModel> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context, AddExerciseViewModel model) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          key: Key('weightField'),
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Weight in KG (Optional)',
          ),
          onChanged: (value) {
            model.weight = int.parse(value);
          },
        ));
  }
}

class _RepsField extends ViewModelWidget<AddExerciseViewModel> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context, AddExerciseViewModel model) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          key: Key('repsField'),
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Reps',
          ),
          onChanged: (value) {
            model.reps = int.parse(value);
          },
        ));
  }
}

class _SetsField extends ViewModelWidget<AddExerciseViewModel> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context, AddExerciseViewModel model) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          key: Key('setsField'),
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Sets',
          ),
          onChanged: (value) {
            model.sets = int.parse(value);
          },
        ));
  }
}
