import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:work_around/components/rounded_button.dart';
import 'package:work_around/models/user_exercise.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/ui/views/exercise/view_exercises_view_model.dart';

final TextEditingController controller = TextEditingController();

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
        ),
      ),
    );
  }
}

class ExerciseViewList extends StatefulWidget {
  @override
  _ExerciseViewListState createState() => _ExerciseViewListState();
}

class _ExerciseViewListState extends State<ExerciseViewList> {
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
      },
      builder: (context, model, child) => SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            _SearchField(),
            _MuscleGroupButtonList(),
            _EquipmentButtonList(),
            _ExerciseButtons(),
            RoundedButton(
              widgetKey: Key('backButton'),
              title: 'Back',
              color: Colors.redAccent,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _EquipmentButtonList extends ViewModelWidget<ViewExercisesViewModel> {
  const _EquipmentButtonList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ViewExercisesViewModel model) {
    return Container(
      height: 70,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _FilterButton('stretch'),
          _FilterButton('bodyweight'),
          _FilterButton('barbell'),
          _FilterButton('kettlebell'),
          _FilterButton('dumbbell'),
        ],
      ),
    );
  }
}

class _MuscleGroupButtonList extends ViewModelWidget<ViewExercisesViewModel> {
  const _MuscleGroupButtonList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ViewExercisesViewModel model) {
    return Container(
      height: 70,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _FilterButton('biceps'),
          _FilterButton('chest'),
          _FilterButton('abdominals'),
          _FilterButton('shoulders'),
          _FilterButton('traps'),
          _FilterButton('forearms'),
          _FilterButton('quads'),
          _FilterButton('triceps'),
          _FilterButton('lats'),
          _FilterButton('lower back'),
          _FilterButton('glutes'),
          _FilterButton('hamstring'),
          _FilterButton('calves'),
        ],
      ),
    );
  }
}

class _FilterButton extends ViewModelWidget<ViewExercisesViewModel> {
  final String text;

  _FilterButton(this.text);

  @override
  Widget build(BuildContext context, ViewExercisesViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      child: RoundedButton(
          title: text.toUpperCase(),
          color: Colors.redAccent,
          onPressed: () {
            model.filterSearchResults(text);
          }),
    );
  }
}

class _ExerciseButtons extends ViewModelWidget<ViewExercisesViewModel> {
  const _ExerciseButtons({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ViewExercisesViewModel model) {
    return Expanded(
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[300],
        child: ListView.builder(
          itemBuilder: (context, index) {
            final exercise = model.searchList[index];
            return ViewExerciseButton(exercise: exercise);
          },
          itemCount: model.searchList.length,
        ),
      ),
    );
  }
}

class _SearchField extends ViewModelWidget<ViewExercisesViewModel> {
  const _SearchField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ViewExercisesViewModel model) {
    return TextField(
      key: Key('searchField'),
      controller: controller,
      decoration: InputDecoration(
          labelText: "Search",
          hintText: "Search Exercises",
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(25.0)))),
      onChanged: (value) {
        model.filterSearchResults(value);
      },
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
