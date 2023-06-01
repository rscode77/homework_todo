// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_list_bloc.dart';

class TodoListState extends Equatable {
  final List<TaskModel> taskList;
  final DateTime selectedDate;
  final TaskStatus filter;
  final bool loading;
  final List<TaskModel> tasksInCalendar;
  final TaskOperationStatus taskOperationStatus;

  const TodoListState({
    required this.taskList,
    required this.selectedDate,
    required this.filter,
    required this.loading,
    required this.tasksInCalendar,
    required this.taskOperationStatus,
  });

  @override
  List<Object> get props => [taskList, selectedDate, filter, loading, tasksInCalendar];

  TodoListState copyWith({
    List<TaskModel>? taskList,
    DateTime? selectedDate,
    TaskStatus? filter,
    bool? loading,
    List<TaskModel>? tasksInCalendar,
    TaskOperationStatus? taskOperationStatus,
  }) {
    return TodoListState(
      taskList: taskList ?? this.taskList,
      selectedDate: selectedDate ?? this.selectedDate,
      filter: filter ?? this.filter,
      loading: loading ?? this.loading,
      tasksInCalendar: tasksInCalendar ?? this.tasksInCalendar,
      taskOperationStatus: taskOperationStatus ?? this.taskOperationStatus,
    );
  }
}
