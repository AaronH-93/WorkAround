import 'package:work_around/models/workout.dart';

class WorkoutData{
  List<Workout> workouts = [];
  Workout temp = Workout(name: 'Temp', workoutList: []);

  setTempWorkout(Workout value) {
    temp = value;
  }
}