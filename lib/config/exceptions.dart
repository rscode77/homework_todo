class UserExists implements Exception {
  String cause;
  UserExists(this.cause);
}

class AuthenticationFaild implements Exception {
  String cause;
  AuthenticationFaild(this.cause);
}

class ConnectionFaild implements Exception {
  String cause;
  ConnectionFaild(this.cause);
}

class CompleteTheData implements Exception {
  String cause;
  CompleteTheData(this.cause);
}
