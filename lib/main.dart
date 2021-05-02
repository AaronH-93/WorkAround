import 'package:flutter/material.dart';
import 'package:work_around/workaround_view.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(WorkAroundView());
}