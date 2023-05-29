import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../config/constants.dart';

class CalendarListDateWidget extends StatelessWidget {
  const CalendarListDateWidget({
    Key? key,
    required this.date,
    required this.selected,
  }) : super(key: key);

  final DateTime date;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    var font = Theme.of(context).textTheme;
    return SizedBox(
      width: 70.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            DateFormat('EEE').format(date),
            style: selected
                ? font.bodyLarge!.copyWith(
                    color: blue,
                    fontWeight: FontWeight.w800,
                  )
                : font.bodyLarge!.copyWith(color: gray),
          ),
          Gap(10.h),
          Container(
            color: lightGray,
            height: 0.8,
            width: double.infinity,
          ),
          Gap(7.h),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selected ? blue : Colors.transparent,
            ),
            height: 35.h,
            width: 35.w,
            child: Center(
              child: Text(
                date.day.toString(),
                style: selected
                    ? font.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      )
                    : font.bodyLarge,
              ),
            ),
          )
        ],
      ),
    );
  }
}
