import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:homework_todo/features/todo_list/presentation/bloc/todo_list_bloc.dart';
import 'package:homework_todo/features/todo_list/presentation/widgets/add_task_title_widget.dart';
import 'package:homework_todo/features/todo_list/presentation/widgets/select_date_widget.dart';
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
  TextEditingController dateController = TextEditingController();

  @override
  void dispose() {
    taskTitleController.dispose();
    taskDescriptionController.dispose();
    taskPrivacyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height / 1.04,
          margin: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add new task',
                style: Theme.of(context).textTheme.displayLarge!.copyWith(color: black),
              ),
              Text(
                DateFormat('EEEEE dd-MM-y').format(DateTime.now()),
                style: Theme.of(context).textTheme.displayMedium!.copyWith(color: textGray),
              ),
              Gap(20.h),
              AddTaskTitleWidget(
                taskTitleController: taskTitleController,
                readOnly: false,
              ),
              Gap(15.h),
              AddTaskDescriptionWidget(
                taskDescriptionController: taskDescriptionController,
                readOnly: false,
              ),
              Gap(15.h),
              SelectDateWidget(dateController: dateController),
              Gap(15.h),
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
              Gap(10.h),
              CustomButtonWidget(
                color: black,
                text: 'Back',
                onPressed: () => Navigator.pop(context),
              ),
              Gap(40.h),
            ],
          ),
        ),
      ),
    );
  }

  _addNewTask() {
    String dateString = dateController.text.split(' ')[1];
    DateTime date = DateFormat('dd-MM-y').parse(dateString);
    String formattedDate = DateFormat('y-MM-dd').format(date);

    if (taskTitleController.text.isEmpty || taskDescriptionController.text.isEmpty) return;
    context.read<TodoListBloc>().add(
          AddNewTaskEvent(
              task: TaskModel(
            id: 0,
            title: taskTitleController.text,
            description: taskDescriptionController.text,
            date: formattedDate,
            personal: taskPrivacyController.text == 'Personal' ? 'true' : 'false',
            status: 'pending',
            userId: context.read<UserAuthenticationBloc>().state.userId!,
          )),
        );
    Navigator.pop(context);
  }
}
