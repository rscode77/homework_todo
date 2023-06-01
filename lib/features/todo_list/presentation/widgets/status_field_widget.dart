import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../config/constants.dart';
import '../../../../config/enums.dart';
import '../../data/models/task_model.dart';
import '../bloc/todo_list_bloc.dart';

class StatusFieldWidget extends StatelessWidget {
  final TaskStatus status;

  const StatusFieldWidget({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<TodoListBloc>().add(ChangeTaskFilterEvent(filter: status));
      },
      child: BlocBuilder<TodoListBloc, TodoListState>(
        builder: (context, todoListState) {
          bool active = isFilterActive(status, todoListState.filter);
          return Row(
            children: [
              Text(capitalizeFirstLetter(status.toString().split('.').last),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: active ? black : gray,
                      )),
              Gap(5.w),
              Container(
                height: 20.h,
                width: 28.w,
                decoration: BoxDecoration(
                  color: active ? blue : gray,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    taskQuntity(todoListState.taskList, status, todoListState.selectedDate).toString(),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: white, fontSize: 10.sp),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  int taskQuntity(List<TaskModel> taskList, TaskStatus status, DateTime date) {
    if (status == TaskStatus.all) {
      return taskList.where((element) => DateTime.parse(element.date) == date).length;
    }

    return taskList.where((element) => element.status == status.toString().split('.').last && DateTime.parse(element.date) == date).length;
  }

  bool isFilterActive(TaskStatus status, TaskStatus filter) {
    return status == filter;
  }

  String capitalizeFirstLetter(String string) {
    return string[0].toUpperCase() + string.substring(1);
  }
}
