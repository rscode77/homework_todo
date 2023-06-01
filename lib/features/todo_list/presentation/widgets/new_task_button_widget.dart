import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../config/constants.dart';

class NewTaskButtonWidget extends StatelessWidget {
  const NewTaskButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38.h,
      width: 120.h,
      decoration: BoxDecoration(
        color: lightBlue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add, color: blue, size: 20),
          Gap(6.w),
          Text(
            'New Task',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: blue,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}
