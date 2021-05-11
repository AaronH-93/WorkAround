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
import 'package:work_around/ui/views/exercise/edit_exercise_view_model.dart';

class EditExerciseView extends StatefulWidget {
  final UserExercise exercise;
  final UserWorkout workout;

  const EditExerciseView({this.workout, this.exercise});


  @override
  _EditExerciseViewState createState() => _EditExerciseViewState();
}

class _EditExerciseViewState extends State<EditExerciseView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditExerciseViewModel>.reactive(
      key: Key('editExerciseView'),
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
                  _CompleteButton(widget.exercise, widget.workout),
                ],
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => EditExerciseViewModel(
        Provider.of<AuthenticationService>(context, listen: false),
        Provider.of<NavigationService>(context, listen: false),
        Provider.of<ExerciseService>(context, listen: false),
        Provider.of<ExerciseRepository>(context, listen: false),
      ),
    );
  }
}

//This fields are recycled code from AddExerciseView, maybe extract them to their own file and add
//onPressed parameter sometime?

class _CompleteButton extends ViewModelWidget<EditExerciseViewModel> {
  final UserExercise exercise;
  final UserWorkout workout;

  _CompleteButton(this.exercise, this.workout);

  @override
  Widget build(BuildContext context, EditExerciseViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: RoundedButton(
        widgetKey: Key('completeEditButton'),
        color: Colors.redAccent,
        title: 'Done',
        onPressed: (){
          model.updateExercise(exercise);
          model.navigateToEditWorkoutView(workout);
        },
      ),
    );
  }
}

class _WeightField extends ViewModelWidget<EditExerciseViewModel> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context, EditExerciseViewModel model) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          key: Key('editWeightField'),
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

class _RepsField extends ViewModelWidget<EditExerciseViewModel> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context, EditExerciseViewModel model) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          key: Key('editRepsField'),
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

class _SetsField extends ViewModelWidget<EditExerciseViewModel> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context, EditExerciseViewModel model) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          key: Key('editSetsField'),
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
