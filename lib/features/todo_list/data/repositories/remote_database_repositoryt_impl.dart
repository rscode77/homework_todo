import 'dart:convert';
import 'package:homework_todo/features/shared/models/api_response.dart';
import 'package:http/http.dart' as http;

import '../../../../config/exceptions.dart';
import '../../domain/repositories/remote_database_repository.dart';
import '../models/task_model.dart';

class RemoteDatabaseRepositoryImpl implements RemoteDatabaseRepository {
  final String baseUrl = 'https://rscode.online:8029/api/Task';

  @override
  Future<ApiResposne> addTask({required TaskModel task}) async {
    final url = Uri.parse('$baseUrl/AddNewTask');

    final response = await http.post(
      url,
      body: {
        'title': task.title,
        'description': task.description,
        'userID': '${task.userId}',
        'personal': task.personal,
        'date': task.date,
      },
    );

    if (response.statusCode != 200) {
      throw ConnectionFaild('Failed to add task');
    }

    return ApiResposne(statusCode: response.statusCode, message: response.body);
  }

  @override
  Future<List<TaskModel>> getAllTasks({required int userId}) async {
    final url = Uri.parse('$baseUrl/GetTasks');

    final response = await http.post(
      url,
      body: {'userId': '$userId'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((task) => TaskModel.fromJson(task)).toList();
    } else {
      throw ConnectionFaild('Failed to establish connection');
    }
  }

  @override
  Future<ApiResposne> updateTaskStatus({required int taskId, required String status}) async {
    final url = Uri.parse('$baseUrl/UpdateTaskStatus');

    final response = await http.put(
      url,
      body: {
        'taskId': '$taskId',
        'status': status,
      },
    );

    if (response.statusCode == 200) {
      return ApiResposne(statusCode: response.statusCode, message: response.body);
    } else {
      throw ConnectionFaild('Failed to establish connection');
    }
  }
}
