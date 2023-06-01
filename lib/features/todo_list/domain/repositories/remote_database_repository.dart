import 'package:homework_todo/features/shared/models/api_response.dart';
import 'package:homework_todo/features/todo_list/data/models/task_model.dart';

abstract class RemoteDatabaseRepository {
  Future<ApiResposne> addTask({required TaskModel task});
  Future<List<TaskModel>> getAllTasks({required int userId});
  Future<ApiResposne> updateTaskStatus({required int taskId, required String status});
}
