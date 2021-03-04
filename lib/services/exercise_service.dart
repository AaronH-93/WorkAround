import 'dart:collection';
import 'package:work_around/models/exercise.dart';
import 'package:work_around/models/exercise_data.dart';
import 'package:work_around/models/workout.dart';
import 'package:work_around/models/workout_data.dart';

class ExerciseService{
  final ExerciseData _exerciseData;
  final WorkoutData _workoutData;
  ExerciseService(this._exerciseData, this._workoutData);

  UnmodifiableListView<Exercise> get exercises => _exerciseData.exercises;
  get workouts => _workoutData.workouts;
  get temp => _workoutData.temp;

  void setTemp(Workout temp) => _workoutData.setTempWorkout(temp);

  void addWorkout(String workoutName){
    _workoutData.temp.name = workoutName;
    _workoutData.workouts.add(_workoutData.temp);
  }

  void addToTempWorkout(Exercise exercise){
    _workoutData.temp.workoutList.add(exercise);
  }

  Exercise getTempWorkout(int index){
    return _workoutData.temp.workoutList[index];
  }

  Workout getWorkout(int index){
    return _workoutData.workouts[index];
  }

  int getNumOfExercises(){
    return _workoutData.temp.workoutList.length;
  }

  int getNumOfWorkouts(){
    return _workoutData.workouts.length;
  }

  void generateSets(int duration, List<Exercise> workout){
    _exerciseData.generateSets(duration, workout);
  }
}