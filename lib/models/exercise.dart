import 'ExerciseSet.dart';

class Exercise{
  String exerciseId;
  final String name;
  int effort;
  List<ExerciseSet> sets;
  int reps;
  final String muscleGroup;
  final String instructions;
  final String gifUrl;

  Exercise({this.exerciseId, this.name, this.effort, this.sets, this.reps, this.muscleGroup, this.gifUrl, this.instructions});
}