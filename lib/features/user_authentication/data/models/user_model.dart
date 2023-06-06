import 'dart:convert';

import '../../domain/entities/user_entity.dart';

UserModel userFromJson(String str) {
  final jsonData = json.decode(str);
  return UserModel.fromJson(jsonData);
}

String userToJson(UserModel data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.uniqueId,
    required super.name,
    required super.groupId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        uniqueId: json["uniqueId"],
        name: json["name"],
        groupId: json["groupId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uniqueId": uniqueId,
        "name": name,
        "groupId": groupId,
      };
}
