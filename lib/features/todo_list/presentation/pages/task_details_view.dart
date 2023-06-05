import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:homework_todo/features/todo_list/presentation/bloc/todo_list_bloc.dart';
import 'package:intl/intl.dart';

import 'package:homework_todo/features/todo_list/presentation/widgets/add_task_title_widget.dart';
import 'package:homework_todo/features/todo_list/presentation/widgets/set_privacy_widget.dart';

import '../../../../config/constants.dart';
import '../../../../config/enums.dart';
import '../../../network_controller/bloc/network_bloc.dart';
import '../../data/models/task_model.dart';
import '../widgets/add_task_description_widget.dart';
import '../../../shared/widgets/custom_buitton_widget.dart';

class TaskDetailsView extends StatefulWidget {
  final int taskId;
  const TaskDetailsView({
    Key? key,
    required this.taskId,
  }) : super(key: key);

  @override
  State<TaskDetailsView> createState() => _AddNewTaskViewState();
}

class _AddNewTaskViewState extends State<TaskDetailsView> {
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  TextEditingController taskStatusController = TextEditingController();

  @override
  void dispose() {
    taskTitleController.dispose();
    taskDescriptionController.dispose();
    taskStatusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: AlertDialog(
        insetPadding: EdgeInsets.zero,
        elevation: 100,
        backgroundColor: background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        actions: [
          BlocBuilder<NetworkBloc, NetworkState>(
            builder: (context, networkState) {
              return BlocBuilder<TodoListBloc, TodoListState>(
                builder: (context, state) {
                  TaskModel task = state.taskList.firstWhere((element) => element.id == widget.taskId);
                  taskTitleController.text = task.title;
                  taskDescriptionController.text = task.description;
                  return Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 20.h,
                    ),
                    width: MediaQuery.of(context).size.width / 1.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Task details',
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: black),
                        ),
                        Text(
                          DateFormat('EEEEE dd-MM-y').format(DateTime.parse(task.date)),
                          style: Theme.of(context).textTheme.displayMedium!.copyWith(color: textGray),
                        ),
                        Gap(20.h),
                        AddTaskTitleWidget(taskTitleController: taskTitleController, readOnly: true),
                        Gap(10.h),
                        AddTaskDescriptionWidget(
                          taskDescriptionController: taskDescriptionController,
                          readOnly: true,
                        ),
                        Gap(10.h),
                        SetPrivacyWidget(
                          taskPrivacyController: taskStatusController,
                          fieldValues: const ['Pending', 'Active', 'Completed'],
                          text: 'Task status',
                        ),
                        Gap(20.h),
                        networkState.networkStatus == NetworkStatus.connected
                            ? Column(
                                children: [
                                  CustomButtonWidget(
                                    color: blue,
                                    text: 'Update task status',
                                    onPressed: () {
                                      context.read<TodoListBloc>().add(UpdateTaskEvent(taskId: task.id, taskStatus: taskStatusController.text));
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              )
                            : Container(),
                        Gap(10.h),
                        CustomButtonWidget(onPressed: () => Navigator.pop(context), text: 'Close', color: black)
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
