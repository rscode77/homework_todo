part of 'todo_list_bloc.dart';

abstract class TodoListEvent extends Equatable {
  const TodoListEvent();

  @override
  List<Object> get props => [];
}

class LoadRemoteTodoListEvent extends TodoListEvent {
  final int userId;
  const LoadRemoteTodoListEvent({
    required this.userId,
  });

  @override
  List<Object> get props => [userId];
}

class LoadLocalTodoListEvent extends TodoListEvent {}

class ChangeCalendarDateEvent extends TodoListEvent {
  final DateTime selectedDate;

  const ChangeCalendarDateEvent({required this.selectedDate});

  @override
  List<Object> get props => [selectedDate];
}

class ChangeTaskFilterEvent extends TodoListEvent {
  final TaskStatus filter;

  const ChangeTaskFilterEvent({required this.filter});

  @override
  List<Object> get props => [filter];
}

class LoadingTasks extends TodoListEvent {}

class GroupTasksInCalendar extends TodoListEvent {}

class AddNewTaskEvent extends TodoListEvent {
  final TaskModel task;

  const AddNewTaskEvent({required this.task});

  @override
  List<Object> get props => [task];
}

class DeleteTaskEvent extends TodoListEvent {
  final int taskId;

  const DeleteTaskEvent({required this.taskId});

  @override
  List<Object> get props => [taskId];
}

class UpdateTaskEvent extends TodoListEvent {
  final int taskId;
  final String taskStatus;

  const UpdateTaskEvent({
    required this.taskId,
    required this.taskStatus,
  });

  @override
  List<Object> get props => [taskId, taskStatus];
}
