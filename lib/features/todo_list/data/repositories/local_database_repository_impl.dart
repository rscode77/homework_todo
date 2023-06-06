import 'package:homework_todo/features/todo_list/data/datasources/database_helper.dart';
import 'package:homework_todo/features/todo_list/domain/repositories/local_database_repository.dart';

import '../models/task_model.dart';

class LocalDatabaseRepositoryImpl implements LocalDatabaseRepository {
  @override
  Future<void> addTask(TaskModel task) async {
    await DatabaseHelper().insertTask(task);
  }

  @override
  Future<List<TaskModel>> getAllTasks() async {
    return await DatabaseHelper().getTasks();
  }

  @override
  Future<void> updateTask(int taskId, String taskStatus) async {
    await DatabaseHelper().updateTask(taskId, taskStatus);
  }
}
