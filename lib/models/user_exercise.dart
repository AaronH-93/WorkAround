import 'package:json_annotation/json_annotation.dart';

part 'user_exercise.g.dart';

@JsonSerializable()
class UserExercise{
  String exerciseId;
  final String name;
  int reps;
  int weight;
  final String muscleGroup;
  final String equipment;
  final String instructions;
  final String gifUrl;

  UserExercise({this.exerciseId, this.name, this.reps, this.weight, this.muscleGroup, this.instructions, this.gifUrl, this.equipment});

  Map<String, dynamic> toJson() => _$UserExerciseToJson(this);
  factory UserExercise.fromJson(Map<String, dynamic> json) => _$UserExerciseFromJson(json);
}