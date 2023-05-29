part of 'todo_list_bloc.dart';

class TodoListState extends Equatable {
  final List<TaskModel> taskList;
  final List<DateTime> taskDates;

  const TodoListState({
    required this.taskList,
    required this.taskDates,
  });

  @override
  List<Object> get props => [taskList];

  TodoListState copyWith({
    List<TaskModel>? taskList,
    List<DateTime>? taskDates,
  }) {
    return TodoListState(
      taskList: taskList ?? this.taskList,
      taskDates: taskDates ?? this.taskDates,
    );
  }
}
