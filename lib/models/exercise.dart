import 'ExerciseSet.dart';

class Exercise{
  final String name;
  List<ExerciseSet> sets;
  int reps;
  final String muscleGroup;

  Exercise({this.name, this.sets, this.reps, this.muscleGroup});
}