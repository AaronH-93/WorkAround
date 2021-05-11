import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:work_around/components/rounded_button.dart';
import 'package:work_around/models/exercise.dart';
import 'package:work_around/models/user_exercise.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/ui/views/exercise/view_exercises_view_model.dart';

class ViewExercisesView extends StatefulWidget {
  @override
  _ViewExercisesViewState createState() => _ViewExercisesViewState();
}

class _ViewExercisesViewState extends State<ViewExercisesView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ViewExercisesViewModel>.reactive(
      key: Key('viewExercisesView'),
      viewModelBuilder: () => ViewExercisesViewModel(
        Provider.of<NavigationService>(context, listen: false),
        Provider.of<ExerciseService>(context, listen: false),
      ),
      builder: (context, model, child) => Scaffold(
          body: Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Material(
          child: ExerciseViewList(),
        ),
      )),
    );
  }
}

class ExerciseViewList extends StatefulWidget {
  @override
  _ExerciseViewListState createState() => _ExerciseViewListState();
}

class _ExerciseViewListState extends State<ExerciseViewList> {
  TextEditingController controller = TextEditingController();
  List<UserExercise> searchableList = [];
  List<UserExercise> filteredList = [];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ViewExercisesViewModel>.reactive(
      viewModelBuilder: () => ViewExercisesViewModel(
        Provider.of<NavigationService>(context, listen: false),
        Provider.of<ExerciseService>(context, listen: false),
      ),
      onModelReady: (model) {
        model.initList();
        searchableList = model.searchableList;
        filteredList = searchableList;
      },
      builder: (context, model, child) => SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            TextField(
              key: Key('searchField'),
              controller: controller,
              decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search Exercises",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              onChanged: (value) {
                setState(() {
                  filteredList = searchableList
                      .where((exercise) => (exercise.name
                              .toLowerCase()
                              .contains(value.toLowerCase()) ||
                          exercise.muscleGroup
                              .toLowerCase()
                              .contains(value.toLowerCase())))
                      .toList();
                });
              },
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final exercise = filteredList[index];
                  return ViewExerciseButton(exercise: exercise);
                },
                itemCount: filteredList.length,
              ),
            ),
            RoundedButton(
              widgetKey: Key('backButton'),
              title: 'Back',
              color: Colors.redAccent,
              onPressed: (){
              Navigator.pop(context);
            },),
          ],
        ),
      ),
    );
  }
}

class ViewExerciseButton extends StatefulWidget {
  final UserExercise exercise;

  ViewExerciseButton({this.exercise});

  @override
  _ViewExerciseButtonState createState() => _ViewExerciseButtonState();
}

class _ViewExerciseButtonState extends State<ViewExerciseButton> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ViewExercisesViewModel>.nonReactive(
      viewModelBuilder: () => ViewExercisesViewModel(
        Provider.of<NavigationService>(context, listen: false),
        Provider.of<ExerciseService>(context, listen: false),
      ),
      builder: (context, model, child) => Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Material(
          elevation: 5.0,
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(30.0),
          child: MaterialButton(
            key: Key('${widget.exercise.name}_viewButton'),
            onPressed: () {
              model.navigateToExerciseInformationView(widget.exercise);
            },
            minWidth: 200.0,
            height: 42.0,
            child: Text(
              widget.exercise.name,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
