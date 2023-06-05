part of 'user_registration_bloc.dart';

abstract class UserRegistrationEvent extends Equatable {
  const UserRegistrationEvent();

  @override
  List<Object> get props => [];
}

class RegisterUserEvent extends UserRegistrationEvent {
  final String login;
  final String password;

  const RegisterUserEvent({required this.login, required this.password});

  @override
  List<Object> get props => [login, password];
}
