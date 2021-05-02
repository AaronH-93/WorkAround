import 'package:json_annotation/json_annotation.dart';

part 'user_workout.g.dart';

@JsonSerializable()
class UserWorkout {
  final String workoutId;
  final String name;

  UserWorkout(this.workoutId, this.name);

  Map<String, dynamic> toJson() => _$UserWorkoutToJson(this);
  factory UserWorkout.fromJson(Map<String, dynamic> json) => _$UserWorkoutFromJson(json);
}