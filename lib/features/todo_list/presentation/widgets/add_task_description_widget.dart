import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../config/constants.dart';

class AddTaskDescriptionWidget extends StatefulWidget {
  const AddTaskDescriptionWidget({
    Key? key,
    required this.taskDescriptionController,
    required this.readOnly,
  }) : super(key: key);

  final TextEditingController taskDescriptionController;
  final bool readOnly;

  @override
  State<AddTaskDescriptionWidget> createState() => _AddTaskDescriptionWidgetState();
}

class _AddTaskDescriptionWidgetState extends State<AddTaskDescriptionWidget> {
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
                    : widget.taskDescriptionController.text.isNotEmpty
                        ? blue
                        : Colors.red,
              ),
              child: Center(
                child: Text('2', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white)),
              ),
            ),
            Gap(15.w),
            Text(
              'Description',
              style: Theme.of(context).textTheme.labelLarge,
            )
          ],
        ),
        Gap(10.h),
        Container(
          height: 80.h,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: lightGray.withOpacity(0.8), width: 4),
            color: white,
          ),
          width: double.infinity,
          child: TextField(
            readOnly: widget.readOnly,
            onSubmitted: (value) {
              setState(() {
                widget.taskDescriptionController.text = value;
              });
            },
            cursorColor: blue,
            style: Theme.of(context).textTheme.bodySmall,
            controller: widget.taskDescriptionController,
            keyboardType: TextInputType.text,
            maxLines: null,
            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: 'enter task description',
              hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: gray),
            ),
          ),
        ),
      ],
    );
  }
}
