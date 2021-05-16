// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserExercise _$UserExerciseFromJson(Map<String, dynamic> json) {
  return UserExercise(
    exerciseId: json['exerciseId'] as String,
    name: json['name'] as String,
    reps: json['reps'] as int,
    weight: json['weight'] as int,
    muscleGroup: json['muscleGroup'] as String,
    instructions: json['instructions'] as String,
    gifUrl: json['gifUrl'] as String,
    equipment: json['equipment'] as String,
  );
}

Map<String, dynamic> _$UserExerciseToJson(UserExercise instance) =>
    <String, dynamic>{
      'exerciseId': instance.exerciseId,
      'name': instance.name,
      'reps': instance.reps,
      'weight': instance.weight,
      'muscleGroup': instance.muscleGroup,
      'equipment': instance.equipment,
      'instructions': instance.instructions,
      'gifUrl': instance.gifUrl,
    };
