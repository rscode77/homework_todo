import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:homework_todo/config/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/repositories/user_repository_impl.dart';

part 'user_authentication_event.dart';
part 'user_authentication_state.dart';

class UserAuthenticationBloc extends Bloc<UserAuthenticationEvent, UserAuthenticationState> {
  UserAuthenticationBloc() : super(UserAuthenticationInitial()) {
    on<VerifyUserEvent>(_verifyUserEvent);
    on<LoginUserEvent>(_loginUserEvent);
  }

  _loginUserEvent(LoginUserEvent event, Emitter<UserAuthenticationState> emit) async {
    try {
      var user = await UserRepositoryImpl().loginUser(name: event.login, password: event.password);

      emit(UserAuthenticationCheck());
      await Future.delayed(const Duration(milliseconds: 500));

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('userId', user.id!);

      emit(UserAuthenticationSuccess(userId: user.id!));
    } on AuthenticationError catch (e) {
      emit(UserAuthenticationError(authenticationError: e.message));
    } finally {
      emit(UserUnauthenticated());
    }
  }

  _verifyUserEvent(VerifyUserEvent event, Emitter<UserAuthenticationState> emit) async {
    emit((UserAuthenticationCheck()));

    await Future.delayed(const Duration(milliseconds: 500));

    try {
      var user = await UserRepositoryImpl().verifyUser();

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('userId', user.id!);

      emit(UserAuthenticationSuccess(userId: user.id!));
    } on AuthenticationError {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      int? userId = prefs.getInt('userId');
      if (userId != null) {
        emit(UserAuthenticationSuccess(userId: userId));
      }
    } on UserAuthenticationError catch (e) {
      emit(UserAuthenticationError(authenticationError: e.authenticationError));
    } finally {
      await Future.delayed(Duration.zero);
      emit(UserUnauthenticated());
    }
  }
}
