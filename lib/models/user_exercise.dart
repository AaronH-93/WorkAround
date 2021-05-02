import 'package:json_annotation/json_annotation.dart';

part 'user_exercise.g.dart';

@JsonSerializable()
class UserExercise{
  final String exerciseId;
  final String name;
  final int reps;
  final String muscleGroup;

  UserExercise({this.exerciseId, this.name, this.reps, this.muscleGroup});

  Map<String, dynamic> toJson() => _$UserExerciseToJson(this);
  factory UserExercise.fromJson(Map<String, dynamic> json) => _$UserExerciseFromJson(json);
}