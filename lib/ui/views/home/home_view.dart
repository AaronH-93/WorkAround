import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:uuid/uuid.dart';
import 'package:work_around/models/user_workout.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/constants.dart';
import 'package:work_around/services/repository/exercise_repository.dart';
import 'package:work_around/services/repository/user_repository.dart';
import 'package:work_around/services/repository/workout_repository.dart';
import 'package:work_around/ui/views/exercise/workout_view_model.dart';

import 'home_view_model.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(
        Provider.of<NavigationService>(context, listen: false),
        Provider.of<ExerciseService>(context, listen: false),
        Provider.of<AuthenticationService>(context, listen: false),
        Provider.of<UserRepository>(context, listen: false),
      ),
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
                          model.isBusy
                              ? 'Hello'
                              : 'Welcome, ${model.data.firstName}',
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
                      model.navigateToViewExercisesView();
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
                      //model.isBusy ? 'Hello' : 'Welcome, User',
                      model.isBusy
                          ? 'Hello'
                          : 'Welcome, ${model.data.firstName}',
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
                          //add Dialog option to name workout
                          _createWorkoutDialog();
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _createWorkoutDialog() async {
    await showDialog<String>(
      context: context,
      builder: (_) => _CreateWorkoutDialogBox(context: context),
    );
  }
}

class _CreateWorkoutDialogBox extends StatelessWidget {
  final BuildContext context;
  final controller = TextEditingController();

  _CreateWorkoutDialogBox({this.context});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WorkoutViewModel>.reactive(
        builder: (context, model, child) => AlertDialog(
              contentPadding: EdgeInsets.all(16.0),
              content: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: controller,
                      autofocus: true,
                      decoration: InputDecoration(
                          labelText: 'Enter Workout Name',
                          hintText: 'Workout 1'),
                    ),
                  )
                ],
              ),
              actions: <Widget>[
                _CreateWorkoutDialogButton(
                  text: 'Cancel',
                  onPressed: () {
                    model.pop();
                  },
                ),
                _CreateWorkoutDialogButton(
                  text: 'Confirm',
                  onPressed: () {
                    UserWorkout newWorkout =
                        UserWorkout(Uuid().v4(), controller.text);
                    model.setTempWorkoutId(newWorkout.workoutId);
                    model.addWorkoutToFirestore(newWorkout);
                    model.navigateToCreateWorkoutView(newWorkout);
                  },
                ),
              ],
            ),
        viewModelBuilder: () => WorkoutViewModel(
              Provider.of<NavigationService>(context, listen: false),
              Provider.of<ExerciseService>(context, listen: false),
              Provider.of<WorkoutRepository>(context, listen: false),
              Provider.of<AuthenticationService>(context, listen: false),
              Provider.of<ExerciseRepository>(context, listen: false),
            ));
  }
}

class _CreateWorkoutDialogButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  _CreateWorkoutDialogButton({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(text),
      onPressed: onPressed,
    );
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
    return ViewModelBuilder<WorkoutViewModel>.reactive(
      builder: (context, model, child) => ListView.builder(
        itemBuilder: (context, index) {
          return model.dataReady
              ? WorkoutTile(workout: model.workouts[index])
              : SizedBox();
        },
        itemCount: model.dataReady ? model.workouts.length : 1,
      ),
      viewModelBuilder: () => WorkoutViewModel(
        Provider.of<NavigationService>(context, listen: false),
        Provider.of<ExerciseService>(context, listen: false),
        Provider.of<WorkoutRepository>(context, listen: false),
        Provider.of<AuthenticationService>(context, listen: false),
        Provider.of<ExerciseRepository>(context, listen: false),
      ),
    );
  }
}

class WorkoutTile extends ViewModelWidget<WorkoutViewModel> {
  final UserWorkout workout;

  WorkoutTile({this.workout});

  @override
  Widget build(BuildContext context, WorkoutViewModel model) {
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
                workout: workout,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class WorkoutContainer extends StatefulWidget {
  final UserWorkout workout;

  WorkoutContainer({this.workout});

  @override
  _WorkoutContainerState createState() => _WorkoutContainerState();
}

class _WorkoutContainerState extends State<WorkoutContainer> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WorkoutViewModel>.nonReactive(
      builder: (context, model, child) => Container(
        padding: EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                model.deleteWorkout(widget.workout.workoutId);
              },
              child: Text('Delete'),
            ),
            TextButton(
              child: WorkoutTileText(text: widget.workout.name),
              onPressed: () {
                _startWorkoutDialog(widget.workout);
              },
              onLongPress: () {
                //TODO: add functionality to rename workout
              },
            ),
            TextButton(
              onPressed: () {
                //If workout is being sent in anyway, we don't need setWorkoutIdToEdit?
                model.setWorkoutIdToEdit(widget.workout.workoutId);
                model.navigateToEditWorkoutView(widget.workout);
              },
              child: Text('Edit'),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => WorkoutViewModel(
        Provider.of<NavigationService>(context, listen: false),
        Provider.of<ExerciseService>(context, listen: false),
        Provider.of<WorkoutRepository>(context, listen: false),
        Provider.of<AuthenticationService>(context, listen: false),
        Provider.of<ExerciseRepository>(context, listen: false),
      ),
    );
  }

  _startWorkoutDialog(UserWorkout workout) async {
    await showDialog<String>(
      context: context,
      builder: (_) =>
          _StartWorkoutDialogBox(context: context, workout: workout),
    );
  }
}

class WorkoutTileText extends StatelessWidget {
  final String text;

  WorkoutTileText({this.text});

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

class _StartWorkoutDialogBox extends StatelessWidget {
  final BuildContext context;
  final UserWorkout workout;
  final controller = TextEditingController();

  _StartWorkoutDialogBox({this.context, this.workout});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WorkoutViewModel>.reactive(
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
                _StartWorkoutDialogButton(
                  text: 'Cancel',
                  onPressed: () {
                    model.pop();
                  },
                ),
                _StartWorkoutDialogButton(
                  text: 'Confirm',
                  onPressed: () {
                    model.setWorkoutID(workout.workoutId);
                    model.startWorkoutTimer();
                    model.setInitialWorkoutDuration(
                        Duration(minutes: int.parse(controller.text)));
                    model.navigateToWorkoutView(
                        Duration(minutes: int.parse(controller.text)),
                        workout.workoutId);
                  },
                ),
              ],
            ),
        viewModelBuilder: () => WorkoutViewModel(
              Provider.of<NavigationService>(context, listen: false),
              Provider.of<ExerciseService>(context, listen: false),
              Provider.of<WorkoutRepository>(context, listen: false),
              Provider.of<AuthenticationService>(context, listen: false),
              Provider.of<ExerciseRepository>(context, listen: false),
            ));
  }
}

class _StartWorkoutDialogButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  _StartWorkoutDialogButton({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(text),
      onPressed: onPressed,
    );
  }
}

BorderRadius buildBorderRadius() => BorderRadius.only(
    topRight: Radius.circular(10.0),
    topLeft: Radius.circular(10.0),
    bottomLeft: Radius.circular(10.0),
    bottomRight: Radius.circular(10.0));
