import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

@JsonSerializable()
class Note {
  String noteId;
  String exerciseId;
  final String noteText;

  Note(this.noteId, this.exerciseId, this.noteText);


  Map<String, dynamic> toJson() => _$NoteToJson(this);
  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
}