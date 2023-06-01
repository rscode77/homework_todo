import 'package:equatable/equatable.dart';

class TaskEntity {
  int id;
  String title;
  String description;
  String status;
  String date;
  String personal;
  int userId;

  TaskEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.date,
    required this.personal,
    required this.userId,
  });

  TaskEntity copyWith({
    int? id,
    String? title,
    String? description,
    String? status,
    String? date,
    String? personal,
    int? userId,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      date: date ?? this.date,
      personal: personal ?? this.personal,
      userId: userId ?? this.userId,
    );
  }
}
