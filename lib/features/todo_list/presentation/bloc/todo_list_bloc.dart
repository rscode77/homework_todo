import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:homework_todo/config/enums.dart';
import 'package:homework_todo/features/todo_list/data/models/task_model.dart';

part 'todo_list_event.dart';
part 'todo_list_state.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  TodoListBloc() : super(TodoListState(taskList: const [], selectedDate: DateTime.now())) {
    on<TodoListEvent>(_loadTaskList);
    on<ChangeCalendarDateEvent>(_changeCalendarDate);
  }

  _loadTaskList(TodoListEvent event, Emitter<TodoListState> emit) {
    emit(state.copyWith(taskList: json.map((e) => TaskModel.fromJson(e)).toList()));
  }

  _changeCalendarDate(ChangeCalendarDateEvent event, Emitter<TodoListState> emit) {
    emit(state.copyWith(selectedDate: event.selectedDate));
  }
}

var json = [
  {"id": 0, "title": "b48284d6-e3ca-47c5-a815-d1c832e5f5e3", "isDone": true, "description": "4c35c44a-b676-44ea-af86-43368f285ec6", "date": "2023-01-01"},
  {"id": 1, "title": "ab77e766-d12b-4325-b105-e0fc0359da9a", "isDone": false, "description": "a686b069-dd34-4a01-be39-8f203f94cdf9", "date": "2023-01-02"},
  {"id": 2, "title": "e982524a-48e8-4605-83a9-5bb666a4682d", "isDone": false, "description": "b788e125-156f-4e53-923b-ce80c0c49c11", "date": "2023-01-03"},
  {"id": 3, "title": "0a150861-b2f8-4a48-a0ff-99df06737fd0", "isDone": true, "description": "6d723fe4-de92-4086-a0ac-d89142cf40b8", "date": "2023-01-03"},
  {"id": 4, "title": "80119a39-bf63-4974-83a4-989c8a173fd8", "isDone": false, "description": "a68fa756-fd11-4c0b-b7eb-fbecbb72bcc5", "date": "2023-01-03"}
];
