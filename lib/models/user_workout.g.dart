// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_workout.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserWorkout _$UserWorkoutFromJson(Map<String, dynamic> json) {
  return UserWorkout(
    json['workoutId'] as String,
    json['name'] as String,
  )
    ..workoutDuration = json['workoutDuration'] as String
    ..date = json['date'] as String;
}

Map<String, dynamic> _$UserWorkoutToJson(UserWorkout instance) =>
    <String, dynamic>{
      'workoutId': instance.workoutId,
      'name': instance.name,
      'workoutDuration': instance.workoutDuration,
      'date': instance.date,
    };
