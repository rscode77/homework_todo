class AuthenticationFaild implements Exception {
  final String message;
  AuthenticationFaild(this.message);
}

class ConnectionFaild implements Exception {
  String message;
  ConnectionFaild(this.message);
}

class TaskListError implements Exception {
  String message;
  TaskListError(this.message);
}

class RegistrationError implements Exception {
  String message;
  RegistrationError(this.message);
}
