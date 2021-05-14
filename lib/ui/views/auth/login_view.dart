import 'package:flutter/material.dart';
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

class _LoginViewState extends State<LoginView> {
  String email;
  String password;

  _LoginViewState();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        key: Key('loginView'),
        backgroundColor: Colors.white,
        body: Padding(
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
              model.displayErrorMessage() ? ErrorMessage() : SizedBox(),
              TextField(
                key: Key('emailField'),
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintStyle: TextStyle(color: Colors.white),
                ),
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
                  model.submitSignIn(email, password);
                },
              ),
              model.hasError ? Text(model.errorMessage) : SizedBox(),
              TextButton(
                key: Key('redirectToResetPasswordButton'),
                onPressed: () {
                  model.navigateToResetPasswordView();
                },
                child: Text('Forgot Password?'),
              ),
              TextButton(
                key: Key('redirectToRegisterButton'),
                child: Text('Don\'t have an account?'),
                onPressed: () {
                  model.navigateToRegisterView();
                },
              ),
            ],
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

class ErrorMessage extends ViewModelWidget<LoginViewModel> {
  const ErrorMessage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, LoginViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[300],
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              model.errorMessage.split(']')[1],
              style: TextStyle(
                fontSize: 16,
                color: Colors.redAccent,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
