part of 'user_registration_bloc.dart';

abstract class UserRegistrationState extends Equatable {
  const UserRegistrationState();

  @override
  List<Object> get props => [];
}

class UserRegistrationInitial extends UserRegistrationState {}

class UserRegistrationAttempt extends UserRegistrationState {}

class UserRegistrationSuccess extends UserRegistrationState {}

class UserRegistrationError extends UserRegistrationState {
  final String message;

  const UserRegistrationError({required this.message});

  @override
  List<Object> get props => [message];
}
