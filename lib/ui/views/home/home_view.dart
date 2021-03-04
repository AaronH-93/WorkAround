import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:work_around/models/workout.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/constants.dart';

import 'home_view_model.dart';

final controller = TextEditingController();

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              body: Scaffold(
                drawer: Container(
                  width: 250,
                  child: Drawer(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        DrawerHeader(
                          child: Row(
                            children: [
                              Text(
                                'User :)',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                          ),
                        ),
                        _DrawerTile(
                          text: 'Account',
                          onPressed: () {
                            model.pop();
                          },
                        ),
                        _DrawerTile(
                          text: 'Exercises',
                          onPressed: () {
                            model.navigateToExercisesView();
                          },
                        ),
                        _DrawerTile(
                          text: 'Settings',
                          onPressed: () {
                            model.navigateToSettingsView();
                          },
                        ),
                        _DrawerTile(
                          text: 'Help',
                          onPressed: () {
                            model.pop();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                appBar: AppBar(
                  title: Text(
                    'WorkAround',
                  ),
                  backgroundColor: Colors.redAccent,
                ),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Center(
                          child: Text(
                            'Welcome, User!',
                            style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 140,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 50, right: 50),
                        child: Material(
                          elevation: 5,
                          borderRadius: buildBorderRadiusTop(),
                          color: Colors.redAccent,
                          child: Center(
                            child: TextButton(
                              onPressed: () {
                                model.navigateToCreateWorkoutView();
                              },
                              child: Text(
                                'CREATE WORKOUT',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Material(
                            borderRadius: buildBorderRadiusTop(),
                            color: Colors.grey[300],
                            child: WorkoutList(),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
        viewModelBuilder: () => HomeViewModel(
              Provider.of<NavigationService>(context, listen: false),
              Provider.of<ExerciseService>(context, listen: false),
            ));
  }
}

class _DrawerTile extends StatelessWidget {
  final String text;
  final Function onPressed;

  _DrawerTile({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(text),
      onTap: onPressed,
    );
  }
}

class WorkoutList extends StatefulWidget {
  @override
  _WorkoutListState createState() => _WorkoutListState();
}

class _WorkoutListState extends State<WorkoutList> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => ListView.builder(
        itemBuilder: (context, index) {
          final workout = model.getWorkout(index);
          return WorkoutTile(workout: workout);
        },
        itemCount: model.getNumOfWorkouts(),
      ),
      viewModelBuilder: () => HomeViewModel(
        Provider.of<NavigationService>(context, listen: false),
        Provider.of<ExerciseService>(context, listen: false),
      ),
    );
  }
}

class WorkoutTile extends StatefulWidget {
  final Workout workout;

  WorkoutTile({this.workout});

  @override
  _WorkoutTileState createState() => _WorkoutTileState();
}

class _WorkoutTileState extends State<WorkoutTile> {
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
          borderRadius: buildBorderRadius(),
          color: Colors.white,
          child: Column(
            children: [
              WorkoutContainer(
                workout: widget.workout,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class WorkoutContainer extends StatefulWidget {
  final Workout workout;

  WorkoutContainer({this.workout});

  @override
  _WorkoutContainerState createState() => _WorkoutContainerState();
}

class _WorkoutContainerState extends State<WorkoutContainer> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.nonReactive(
      builder: (context, model, child) => Container(
        padding: EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              child: TileText(text: widget.workout.name),
              onPressed: () {
                print('clicked');
                _showDialog(widget.workout);
              },
              onLongPress: () {
                //Edit, Delete
              },
            ),
          ],
        ),
      ),
      viewModelBuilder: () => HomeViewModel(
        Provider.of<NavigationService>(context, listen: false),
        Provider.of<ExerciseService>(context, listen: false),
      ),
    );
  }
  _showDialog(Workout workout) async {
    await showDialog<String>(
      context: context,
      builder: (_) => _AlertDialogBox(context: context, workout: workout),
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

class _AlertDialogBox extends StatelessWidget {
  final BuildContext context;
  final Workout workout;

  _AlertDialogBox({this.context, this.workout});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        builder: (context, model, child) => AlertDialog(
          contentPadding: EdgeInsets.all(16.0),
          content: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: controller,
                  autofocus: true,
                  decoration: InputDecoration(
                      labelText: 'Enter Workout Duration',
                      hintText: 'eg. 25 minutes'),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              )
            ],
          ),
          actions: <Widget>[
            _AlertDialogButton(
              text: 'Cancel',
              onPressed: () {
                model.pop();
              },
            ),
            _AlertDialogButton(
              text: 'Confirm',
              onPressed: () {
                model.navigateToWorkoutView(int.parse(controller.text), workout);
              },
            ),
          ],
        ),
        viewModelBuilder: () => HomeViewModel(
          Provider.of<NavigationService>(context, listen: false),
          Provider.of<ExerciseService>(context, listen: false),
        ));
  }
}

class _AlertDialogButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  _AlertDialogButton({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(text),
      onPressed: onPressed,
    );
  }
}

BorderRadius buildBorderRadius() => BorderRadius.only(
    topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0), bottomRight: Radius.circular(10.0));
