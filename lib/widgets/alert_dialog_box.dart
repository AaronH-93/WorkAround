import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:work_around/screens/workout_screen.dart';

final controller = TextEditingController();

class AlertDialogBox extends StatelessWidget {
  static String estDuration;
  final BuildContext context;

  AlertDialogBox({this.context});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
        AlertDialogButton(
          text: 'Cancel',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        AlertDialogButton(
          text: 'Confirm',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WorkoutScreen(
                  duration: int.parse(controller.text),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class AlertDialogButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  AlertDialogButton({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(text),
      onPressed: onPressed,
    );
  }
}
