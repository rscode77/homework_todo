part of 'todo_list_bloc.dart';

class TodoListState extends Equatable {
  final List<TaskModel> taskList;
  final DateTime selectedDate;

  const TodoListState({
    required this.taskList,
    required this.selectedDate,
  });

  @override
  List<Object> get props => [taskList, selectedDate];

  TodoListState copyWith({
    List<TaskModel>? taskList,
    DateTime? selectedDate,
    TaskStatus? taskStatus,
  }) {
    return TodoListState(
      taskList: taskList ?? this.taskList,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}
