import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_around/models/workout.dart';
import 'package:work_around/ui/views/auth/login_view.dart';
import 'package:work_around/ui/views/auth/register_view.dart';
import 'package:work_around/ui/views/exercise/create_workout_view.dart';
import 'package:work_around/ui/views/exercise/exercises_view.dart';
import 'package:work_around/ui/views/exercise/workout_view.dart';
import 'package:work_around/ui/views/home/home_view.dart';
import 'package:work_around/ui/views/settings/account_view.dart';
import 'package:work_around/ui/views/settings/help_view.dart';
import 'package:work_around/ui/views/settings/settings_view.dart';

class NavigationService {

  void pop<T extends Object>([T result]) {
    navigator.pop(result);
  }

  void navigateToLoginInView() {
    navigator.push(
        MaterialPageRoute<void>(
          builder: (context) {
            return LoginView();
          },
          settings: const RouteSettings(name: 'login_view'),
        ));
  }

  void navigateToRegisterView() {
    navigator.push(
        MaterialPageRoute<void>(
          builder: (context) {
            return RegisterView();
          },
          settings: const RouteSettings(name: 'register_view'),
        ));
  }

  void navigateToHomeView() {
    navigator.push(
        MaterialPageRoute<void>(
          builder: (context) {
            return HomeView();
          },
          settings: const RouteSettings(name: 'home_view'),
        ));
  }

  void navigateToWorkoutView(int duration, Workout workout) {
    navigator.push(
        MaterialPageRoute<void>(
          builder: (context) {
            return WorkoutView(duration, workout);
          },
          settings: const RouteSettings(name: 'workout_view'),
        ));
  }

  void navigateToExercisesView() {
    navigator.push(
        MaterialPageRoute<void>(
          builder: (context) {
            return ExerciseView();
          },
          settings: const RouteSettings(name: 'exercise_view'),
        ));
  }

  void navigateToAccountView() {
    navigator.push(
        MaterialPageRoute<void>(
          builder: (context) {
            return AccountView();
          },
          settings: const RouteSettings(name: 'account_view'),
        ));
  }

  void navigateToSettingsView() {
    navigator.push(
        MaterialPageRoute<void>(
          builder: (context) {
            return SettingsView();
          },
          settings: const RouteSettings(name: 'settings_view'),
        ));
  }

  void navigateToHelpView() {
    navigator.push(
        MaterialPageRoute<void>(
          builder: (context) {
            return HelpView();
          },
          settings: const RouteSettings(name: 'help_view'),
        ));
  }

  void navigateToCreateWorkoutView() {
    navigator.push(
        MaterialPageRoute<void>(
          builder: (context) {
            return CreateWorkoutView();
          },
          settings: const RouteSettings(name: 'create_workout_view'),
        ));
  }
}
