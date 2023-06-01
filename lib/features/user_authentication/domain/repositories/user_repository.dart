import 'package:homework_todo/features/user_authentication/data/models/user_model.dart';

abstract class UserRepository {
  Future<void> loginUser({required String name, required String password});
  Future<void> addNewUser({required String name, required String password});
  Future<UserModel> verifyUser();
}
