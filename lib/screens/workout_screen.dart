import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_around/models/exercise_data.dart';
import 'package:work_around/widgets/exercise_list.dart';

class WorkoutScreen extends StatefulWidget {
  static final String id = 'WorkoutScreen';

  final int duration;

  WorkoutScreen({this.duration});

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => ExerciseData(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.grey[600],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: ExerciseList(
          workoutDuration: widget.duration,
        ),
      ),
    );
  }
}
