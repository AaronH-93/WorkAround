import 'package:work_around/models/workout.dart';

class WorkoutData{
  List<Workout> workouts = [];
  Workout temp = Workout(name: 'Temp', exerciseList: []);

  setTempWorkout(Workout value) {
    temp = value;
  }

  Workout currentWorkout = Workout(name: 'Temp', exerciseList: []);

  setCurrentWorkout(Workout value) {
    currentWorkout = value;
  }
}