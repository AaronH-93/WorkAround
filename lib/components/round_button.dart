import 'package:flutter/material.dart';
import 'package:work_around/widgets/rest_timer.dart';

class RoundButton extends StatefulWidget {

  final int setNumber;

  RoundButton({this.setNumber});

  @override
  _RoundButtonState createState() => _RoundButtonState();
}

class _RoundButtonState extends State<RoundButton> {
  Color color = Colors.grey[400];

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: color,
      shape: CircleBorder(),
      onPressed: () {
        setState(() {
          color = Colors.green;
          _showRestTimer();
        });

        //Todo: when a set button is pressed, display a rest timer.
        //Todo: Dynamically adjust workout based on leftover duration
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          widget.setNumber.toString(),
        ),
      ),
    );
  }

  _showRestTimer() async {
    await showDialog<String>(
      context: context,
      child: RestTimer(context: context),
    );
  }
}

