import 'package:go_router/go_router.dart';

import 'package:homework_todo/features/todo_list/presentation/pages/todo_list_view.dart';
import 'package:homework_todo/features/user_authentication/presentation/pages/user_authentication_view.dart';
import 'package:homework_todo/features/user_authentication/presentation/pages/user_register_view.dart';

final route = GoRouter(
  routes: [
    GoRoute(
      path: '/todoList',
      builder: (context, state) => const TodoListView(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const UserAuthenticationView(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const UserRegistrationView(),
    ),
  ],
);
