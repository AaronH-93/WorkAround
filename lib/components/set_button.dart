import 'package:flutter/material.dart';
import 'package:work_around/widgets/rest_timer.dart';

class SetButton extends StatefulWidget {

  final int setNumber;

  SetButton({this.setNumber});

  @override
  _SetButtonState createState() => _SetButtonState();
}

class _SetButtonState extends State<SetButton> {
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
      builder: (_) => RestTimer(context: context),
    );
  }
}

