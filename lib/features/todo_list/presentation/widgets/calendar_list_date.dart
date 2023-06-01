import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:homework_todo/features/todo_list/presentation/widgets/shadow_line_widget.dart';
import 'package:intl/intl.dart';

import '../../../../config/constants.dart';
import '../bloc/todo_list_bloc.dart';

class CalendarListDateWidget extends StatefulWidget {
  const CalendarListDateWidget({
    Key? key,
    required this.date,
    required this.selected,
  }) : super(key: key);

  final DateTime date;
  final bool selected;

  @override
  State<CalendarListDateWidget> createState() => _CalendarListDateWidgetState();
}

class _CalendarListDateWidgetState extends State<CalendarListDateWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var font = Theme.of(context).textTheme;
    return SizedBox(
      width: 70.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            DateFormat('EEE').format(widget.date),
            style: widget.selected
                ? font.bodyLarge!.copyWith(
                    color: blue,
                    fontWeight: FontWeight.w500,
                  )
                : font.bodyLarge!.copyWith(color: gray),
          ),
          Gap(10.h),
          const ShadowLineWidget(),
          Gap(7.h),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.selected ? blue : Colors.transparent,
            ),
            height: 30.h,
            width: 30.w,
            child: Center(
              child: Text(
                widget.date.day.toString(),
                style: widget.selected
                    ? font.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
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
