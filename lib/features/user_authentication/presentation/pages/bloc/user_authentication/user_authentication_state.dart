part of 'user_authentication_bloc.dart';

abstract class UserAuthenticationState extends Equatable {
  const UserAuthenticationState();

  @override
  List<Object?> get props => [];
}

class UserAuthenticationInitial extends UserAuthenticationState {}

class UserAuthenticationCheck extends UserAuthenticationState {}

class UserUnauthenticated extends UserAuthenticationState {}

class UserAuthenticationSuccess extends UserAuthenticationState {
  final int userId;

  const UserAuthenticationSuccess({
    required this.userId,
  });

  @override
  List<Object?> get props => [userId];
}

class UserAuthenticationError extends UserAuthenticationState {
  final String authenticationError;
  const UserAuthenticationError({
    required this.authenticationError,
  });
}
