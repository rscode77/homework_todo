import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:homework_todo/config/constants.dart';
import 'package:homework_todo/features/todo_list/presentation/pages/task_details_view.dart';
import 'package:homework_todo/features/todo_list/presentation/widgets/shadow_line_widget.dart';

import '../../../../config/enums.dart';
import '../../data/models/task_model.dart';
import '../bloc/todo_list_bloc.dart';

class TodoListWidget extends StatelessWidget {
  const TodoListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoListBloc, TodoListState>(
      builder: (context, state) {
        var filteredTasks = getTaskList(state.taskList, state.filter, state.selectedDate);
        return state.loading
            ? Center(
                child: SizedBox(
                height: 45,
                width: 45,
                child: CircularProgressIndicator(
                  color: blue,
                  strokeWidth: 3,
                ),
              ))
            : Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: ListView.builder(
                  itemCount: filteredTasks.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => TaskDetailsView(
                            taskId: filteredTasks[index].id,
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 120.h,
                            margin: EdgeInsets.only(top: 4.h, bottom: 8.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(color: lightGray.withOpacity(0.8), width: 4),
                              boxShadow: [
                                BoxShadow(
                                  color: gray.withOpacity(0.2),
                                  blurRadius: 6,
                                  spreadRadius: 0.3,
                                  offset: const Offset(0, 7),
                                )
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Gap(5.h),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 150.w,
                                            child: Text(
                                              filteredTasks[index].title,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                                                  color: black,
                                                  decoration: filteredTasks[index].status == 'completed' ? TextDecoration.lineThrough : null,
                                                  decorationThickness: 1),
                                            ),
                                          ),
                                          statusIcon(filteredTasks[index].status),
                                        ],
                                      ),
                                      Gap(5.h),
                                      SizedBox(
                                        width: 200.w,
                                        child: Text(
                                          filteredTasks[index].description,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                              color: textGray,
                                              decoration: filteredTasks[index].status == 'completed' ? TextDecoration.lineThrough : null,
                                              decorationThickness: 1,
                                              decorationColor: black),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Gap(10.h),
                                  const ShadowLineWidget(),
                                  Gap(10.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          taskStatus(filteredTasks, index),
                                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: black),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const Spacer(),
                                      Icon(filteredTasks[index].personal == 'false' ? Icons.group : Icons.person, color: black),
                                    ],
                                  ),
                                  Gap(10.h),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
      },
    );
  }

  String taskStatus(List<TaskModel> filteredTasks, int index) {
    var group = filteredTasks[index].personal == 'false' ? 'Group' : 'Personal';
    var status = filteredTasks[index].status;
    status = status[0].toUpperCase() + status.substring(1);
    return '$status | $group';
  }

  Icon statusIcon(String status) {
    switch (status) {
      case 'completed':
        return Icon(Icons.playlist_add_check_circle_rounded, color: blue);
      case 'pending':
        return Icon(Icons.circle_outlined, color: gray);
      case 'active':
        return Icon(Icons.flag_circle_rounded, color: blue);
      default:
        return Icon(Icons.circle_outlined, color: gray);
    }
  }

  List<TaskModel> getTaskList(List<TaskModel> taskList, TaskStatus status, DateTime date) {
    if (status == TaskStatus.all) {
      return taskList.where((element) => DateTime.parse(element.date) == date).toList();
    }
    return taskList.where((element) => element.status == status.toString().split('.').last && DateTime.parse(element.date) == date).toList();
  }
}
