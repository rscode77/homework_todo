class TaskEntity {
  final int id;
  final String title;
  final String description;

  final DateTime date;

  TaskEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });
}
