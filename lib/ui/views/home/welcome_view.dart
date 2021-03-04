import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:work_around/components/rounded_button.dart';
import 'package:work_around/services/navigation_service.dart';

import 'welcome_view_model.dart';

class WelcomeView extends StatefulWidget {
  @override
  _WelcomeViewState createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WelcomeViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Text(
                        'WorkAround',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 48.0,
                ),
                RoundedButton(
                    color: Colors.redAccent,
                    title: 'Log in',
                    onPressed: () {
                      model.navigateToLoginView();
                    }),
                RoundedButton(
                    color: Colors.redAccent,
                    title: 'Register',
                    onPressed: () {
                      model.navigateToRegisterView();
                    }),
                // RoundedButton(
                //     color: Colors.greenAccent,
                //     title: 'Home',
                //     onPressed: () {
                //       Navigator.pushNamed(context, HomeScreen.id);
                //     }),
              ],
            ),
          ),
        ),
        viewModelBuilder: () => WelcomeViewModel(
          Provider.of<NavigationService>(context, listen: false)
        ));
  }
}