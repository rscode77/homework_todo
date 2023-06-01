part of 'user_authentication_bloc.dart';

abstract class UserAuthenticationEvent extends Equatable {
  const UserAuthenticationEvent();

  @override
  List<Object> get props => [];
}

class VerifyUserEvent extends UserAuthenticationEvent {
  const VerifyUserEvent();
}

class LoginUserEvent extends UserAuthenticationEvent {
  final String login;
  final String password;

  const LoginUserEvent({required this.login, required this.password});

  @override
  List<Object> get props => [login, password];
}

class RegisterUserEvent extends UserAuthenticationEvent {
  final String login;
  final String password;

  const RegisterUserEvent({required this.login, required this.password});

  @override
  List<Object> get props => [login, password];
}
