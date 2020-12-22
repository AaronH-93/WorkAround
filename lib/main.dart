import 'package:flutter/material.dart';
import 'package:work_around/screens/settings_screen.dart';
import 'package:work_around/screens/workout_screen.dart';
import 'screens/home_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/login_screen.dart';
import 'screens/workout_screen.dart';
import 'package:quiver/async.dart';
import 'package:firebase_core/firebase_core.dart';

//
// void main()  {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(MyApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        WorkoutScreen.id: (context) => WorkoutScreen(),
        SettingsScreen.id: (context) => SettingsScreen()
      },
    );
  }
}
