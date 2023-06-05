import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../config/constants.dart';

class AddTaskTitleWidget extends StatefulWidget {
  const AddTaskTitleWidget({
    Key? key,
    required this.taskTitleController,
    required this.readOnly,
  }) : super(key: key);

  final TextEditingController taskTitleController;
  final bool readOnly;

  @override
  State<AddTaskTitleWidget> createState() => _AddTaskTitleWidgetState();
}

class _AddTaskTitleWidgetState extends State<AddTaskTitleWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: 25.h,
              width: 25.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.readOnly
                    ? gray
                    : widget.taskTitleController.text.isNotEmpty
                        ? blue
                        : Colors.red,
              ),
              child: Center(
                child: Text('1', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: white)),
              ),
            ),
            Gap(15.w),
            Text(
              'Title',
              style: Theme.of(context).textTheme.labelLarge,
            )
          ],
        ),
        Gap(10.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: lightGray.withOpacity(0.8), width: 4),
            color: white,
          ),
          width: double.infinity,
          child: TextField(
            readOnly: widget.readOnly,
            cursorColor: Colors.blue,
            controller: widget.taskTitleController,
            keyboardType: TextInputType.text,
            maxLines: 1,
            style: Theme.of(context).textTheme.bodySmall,
            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: 'enter task title',
              hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: gray),
            ),
          ),
        ),
      ],
    );
  }
}
