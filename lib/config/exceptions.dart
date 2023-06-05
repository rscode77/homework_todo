class AuthenticationError implements Exception {
  final String message;
  AuthenticationError(this.message);
}

class ConnectionError implements Exception {
  String message;
  ConnectionError(this.message);
}

class TaskListError implements Exception {
  String message;
  TaskListError(this.message);
}

class RegistrationError implements Exception {
  String message;
  RegistrationError(this.message);
}
