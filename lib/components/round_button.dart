import 'package:flutter/material.dart';

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
}

