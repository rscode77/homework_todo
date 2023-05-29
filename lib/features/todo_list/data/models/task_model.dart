import 'dart:convert';
import '../../domain/entities/task_entity.dart';

List<TaskModel> todoModelFromJson(String str) {
  final jsonData = json.decode(str);
  return List<TaskModel>.from(jsonData.map((x) => TaskModel.fromJson(x)));
}

String todoModelToJson(List<TaskModel> data) {
  final dyn = List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class TaskModel extends TaskEntity {
  TaskModel({
    required super.id,
    required super.title,
    required super.description,
    required super.date,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "date": description,
      };
}
