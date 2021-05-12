import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:work_around/components/rounded_button.dart';
import 'package:work_around/models/user_workout.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/services/repository/exercise_repository.dart';
import 'exercises_view_model.dart';

final TextEditingController controller = TextEditingController();

class ExerciseView extends StatefulWidget {
  final UserWorkout workout;
  ExerciseView({this.workout});
  
  @override
  _ExerciseViewState createState() => _ExerciseViewState();
}

class _ExerciseViewState extends State<ExerciseView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExerciseViewModel>.reactive(
      onModelReady: (model){
        model.initList();
      },
        key: Key('exercisesView'),
        builder: (context, model, child) => Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    _SearchField(),
                    _MuscleGroupButtonList(),
                    _EquipmentButtonList(),
                    Container(
                      child: ExercisesList(workout: widget.workout),
                    ),
                    RoundedButton(
                      title: 'Back',
                      color: Colors.redAccent,
                      onPressed: (){
                        model.pop();
                      },),
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => ExerciseViewModel(
              Provider.of<NavigationService>(context, listen: false),
              Provider.of<ExerciseService>(context, listen: false),
              Provider.of<AuthenticationService>(context, listen: false),
              Provider.of<ExerciseRepository>(context, listen: false),
            ));
  }
}

class ExercisesList extends ViewModelWidget<ExerciseViewModel> {
  final UserWorkout workout;
  ExercisesList({this.workout});

  @override
  Widget build(BuildContext context, ExerciseViewModel model) {
    return Expanded(
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[300],
        child: ListView.builder(
            itemBuilder: (context, index) {
              final exercise = model.searchList[index];
              return TextButton(
                  onPressed: () {
                    model.navigateToAddExerciseView(workout, exercise);
                  },
                  child: ExerciseTile(name: exercise.name));
            },
            itemCount: model.searchList.length,
          ),
      ),
    );
  }
}

class ExerciseTile extends StatelessWidget {
  final String name;

  ExerciseTile({this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        //Material widgets is repeat code
        Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.redAccent,
          child: Column(
            children: [
              ExerciseContainer(
                text: name,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ExerciseContainer extends StatelessWidget {
  final String text;

  ExerciseContainer({this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key(text),
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
        color: Colors.white,
      ),
    );
  }
}

class _EquipmentButtonList extends ViewModelWidget<ExerciseViewModel> {
  const _EquipmentButtonList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ExerciseViewModel model) {
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

class _MuscleGroupButtonList extends ViewModelWidget<ExerciseViewModel> {
  const _MuscleGroupButtonList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ExerciseViewModel model) {
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

class _FilterButton extends ViewModelWidget<ExerciseViewModel> {
  final String text;

  _FilterButton(this.text);

  @override
  Widget build(BuildContext context, ExerciseViewModel model) {
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

class _SearchField extends ViewModelWidget<ExerciseViewModel> {
  const _SearchField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ExerciseViewModel model) {
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

BorderRadius buildBorderRadiusTop() => BorderRadius.only(
    topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0));

BorderRadius buildBorderRadiusBottom() => BorderRadius.only(
    bottomLeft: Radius.circular(10.0), bottomRight: Radius.circular(10.0));
