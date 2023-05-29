import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/task_model.dart';

class TodoListWidget extends StatelessWidget {
  final List<TaskModel> taskList;
  const TodoListWidget({
    Key? key,
    required this.taskList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: taskList.length,
      itemBuilder: (context, index) {
        return Container(
          height: 70.h,
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    taskList[index].title,
                    style: const TextStyle(color: Colors.black),
                  ),
                  Text(
                    taskList[index].description,
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
