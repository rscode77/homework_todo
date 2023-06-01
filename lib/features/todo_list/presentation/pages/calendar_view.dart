import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:homework_todo/config/constants.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      actions: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 20.h,
          ),
          decoration: BoxDecoration(
            color: white,
          ),
          width: double.infinity / 4,
          height: 350.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Icon(Icons.calendar_month),
                  Gap(10.w),
                  Text(
                    'All tasks',
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
