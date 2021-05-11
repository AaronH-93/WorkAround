import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:work_around/components/rounded_button.dart';
import 'package:work_around/constants.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/navigation_service.dart';

import 'login_view_model.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>{
  String email;
  String password;
  bool spinner = false;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
        builder: (context, model, child) =>
            Scaffold(
              key: Key('loginView'),
              backgroundColor: Colors.white,
              body: ModalProgressHUD(
                inAsyncCall: spinner,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Center(
                        child: Text(
                          'WorkAround',
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 48.0,
                      ),
                      TextField(
                          key: Key('emailField'),
                          onChanged: (value) {
                            email = value;
                          },
                          decoration: kTextFieldDecoration.copyWith(
                            hintStyle: TextStyle(color: Colors.white),
                          )
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextField(
                        key: Key('passwordField'),
                        obscureText: true,
                        onChanged: (value) {
                          password = value;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your password',
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      RoundedButton(
                        widgetKey: Key('submit'),
                        color: Colors.red,
                        title: 'Log in',
                        onPressed: () async {
                          setState(() {
                            spinner = true;
                          });
                          try {
                            model.validateAndSubmitSignIn(email, password);
                            spinner = false;
                          } catch (e) {
                            print(e);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
        viewModelBuilder: () => LoginViewModel(
            Provider.of<AuthenticationService>(context, listen: false),
            Provider.of<NavigationService>(context, listen: false),
        ),
    );
  }
}
