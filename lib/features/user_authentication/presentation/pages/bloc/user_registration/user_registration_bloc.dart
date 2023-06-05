import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:homework_todo/config/exceptions.dart';

import '../../../../data/repositories/user_repository_impl.dart';

part 'user_registration_event.dart';
part 'user_registration_state.dart';

class UserRegistrationBloc extends Bloc<UserRegistrationEvent, UserRegistrationState> {
  UserRegistrationBloc() : super(UserRegistrationInitial()) {
    on<RegisterUserEvent>(_registerUserEvent);
  }

  _registerUserEvent(RegisterUserEvent event, Emitter<UserRegistrationState> emit) async {
    try {
      emit(UserRegistrationAttempt());
      await Future.delayed(const Duration(seconds: 1));

      await UserRepositoryImpl().addNewUser(name: event.login, password: event.password);

      emit(UserRegistrationSuccess());
    } on RegistrationError catch (e) {
      emit(UserRegistrationError(message: e.message));
    } finally {
      emit(UserRegistrationInitial());
    }
  }
}
