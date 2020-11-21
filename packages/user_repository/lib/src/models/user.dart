import 'dart:convert';
import 'package:equatable/equatable.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User extends Equatable {
  const User({
    this.data,
  });

  final Data data;

  factory User.fromJson(Map<String, dynamic> json) => User(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };

  static const empty = User(
    data: Data(
      id: 0,
      name: '-',
      email: '-',
      // emailVerifiedAt: new DateTime.now(),
      // createdAt: new DateTime.now(),
      // updatedAt: new DateTime.now(),
      parentEmail: '-',
      penalty: 0,
      avatarId: 1,
      role: ['student'],
    ),
  );

  @override
  List<Object> get props => [data];
}

class Data {
  const Data({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.parentEmail,
    this.penalty,
    this.avatarId,
    this.role,
  });

  final int id;
  final String name;
  final String email;
  final DateTime emailVerifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String parentEmail;
  final int penalty;
  final int avatarId;
  final List<String> role;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        parentEmail: json["parent_email"],
        penalty: json["penalty"],
        avatarId: json["avatar_id"],
        role: List<String>.from(json["role"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "parent_email": parentEmail,
        "penalty": penalty,
        "avatar_id": avatarId,
        "role": List<dynamic>.from(role.map((x) => x)),
      };
}
