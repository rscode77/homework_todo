part of 'todo_list_bloc.dart';

class TodoListState extends Equatable {
  final bool isLoading;
  final List<TaskModel> taskList;
  final DateTime selectedDate;
  final TaskStatus selectedFilter;
  final String? errorMessage;

  const TodoListState({
    required this.taskList,
    required this.selectedDate,
    required this.selectedFilter,
    required this.isLoading,
    required this.errorMessage,
  });
  @override
  List<Object?> get props => [taskList, selectedDate, selectedFilter, isLoading, errorMessage];

  TodoListState copyWith({
    bool? isLoading,
    List<TaskModel>? taskList,
    DateTime? selectedDate,
    TaskStatus? selectedFilter,
    String? errorMessage,
  }) {
    return TodoListState(
      isLoading: isLoading ?? this.isLoading,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      taskList: taskList ?? this.taskList,
      errorMessage: errorMessage,
    );
  }
}
