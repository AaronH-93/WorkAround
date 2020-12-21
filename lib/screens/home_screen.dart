import 'package:flutter/material.dart';
import 'package:work_around/components/rounded_button.dart';
import 'workout_screen.dart';
import 'file:///C:/Users/Salty/AndroidStudioProjects/work_around/lib/widgets/alert_dialog_box.dart';
import 'package:work_around/widgets/workout_list.dart';

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
                      'User :)',
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
              DrawerTile(
                text: 'Account',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              DrawerTile(
                text: 'Exercises',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              DrawerTile(
                text: 'Settings',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              DrawerTile(
                text: 'Help',
                onPressed: () {
                  Navigator.pop(context);
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
                  'Welcome, User!',
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
                  child: FlatButton(
                    onPressed: () {
                      print('Create Workout');
                    },
                    child: Text(
                      'CREATE WORKOUT',
                    style: TextStyle(
                      color: Colors.white,
                    ),),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Material(
                  elevation: 5,
                  borderRadius: buildBorderRadiusTop(),
                  color: Colors.grey[300],
                  child: Column(
                    children: [
                      Container(
                        child: Expanded(
                          child: ListView(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: FlatButton(
                                            onLongPress: (){
                                              print("Edit Workout Name");
                                            },
                                            child: Text(
                                                'UPPER BODY',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.redAccent,
                                            ),),
                                          ),
                                        ),
                                        FlatButton(
                                          child: Text(
                                            'EDIT',
                                          ),
                                        ),
                                        FlatButton(
                                          child: Text(
                                            'DELETE',
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: FlatButton(
                                            onLongPress: (){
                                              print("Edit Workout Name");
                                            },
                                            child: Text(
                                              'LOWER BODY',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.redAccent,
                                              ),),
                                          ),
                                        ),
                                        FlatButton(
                                          child: Text(
                                            'EDIT',
                                          ),
                                        ),
                                        FlatButton(
                                          child: Text(
                                            'DELETE',
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: FlatButton(
                                            onLongPress: (){
                                              print("Edit Workout Name");
                                            },
                                            child: Text(
                                              'CORE',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.redAccent,
                                              ),),
                                          ),
                                        ),
                                        FlatButton(
                                          child: Text(
                                            'EDIT',
                                          ),
                                        ),
                                        FlatButton(
                                          child: Text(
                                            'DELETE',
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: FlatButton(
                                            onLongPress: (){
                                              print("Edit Workout Name");
                                            },
                                            child: Text(
                                              'ARMS',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.redAccent,
                                              ),),
                                          ),
                                        ),
                                        FlatButton(
                                          child: Text(
                                            'EDIT',
                                          ),
                                        ),
                                        FlatButton(
                                          child: Text(
                                            'DELETE',
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: FlatButton(
                                            onLongPress: (){
                                              print("Edit Workout Name");
                                            },
                                            child: Text(
                                              'MACHINE',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.redAccent,
                                              ),),
                                          ),
                                        ),
                                        FlatButton(
                                          child: Text(
                                            'EDIT',
                                          ),
                                        ),
                                        FlatButton(
                                          child: Text(
                                            'DELETE',
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: FlatButton(
                                            onLongPress: (){
                                              print("Edit Workout Name");
                                            },
                                            child: Text(
                                              'CHEST',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.redAccent,
                                              ),),
                                          ),
                                        ),
                                        FlatButton(
                                          child: Text(
                                            'EDIT',
                                          ),
                                        ),
                                        FlatButton(
                                          child: Text(
                                            'DELETE',
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: FlatButton(
                                            onLongPress: (){
                                              print("Edit Workout Name");
                                            },
                                            child: Text(
                                              'BACK',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.redAccent,
                                              ),),
                                          ),
                                        ),
                                        FlatButton(
                                          child: Text(
                                            'EDIT',
                                          ),
                                        ),
                                        FlatButton(
                                          child: Text(
                                            'DELETE',
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: FlatButton(
                                            onLongPress: (){
                                              print("Edit Workout Name");
                                            },
                                            child: Text(
                                              'WARM UP',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.redAccent,
                                              ),),
                                          ),
                                        ),
                                        FlatButton(
                                          child: Text(
                                            'EDIT',
                                          ),
                                        ),
                                        FlatButton(
                                          child: Text(
                                            'DELETE',
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: FlatButton(
                                            onLongPress: (){
                                              print("Edit Workout Name");
                                            },
                                            child: Text(
                                              'BODY WEIGHT',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.redAccent,
                                              ),),
                                          ),
                                        ),
                                        FlatButton(
                                          child: Text(
                                            'EDIT',
                                          ),
                                        ),
                                        FlatButton(
                                          child: Text(
                                            'DELETE',
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: FlatButton(
                                            onLongPress: (){
                                              print("Edit Workout Name");
                                            },
                                            child: Text(
                                              'EASY',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.redAccent,
                                              ),),
                                          ),
                                        ),
                                        FlatButton(
                                          child: Text(
                                            'EDIT',
                                          ),
                                        ),
                                        FlatButton(
                                          child: Text(
                                            'DELETE',
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: FlatButton(
                                            onLongPress: (){
                                              print("Edit Workout Name");
                                            },
                                            child: Text(
                                              'HARD',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.redAccent,
                                              ),),
                                          ),
                                        ),
                                        FlatButton(
                                          child: Text(
                                            'EDIT',
                                          ),
                                        ),
                                        FlatButton(
                                          child: Text(
                                            'DELETE',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Material(
                elevation: 5,
                child: Container(
                  color: Colors.grey[300],
                  child: Center(
                    child: RoundedButton(
                      onPressed: () {
                        _showDialog();
                      },
                      title: 'Workout',
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ),
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

class DrawerTile extends StatelessWidget {
  final String text;
  final Function onPressed;

  DrawerTile({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(text),
      onTap: onPressed,
    );
  }
}

BorderRadius buildBorderRadiusTop() => BorderRadius.only(
    topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0));
