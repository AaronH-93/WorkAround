import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:uuid/uuid.dart';
import 'package:work_around/components/rounded_button.dart';
import 'package:work_around/models/user_workout.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/exercise_service.dart';
import 'package:work_around/services/navigation_service.dart';
import 'package:work_around/constants.dart';
import 'package:work_around/services/repository/exercise_repository.dart';
import 'package:work_around/services/repository/history_repository.dart';
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
      key: Key('homeView'),
      builder: (context, model, child) => Scaffold(
        body: Scaffold(
          drawer: _HomeDrawer(),
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
                _GreetingContainer(),
                Center(
                  child: RoundedButton(
                    widgetKey: Key('historyButton'),
                    title: 'Workout History',
                    color: Colors.redAccent,
                    onPressed: () {
                      model.navigateToWorkoutHistoryView();
                    },
                  ),
                ),
                Center(
                  child: RoundedButton(
                    widgetKey: Key('exercisesButton'),
                    title: 'Exercise Catalogue',
                    color: Colors.redAccent,
                    onPressed: () {
                      model.navigateToViewExercisesView();
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 50, right: 50),
                  child: Material(
                    elevation: 5,
                    borderRadius: buildBorderRadiusTop(),
                    color: Colors.redAccent,
                    child: Center(
                      child: TextButton(
                        key: Key('createWorkoutButton'),
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

class _GreetingContainer extends ViewModelWidget<HomeViewModel> {
  const _GreetingContainer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Center(
        child: model.isBusy
            ? Text(
            'Hello',
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.redAccent,
                ))
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome, ${model.data.firstName}',
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.redAccent,
                    ),
                  ),
                  TextButton(
                    key: Key('signOut'),
                    onPressed: () {
                      model.signOut();
                      model.navigateToWelcomeView();
                    },
                    child: Text('Sign Out'),
                  )
                ],
              ),
      ),
    );
  }
}

class _HomeDrawer extends ViewModelWidget<HomeViewModel> {
  const _HomeDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return Container(
      width: 250,
      child: Drawer(
        key: Key('homeViewDrawer'),
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
              text: 'History',
              onPressed: () {
                model.navigateToWorkoutHistoryView();
              },
            ),
            _DrawerTile(
              text: 'Exercises',
              onPressed: () {
                model.navigateToViewExercisesView();
              },
            ),
            _DrawerTile(
              widgetKey: Key('helpButton'),
              text: 'About',
              onPressed: () {
                model.navigateToAboutView();
              },
            ),
          ],
        ),
      ),
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
                key: Key('createWorkoutDialogBox'),
                controller: controller,
                autofocus: true,
                decoration: InputDecoration(
                    labelText: 'Enter Workout Name', hintText: 'Workout 1'),
              ),
            )
          ],
        ),
        actions: <Widget>[
          _CreateWorkoutDialogButton(
            widgetKey: Key('cancelCreateWorkoutButton'),
            text: 'Cancel',
            onPressed: () {
              model.pop();
            },
          ),
          _CreateWorkoutDialogButton(
            widgetKey: Key('confirmCreateWorkoutButton'),
            text: 'Confirm',
            onPressed: () {
              UserWorkout newWorkout =
                  UserWorkout(Uuid().v4(), controller.text);
              model.setTempWorkoutId(newWorkout.workoutId);
              model.addOrUpdateWorkout(newWorkout);
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
        Provider.of<HistoryRepository>(context, listen: false),
      ),
    );
  }
}

class _CreateWorkoutDialogButton extends StatelessWidget {
  final Key widgetKey;
  final String text;
  final Function onPressed;

  _CreateWorkoutDialogButton({this.text, this.onPressed, this.widgetKey});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: widgetKey,
      child: Text(text),
      onPressed: onPressed,
    );
  }
}

class _RenameWorkoutDialogButton extends StatelessWidget {
  final Key widgetKey;
  final String text;
  final Function onPressed;

  _RenameWorkoutDialogButton({this.text, this.onPressed, this.widgetKey});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: widgetKey,
      child: Text(text),
      onPressed: onPressed,
    );
  }
}

class _DrawerTile extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Key widgetKey;

  _DrawerTile({this.text, this.onPressed, this.widgetKey});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: widgetKey,
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
      key: Key('workoutList'),
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
        Provider.of<HistoryRepository>(context, listen: false),
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
      key: Key('workoutContainer'),
      builder: (context, model, child) => Container(
        padding: EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              key: Key('${widget.workout.name}_startWorkoutButton'),
              child: WorkoutTileText(text: widget.workout.name),
              onPressed: () {
                _startWorkoutDialog(widget.workout);
              },
              onLongPress: () {
                _renameWorkoutDialog(widget.workout);
              },
            ),
            TextButton(
              key: Key('${widget.workout.name}_editWorkoutButton'),
              onPressed: () {
                //If workout is being sent in anyway, we don't need setWorkoutIdToEdit?
                model.setWorkoutIdToEdit(widget.workout.workoutId);
                model.navigateToEditWorkoutView(widget.workout);
              },
              child: Text('Edit'),
            ),
            TextButton(
              key: Key('${widget.workout.name}_deleteWorkoutButton'),
              onPressed: () {
                model.deleteWorkout(widget.workout.workoutId);
              },
              child: Text('Delete'),
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
        Provider.of<HistoryRepository>(context, listen: false),
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

  _renameWorkoutDialog(UserWorkout workout) async {
    await showDialog<String>(
      context: context,
      builder: (_) =>
          _RenameWorkoutDialogBox(context: context, workout: workout),
    );
  }
}

class _RenameWorkoutDialogBox extends StatelessWidget {
  final BuildContext context;
  final UserWorkout workout;
  final controller = TextEditingController();

  _RenameWorkoutDialogBox({this.context, this.workout});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WorkoutViewModel>.reactive(
      builder: (context, model, child) => AlertDialog(
        contentPadding: EdgeInsets.all(16.0),
        content: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                key: Key('renameWorkoutDialogBox'),
                controller: controller,
                autofocus: true,
                decoration: InputDecoration(
                    labelText: 'Enter new workout name', hintText: '${workout.name}'),
              ),
            )
          ],
        ),
        actions: <Widget>[
          _RenameWorkoutDialogButton(
            widgetKey: Key('cancelRenameWorkoutButton'),
            text: 'Cancel',
            onPressed: () {
              model.pop();
            },
          ),
          _RenameWorkoutDialogButton(
            widgetKey: Key('confirmRenameWorkoutButton'),
            text: 'Confirm',
            onPressed: () {
              workout.name = controller.text;
              model.addOrUpdateWorkout(workout);
              model.pop();
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
        Provider.of<HistoryRepository>(context, listen: false),
      ),
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
        color: Colors.redAccent,
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
                key: Key('workoutDurationField'),
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
            widgetKey: Key('cancelWorkoutButton'),
            text: 'Cancel',
            onPressed: () {
              model.pop();
            },
          ),
          _StartWorkoutDialogButton(
            widgetKey: Key('beginWorkoutButton'),
            text: 'Confirm',
            onPressed: () {
              model.setWorkoutID(workout.workoutId);
              model.startWorkoutTimer();
              model.setInitialWorkoutDuration(Duration(minutes: int.parse(controller.text)));
              model.navigateToWorkoutView(workout.workoutId, model.getTestDuration());
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
        Provider.of<HistoryRepository>(context, listen: false),
      ),
    );
  }
}

class _StartWorkoutDialogButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Key widgetKey;

  _StartWorkoutDialogButton({this.text, this.onPressed, this.widgetKey});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: widgetKey,
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
