import 'package:work_around/components/rounded_button.dart';
import 'package:work_around/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool spinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your password'
                  )
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                color: Colors.red,
                title: 'Log in',
                onPressed: () {
                  setState(() {
                    spinner = true;
                  });
                  try {
                    // final returningUser = await _auth.signInWithEmailAndPassword(
                    //     email: email, password: password);
                    // if (returningUser != null) {
                    //   Navigator.pushNamed(context, HomeScreen.id);
                    // }

                    Navigator.pushNamed(context, HomeScreen.id);
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
    );
  }
}
