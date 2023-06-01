import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework_todo/features/todo_list/presentation/widgets/status_field_widget.dart';

import '../../../../config/constants.dart';
import '../../../../config/enums.dart';

class FilterListWidget extends StatelessWidget {
  const FilterListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      height: 55.h,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: lightGray.withOpacity(0.8), width: 4),
        boxShadow: [
          BoxShadow(
            color: gray.withOpacity(0.3),
            blurRadius: 6,
            spreadRadius: 0.3,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              StatusFieldWidget(status: TaskStatus.all),
              StatusFieldWidget(status: TaskStatus.pending),
              StatusFieldWidget(status: TaskStatus.active),
              StatusFieldWidget(status: TaskStatus.completed),
            ],
          ),
        ],
      ),
    );
  }
}
