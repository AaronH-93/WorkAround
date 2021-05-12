import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:work_around/components/rounded_button.dart';
import 'package:work_around/services/authentication_service.dart';
import 'package:work_around/services/navigation_service.dart';
import '../../../constants.dart';
import 'register_view_model.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String firstName;
  String lastName;
  String email;
  String password;
  bool spinner = false;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        key: Key('registerView'),
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
                  key: Key('firstNameField'),
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    model.firstName = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Firstname',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  key: Key('lastNameField'),
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    model.lastName = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Lastname',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  key: Key('registerEmailField'),
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    model.email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  key: Key('registerPasswordField'),
                  textAlign: TextAlign.center,
                  obscureText: true,
                  onChanged: (value) {
                    model.password = value;
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
                  widgetKey: Key('submitRegisterButton'),
                  color: Colors.redAccent,
                  title: 'Register',
                  onPressed: () async {
                    model.register();
                  },
                ),
                TextButton(
                  key: Key('redirectToLoginButton'),
                  child: Text('Have an account? Sign in.'),
                  onPressed: (){
                    model.navigateToLoginView();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => RegisterViewModel(
        Provider.of<NavigationService>(context, listen: false),
        Provider.of<AuthenticationService>(context, listen: false),
      ),
    );
  }
}
