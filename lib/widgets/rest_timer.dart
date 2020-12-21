import 'package:flutter/material.dart';

class RestTimer extends StatefulWidget {
  final BuildContext context;

  RestTimer({this.context});

  @override
  _RestTimerState createState() => _RestTimerState();
}

class _RestTimerState extends State<RestTimer> with TickerProviderStateMixin {
  AnimationController controller;

  Duration get duration => controller.duration;
  bool get expired => duration.inSeconds == 0;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 60),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Center(
            child: AnimatedBuilder(
                animation: controller,
                builder: (BuildContext context, Widget child) {
                  return new Text(
                    '${duration.inSeconds}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50.0,
                      color: Colors.white,
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }
}
