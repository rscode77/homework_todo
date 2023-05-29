import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:homework_todo/features/todo_list/presentation/bloc/todo_list_bloc.dart';

import '../widgets/calendar_list_widget.dart';
import '../widgets/todo_list_header_widget.dart';
import '../widgets/todo_list_widget.dart';

class TodoListView extends StatefulWidget {
  const TodoListView({super.key});

  @override
  State<TodoListView> createState() => _TodoListViewState();
}

class _TodoListViewState extends State<TodoListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Gap(30.h),
            const TodoListHeaderWidget(),
            Gap(20.h),
            BlocBuilder<TodoListBloc, TodoListState>(
              builder: (context, todoState) {
                return Column(
                  children: [
                    Gap(20.h),
                    const CalendarListWidget(),
                    TodoListWidget(
                      taskList: todoState.taskList,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
