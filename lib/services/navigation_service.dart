import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_around/models/exercise.dart';
import 'package:work_around/models/user_workout.dart';
import 'package:work_around/ui/views/auth/login_view.dart';
import 'package:work_around/ui/views/auth/register_view.dart';
import 'package:work_around/ui/views/exercise/add_exercise_view.dart';
import 'package:work_around/ui/views/exercise/create_workout_view.dart';
import 'package:work_around/ui/views/exercise/exercise_information_view.dart';
import 'package:work_around/ui/views/exercise/exercises_view.dart';
import 'package:work_around/ui/views/exercise/workout_view.dart';
import 'package:work_around/ui/views/home/home_view.dart';
import 'package:work_around/ui/views/settings/account_view.dart';
import 'package:work_around/ui/views/settings/help_view.dart';
import 'package:work_around/ui/views/settings/settings_view.dart';
import 'package:work_around/ui/views/exercise/view_exercises_view.dart';


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
          builder: (context) => HomeView(),
          settings: const RouteSettings(name: 'home_view'),
        ));
  }

  void navigateToWorkoutView(Duration duration, String workoutId) {
    navigator.push(
        MaterialPageRoute<void>(
          builder: (context) {
            return WorkoutView(duration, workoutId);
          },
          settings: const RouteSettings(name: 'workout_view'),
        ),
    );
  }

  void navigateToNewWorkoutView(Duration duration, String workoutId) {
    navigator.pushReplacement(
      MaterialPageRoute<void>(
        builder: (context) {
          return WorkoutView(duration, workoutId);
        },
        settings: const RouteSettings(name: 'workout_view'),
      ),
    );
  }

  void navigateToExercisesView(UserWorkout newWorkout) {
    navigator.push(
        MaterialPageRoute<void>(
          builder: (context) {
            return ExerciseView(newWorkout: newWorkout);
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

  void navigateToCreateWorkoutView(UserWorkout newWorkout) {
    navigator.push(
        MaterialPageRoute<void>(
          builder: (context) {
            return CreateWorkoutView(newWorkout: newWorkout);
          },
          settings: const RouteSettings(name: 'create_workout_view'),
        ));
  }

  void navigateToViewExercisesView() {
    navigator.push(
        MaterialPageRoute<void>(
          builder: (context) {
            return ViewExercisesView();
          },
          settings: const RouteSettings(name: 'view_exercises_view'),
        ));
  }

  void navigateToExerciseInformationView(Exercise exercise) {
    navigator.push(
        MaterialPageRoute<void>(
          builder: (context) {
            return ExerciseInformationView(exercise: exercise);
          },
          settings: const RouteSettings(name: 'exercise_information_view'),
        ));
  }

  navigateToAddExerciseView(UserWorkout newWorkout, Exercise exercise) {
    navigator.push(
        MaterialPageRoute<void>(
          builder: (context) {
            return AddExerciseView(newWorkout, exercise);
          },
          settings: const RouteSettings(name: 'exercise_information_view'),
        ));
  }
}
