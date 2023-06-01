part of 'user_authentication_bloc.dart';

class UserAuthenticationState extends Equatable {
  const UserAuthenticationState({
    required this.userId,
    required this.authenticationStatus,
    required this.registrationStatus,
  });

  final int? userId;
  final AuthenticationStatus authenticationStatus;
  final RegistrationStatus registrationStatus;

  @override
  List<Object?> get props => [userId, authenticationStatus, registrationStatus];

  UserAuthenticationState copyWith({
    int? userId,
    AuthenticationStatus? authenticationStatus,
    RegistrationStatus? registrationStatus,
  }) {
    return UserAuthenticationState(
      userId: userId ?? this.userId,
      authenticationStatus: authenticationStatus ?? this.authenticationStatus,
      registrationStatus: registrationStatus ?? this.registrationStatus,
    );
  }
}
