import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class TodoListHeaderWidget extends StatelessWidget {
  const TodoListHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          const Icon(Icons.info_outline_rounded),
          const Spacer(),
          Text(
            DateTime.now().day.toString(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Gap(8.w),
          Text(
            DateFormat('MMM').format(DateTime.now()),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Spacer(),
          const Icon(Icons.calendar_month_rounded),
        ],
      ),
    );
  }
}
