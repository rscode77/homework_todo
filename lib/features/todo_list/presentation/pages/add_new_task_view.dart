import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:homework_todo/features/todo_list/presentation/bloc/todo_list_bloc.dart';
import 'package:homework_todo/features/todo_list/presentation/widgets/add_task_title_widget.dart';
import 'package:homework_todo/features/user_authentication/presentation/bloc/user_authentication_bloc.dart';
import 'package:intl/intl.dart';

import 'package:homework_todo/features/todo_list/presentation/widgets/set_privacy_widget.dart';

import '../../../../config/constants.dart';
import '../../data/models/task_model.dart';
import '../widgets/add_task_description_widget.dart';
import '../../../shared/widgets/custom_buitton_widget.dart';

class AddNewTaskView extends StatefulWidget {
  const AddNewTaskView({super.key});

  @override
  State<AddNewTaskView> createState() => _AddNewTaskViewState();
}

class _AddNewTaskViewState extends State<AddNewTaskView> {
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  TextEditingController taskPrivacyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      elevation: 100,
      backgroundColor: background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
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
                'Add new task',
                style: Theme.of(context).textTheme.displayLarge!.copyWith(color: black),
              ),
              Text(
                DateFormat('EEEEE d-M-y').format(DateTime.now()),
                style: Theme.of(context).textTheme.displayMedium!.copyWith(color: textGray),
              ),
              Gap(20.h),
              AddTaskTitleWidget(
                taskTitleController: taskTitleController,
                readOnly: false,
              ),
              Gap(10.h),
              AddTaskDescriptionWidget(
                taskDescriptionController: taskDescriptionController,
                readOnly: false,
              ),
              Gap(10.h),
              SetPrivacyWidget(
                taskPrivacyController: taskPrivacyController,
                fieldValues: const ['Personal', 'Group'],
                text: 'Set privacy status',
              ),
              Gap(20.h),
              CustomButtonWidget(
                color: blue,
                text: 'Add task',
                onPressed: () => _addNewTask(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _addNewTask() {
    if (taskTitleController.text.isEmpty || taskDescriptionController.text.isEmpty) return;
    context.read<TodoListBloc>().add(
          AddNewTaskEvent(
              task: TaskModel(
            id: 0,
            title: taskTitleController.text,
            description: taskDescriptionController.text,
            date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
            personal: taskPrivacyController.text == 'Personal' ? 'true' : 'false',
            status: 'pending',
            userId: context.read<UserAuthenticationBloc>().state.userId!,
          )),
        );
    Navigator.pop(context);
  }
}
