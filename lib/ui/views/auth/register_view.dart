import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:work_around/components/rounded_button.dart';
import 'package:work_around/services/navigation_service.dart';

import '../../../constants.dart';
import 'register_view_model.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool spinner = false;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
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
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
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
                  textAlign: TextAlign.center,
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
                  color: Colors.redAccent,
                  title: 'Register',
                  onPressed: () async {
                    setState(() {
                      spinner = true;
                    });
                    try {
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                      if (newUser != null) {}
                      // Navigator.pushNamed(context, HomeScreen.id);
                      // setState(() {
                      //   spinner = false;
                      // });
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
      viewModelBuilder: () => RegisterViewModel(
          Provider.of<NavigationService>(context, listen: false)),
    );
  }
}
