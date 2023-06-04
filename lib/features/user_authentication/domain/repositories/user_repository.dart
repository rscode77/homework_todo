import 'package:homework_todo/features/shared/models/api_response.dart';
import 'package:homework_todo/features/user_authentication/data/models/user_model.dart';

abstract class UserRepository {
  Future<UserModel> loginUser({required String name, required String password});
  Future<ApiResposne> addNewUser({required String name, required String password});
  Future<UserModel> verifyUser();
}
