import 'package:json_annotation/json_annotation.dart';

part 'user_set.g.dart';

@JsonSerializable()
class UserSet{
  final String setId;
  final String exerciseId;
  final int effort;
  bool isCompleted;

  UserSet({this.setId, this.exerciseId, this.effort, this.isCompleted});

  Map<String, dynamic> toJson() => _$UserSetToJson(this);
  factory UserSet.fromJson(Map<String, dynamic> json) => _$UserSetFromJson(json);
}