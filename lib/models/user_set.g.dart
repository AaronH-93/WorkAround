// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSet _$UserSetFromJson(Map<String, dynamic> json) {
  return UserSet(
    setId: json['setId'] as String,
    exerciseId: json['exerciseId'] as String,
    effort: json['effort'] as int,
    isCompleted: json['isCompleted'] as bool,
  );
}

Map<String, dynamic> _$UserSetToJson(UserSet instance) => <String, dynamic>{
      'setId': instance.setId,
      'exerciseId': instance.exerciseId,
      'effort': instance.effort,
      'isCompleted': instance.isCompleted,
    };
