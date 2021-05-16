// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Note _$NoteFromJson(Map<String, dynamic> json) {
  return Note(
    json['noteId'] as String,
    json['exerciseId'] as String,
    json['noteText'] as String,
  );
}

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
      'noteId': instance.noteId,
      'exerciseId': instance.exerciseId,
      'noteText': instance.noteText,
    };
