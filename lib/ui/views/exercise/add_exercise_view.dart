import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:work_around/components/rounded_button.dart';
import 'package:work_around/models/exercise.dart';
import 'package:work_around/models/user_workout.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/services/repository/exercise_repository.dart';
import 'package:work_around/services/repository/workout_repository.dart';
import 'package:work_around/ui/views/exercise/add_exercise_view_model.dart';

class AddExerciseView extends StatefulWidget {
  final UserWorkout newWorkout;
  final Exercise exercise;
  AddExerciseView(this.newWorkout, this.exercise);

  @override
  _AddExerciseViewState createState() => _AddExerciseViewState();
}

class _AddExerciseViewState extends State<AddExerciseView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
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
                  _CompleteButton(widget.newWorkout, widget.exercise),
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
        Provider.of<WorkoutRepository>(context, listen: false),
        Provider.of<ExerciseRepository>(context, listen: false),
      ),
    );
  }
}

class _CompleteButton extends ViewModelWidget<AddExerciseViewModel> {
  final UserWorkout newWorkout;
  final Exercise exercise;

  _CompleteButton(this.newWorkout, this.exercise);

  @override
  Widget build(BuildContext context, AddExerciseViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: RoundedButton(
        color: Colors.redAccent,
        title: 'Done',
        onPressed: (){
          model.generateExercise(newWorkout, exercise);
          model.navigateToCreateWorkoutView(newWorkout);
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
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Weight (Optional)',
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
