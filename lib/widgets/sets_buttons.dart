import 'package:flutter/material.dart';
import 'package:work_around/components/round_button.dart';

class SetsButtons extends StatelessWidget {
  final int sets;

  SetsButtons({this.sets});

  Widget buildRowOfButtons() {
    List<Widget> list = List<Widget>();
    for (var i = 0; i < sets; i++) {
      list.add(
        RoundButton(
          setNumber: i + 1,
        ),
      );
    }
    return new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: list,
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildRowOfButtons();
  }
}

