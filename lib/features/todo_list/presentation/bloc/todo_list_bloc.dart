import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:homework_todo/config/enums.dart';
import 'package:homework_todo/features/todo_list/data/datasources/database_helper.dart';
import 'package:homework_todo/features/todo_list/data/models/task_model.dart';
import 'package:homework_todo/features/todo_list/data/repositories/local_database_repository_impl.dart';
import 'package:homework_todo/features/todo_list/data/repositories/remote_database_repositoryt_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../config/exceptions.dart';

part 'todo_list_event.dart';
part 'todo_list_state.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  TodoListBloc()
      : super(TodoListState(selectedDate: DateTime.now(), selectedFilter: TaskStatus.all, taskList: const [], isLoading: false, errorMessage: null)) {
    on<LoadRemoteTodoListEvent>(_loadRemoteTaskList);
    on<LoadLocalTodoListEvent>(_loadLocalTaskList);
    on<ChangeCalendarDateEvent>(_changeCalendarDate);
    on<ChangeTaskFilterEvent>(_changeTaskFilter);
    on<AddNewTaskEvent>(_addNewTask);
    on<UpdateTaskEvent>(_updateTaskStatus);
  }

  _loadRemoteTaskList(LoadRemoteTodoListEvent event, Emitter<TodoListState> emit) async {
    emit(state.copyWith(isLoading: true));

    await Future.delayed(const Duration(seconds: 1));

    try {
      var tasks = await RemoteDatabaseRepositoryImpl().getAllTasks(userId: event.userId);

      await DatabaseHelper().initDatabase();
      await DatabaseHelper().clearTable();

      for (var task in tasks) {
        await DatabaseHelper().insertTask(task);
      }

      emit(state.copyWith(taskList: tasks, isLoading: false));
    } on TaskListError catch (e) {
      emit(state.copyWith(errorMessage: e.message));
    } finally {
      emit(state.copyWith(errorMessage: null, isLoading: false));
    }
  }

  _addNewTask(AddNewTaskEvent event, Emitter<TodoListState> emit) async {
    try {
      await RemoteDatabaseRepositoryImpl().addTask(task: event.task);
      await DatabaseHelper().insertTask(event.task);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      int? userId = prefs.getInt('userId');
      add(LoadRemoteTodoListEvent(userId: userId!));
    } on TaskListError catch (e) {
      emit(state.copyWith(errorMessage: e.message));
    } finally {
      emit(state.copyWith(errorMessage: null));
    }
  }

  _updateTaskStatus(UpdateTaskEvent event, Emitter<TodoListState> emit) async {
    try {
      await RemoteDatabaseRepositoryImpl().updateTaskStatus(status: event.taskStatus.toLowerCase(), taskId: event.taskId);
      await DatabaseHelper().updateTask(event.taskId, event.taskStatus);

      List<TaskModel> tasks = List.from(state.taskList);
      tasks.firstWhere((element) => element.id == event.taskId).status = event.taskStatus.toLowerCase();

      emit(state.copyWith(taskList: []));
      emit(state.copyWith(taskList: tasks));
    } on TaskListError catch (e) {
      emit(state.copyWith(errorMessage: e.message));
    } finally {
      emit(state.copyWith(errorMessage: null));
    }
  }

  _loadLocalTaskList(LoadLocalTodoListEvent event, Emitter<TodoListState> emit) async {
    emit(state.copyWith(isLoading: true));

    await Future.delayed(const Duration(seconds: 1));

    await DatabaseHelper().initDatabase();
    var tasks = await LocalDatabaseRepositoryImpl().getAllTasks();

    emit(state.copyWith(taskList: tasks, isLoading: false));
  }

  _changeCalendarDate(ChangeCalendarDateEvent event, Emitter<TodoListState> emit) {
    emit(state.copyWith(selectedDate: DateTime(event.selectedDate.year, event.selectedDate.month, event.selectedDate.day)));
  }

  _changeTaskFilter(ChangeTaskFilterEvent event, Emitter<TodoListState> emit) {
    emit(state.copyWith(selectedFilter: event.filter));
  }
}
