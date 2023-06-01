import 'dart:convert';

import '../../domain/entities/task_entity.dart';

List<TaskModel> taskModelFromJson(String str) {
  final jsonData = json.decode(str);
  return List<TaskModel>.from(jsonData.map((x) => TaskModel.fromJson(x)));
}

String taskModelToJson(List<TaskModel> data) {
  final dyn = List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class TaskModel extends TaskEntity {
  TaskModel({
    required super.id,
    required super.title,
    required super.description,
    required super.date,
    required super.status,
    required super.personal,
    required super.userId,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        date: json['date'],
        status: json["status"],
        personal: json["personal"],
        userId: json["userId"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "date": date,
        "status": status,
        "personal": personal,
        "userId": userId,
      };
}
