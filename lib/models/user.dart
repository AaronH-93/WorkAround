import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String firstName;
  final String lastName;
  final String email;

  User(this.firstName, this.lastName, this.email);

  test(String test){
    return test;
  }

  Map<String, dynamic> toJson() => _$UserToJson(this);
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}