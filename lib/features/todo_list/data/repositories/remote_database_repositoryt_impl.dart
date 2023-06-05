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

    try {
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
        throw TaskListError(response.body);
      }
      return ApiResposne(statusCode: response.statusCode, message: response.body);
    } on TaskListError catch (e) {
      throw TaskListError(e.message);
    } catch (e) {
      throw TaskListError('Failed to establish connection');
    }
  }

  @override
  Future<List<TaskModel>> getAllTasks({required int userId}) async {
    final url = Uri.parse('$baseUrl/GetTasks');

    try {
      final response = await http.post(
        url,
        body: {'userId': '$userId'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse.map((task) => TaskModel.fromJson(task)).toList();
      } else {
        throw TaskListError(response.body);
      }
    } on ConnectionError catch (e) {
      throw ConnectionError(e.message);
    } catch (e) {
      throw TaskListError('Failed to establish connection');
    }
  }

  @override
  Future<ApiResposne> updateTaskStatus({required int taskId, required String status}) async {
    final url = Uri.parse('$baseUrl/UpdateTaskStatus');

    try {
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
        throw ConnectionError(response.body);
      }
    } on ConnectionError catch (e) {
      throw ConnectionError(e.message);
    } catch (e) {
      throw TaskListError('Failed to establish connection');
    }
  }
}
