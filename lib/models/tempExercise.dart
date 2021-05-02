import 'package:json_annotation/json_annotation.dart';

part 'tempExercise.g.dart';

@JsonSerializable()
class TempExercise{
  final String name;
  int sets;
  int reps;
  final String muscleGroup;

  TempExercise({this.name, this.sets, this.reps, this.muscleGroup});

  Map<String, dynamic> toJson() => _$TempExerciseToJson(this);
  factory TempExercise.fromJson(Map<String, dynamic> json) => _$TempExerciseFromJson(json);
}