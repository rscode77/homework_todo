import 'package:homework_todo/config/exceptions.dart';
import 'package:homework_todo/features/shared/models/api_response.dart';

import 'package:http/http.dart' as http;
import 'package:unique_identifier/unique_identifier.dart';
import 'package:homework_todo/features/user_authentication/data/models/user_model.dart';

import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final String baseUrl = 'https://rscode.online:8029/api/User';

  Future<String?> uuid() async {
    return await UniqueIdentifier.serial;
  }

  @override
  Future<UserModel> verifyUser() async {
    var url = Uri.parse('$baseUrl/VerifyUser');

    try {
      var response = await http.post(url, body: {'uniqueId': await uuid()});

      if (response.statusCode == 200) {
        return userFromJson(response.body);
      }
      throw AuthenticationFaild('Failed to verify user');
    } catch (e) {
      throw ConnectionFaild('Failed to establish connection');
    }
  }

  @override
  Future<UserModel> loginUser({required String name, required String password}) async {
    final url = Uri.parse('$baseUrl/LoginUser');

    try {
      final response = await http.post(
        url,
        body: {'name': name, 'password': password},
      );

      if (name == '' && password == '') {
        throw CompleteTheData('Complete the data');
      }

      if (response.statusCode == 200) {
        return userFromJson(response.body);
      } else {
        throw AuthenticationError(response.body);
      }
    } on AuthenticationError catch (e) {
      throw AuthenticationError(e.message);
    } catch (e) {
      throw AuthenticationError('Failed to establish connection');
    }
  }

  @override
  Future<UserModel> loginUser({required String name, required String password}) async {
    final url = Uri.parse('$baseUrl/LoginUser');

    try {
      if (name == '' && password == '') {
        throw AuthenticationError('Complete the data');
      }

      final response = await http.post(
        url,
        body: {'name': name, 'password': password},
      );

      if (response.statusCode == 200) {
        return userFromJson(response.body);
      } else {
        throw AuthenticationError(response.body);
      }
    } on AuthenticationError catch (e) {
      throw AuthenticationError(e.message);
    } catch (e) {
      throw AuthenticationError('Failed to establish connection');
    }
  }

  @override
  Future<ApiResposne> addNewUser({required String name, required String password}) async {
    final url = Uri.parse('$baseUrl/AddNewUser');

    try {
      final response = await http.post(
        url,
        body: {'name': name, 'password': password, 'uniqueId': await uuid()},
      );

      if (name.isEmpty && password.isEmpty) {
        throw RegistrationError('Complete the data');
      }

      if (response.statusCode == 200) {
        return ApiResposne(statusCode: response.statusCode, message: response.body);
      } else {
        throw RegistrationError(response.body);
      }
    } on RegistrationError catch (e) {
      throw RegistrationError(e.message);
    } catch (e) {
      throw RegistrationError('Failed to establish connection');
    }
  }
}
