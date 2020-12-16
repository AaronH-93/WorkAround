import 'package:flutter/material.dart';
import 'package:work_around/components/rounded_button.dart';
import 'workout_screen.dart';
import 'file:///C:/Users/Salty/AndroidStudioProjects/work_around/lib/widgets/alert_dialog_box.dart';

final controller = TextEditingController();

class HomeScreen extends StatefulWidget {
  static final String id = 'HomeScreen';
  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            RoundedButton(
              onPressed: (){
                _showDialog();
              },
              title: 'Workout',
              color: Colors.redAccent,
            )
          ],
        ),
      ),
    );
  }
  _showDialog() async {
    await showDialog<String>(
      context: context,
      child: AlertDialogBox(context: context),
    );
  }
}




