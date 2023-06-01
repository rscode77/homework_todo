import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:homework_todo/config/enums.dart';
import 'package:homework_todo/config/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repositories/user_repository_impl.dart';

part 'user_authentication_event.dart';
part 'user_authentication_state.dart';

class UserAuthenticationBloc extends Bloc<UserAuthenticationEvent, UserAuthenticationState> {
  UserAuthenticationBloc()
      : super(const UserAuthenticationState(
            userId: null, authenticationStatus: AuthenticationStatus.userVerification, registrationStatus: RegistrationStatus.none)) {
    on<VerifyUserEvent>(_verifyUserEvent);
    on<LoginUserEvent>(_loginUserEvent);
    on<RegisterUserEvent>(_registerUserEvent);
  }

  _registerUserEvent(RegisterUserEvent event, Emitter<UserAuthenticationState> emit) async {
    try {
      emit(state.copyWith(registrationStatus: RegistrationStatus.registering));
      var result = await UserRepositoryImpl().addNewUser(name: event.login, password: event.password);
      if (result.statusCode == 200) {
        add(const VerifyUserEvent());
      }
    } on UserExists {
      emit(state.copyWith(authenticationStatus: AuthenticationStatus.userExists));
    } on ConnectionFaild {
      emit(state.copyWith(authenticationStatus: AuthenticationStatus.connectionError));
    } on CompleteTheData {
      emit(state.copyWith(authenticationStatus: AuthenticationStatus.completeTheData));
    } finally {
      emit(state.copyWith(
        authenticationStatus: AuthenticationStatus.unAuthenticated,
        registrationStatus: RegistrationStatus.none,
      ));
    }
  }

  _loginUserEvent(LoginUserEvent event, Emitter<UserAuthenticationState> emit) async {
    try {
      var user = await UserRepositoryImpl().loginUser(name: event.login, password: event.password);
      emit(state.copyWith(userId: user.id));

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('userId', user.id!);

      emit(state.copyWith(authenticationStatus: AuthenticationStatus.authenticated));
    } on AuthenticationFaild {
      emit(state.copyWith(authenticationStatus: AuthenticationStatus.authenticationFaild));
    } on CompleteTheData {
      emit(state.copyWith(authenticationStatus: AuthenticationStatus.completeTheData));
    } on ConnectionFaild {
      emit(state.copyWith(authenticationStatus: AuthenticationStatus.connectionError));
    } finally {
      emit(state.copyWith(authenticationStatus: AuthenticationStatus.unAuthenticated));
    }
  }

  _verifyUserEvent(VerifyUserEvent event, Emitter<UserAuthenticationState> emit) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      var user = await UserRepositoryImpl().verifyUser();
      emit(state.copyWith(userId: user.id));

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('userId', user.id!);

      emit(state.copyWith(authenticationStatus: AuthenticationStatus.authenticated));
    } on ConnectionFaild {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      int? userId = prefs.getInt('userId');
      if (userId != null) {
        emit(state.copyWith(userId: userId, authenticationStatus: AuthenticationStatus.authenticated));
      }
    } on AuthenticationFaild {
      emit(state.copyWith(authenticationStatus: AuthenticationStatus.unAuthenticated));
    }
  }
}
