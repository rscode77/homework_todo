import 'package:go_router/go_router.dart';
import 'package:homework_todo/features/todo_list/presentation/pages/todo_list_view.dart';

final route = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const TodoListView(),
    ),
  ],
);
