import '../../data/models/task_model.dart';

abstract class LocalDatabaseRepository {
  Future<void> addTask(TaskModel task);
  Future<void> deleteTask(int taskId);
  Future<void> updateTask(int taskId, String taskStatus);
  Future<List<TaskModel>> getAllTasks();
}
