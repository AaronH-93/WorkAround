import 'package:flutter/material.dart';
import 'package:work_around/models/ExerciseSet.dart';
import 'package:work_around/widgets/rest_timer.dart';

class SetButton extends StatefulWidget {

  final ExerciseSet set;

  SetButton({this.set});

  @override
  _SetButtonState createState() => _SetButtonState();
}

class _SetButtonState extends State<SetButton> {
  Color defaultColor = Colors.grey[400];

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: widget.set.isCompleted? Colors.green : defaultColor,
      shape: CircleBorder(),
      onPressed: () {
        setState(() {
          defaultColor = Colors.green;
          //Should this be within a service?
          widget.set.isCompleted = true;
          _showRestTimer();
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          widget.set.setNumber.toString(),
        ),
      ),
    );
  }

  _showRestTimer() async {
    await showDialog<String>(
      context: context,
      builder: (_) => RestTimer(context: context),
    );
  }
}

