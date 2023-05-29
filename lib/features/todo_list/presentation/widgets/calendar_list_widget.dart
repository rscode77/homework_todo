import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework_todo/features/todo_list/presentation/bloc/todo_list_bloc.dart';

import 'calendar_list_date.dart';

class CalendarListWidget extends StatelessWidget {
  const CalendarListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dates = getTaskDates();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      height: 75.h,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 9,
        itemBuilder: (context, index) {
          return BlocBuilder<TodoListBloc, TodoListState>(
            builder: (context, todoListState) {
              return InkWell(
                onTap: () => context.read<TodoListBloc>().add(ChangeCalendarDateEvent(selectedDate: dates[index])),
                child: CalendarListDateWidget(
                  date: dates[index],
                  selected: compareDates(dates[index], todoListState.selectedDate),
                ),
              );
            },
          );
        },
      ),
    );
  }

  bool compareDates(DateTime date1, DateTime date2) {
    return DateTime(date1.year, date1.month, date1.day) == DateTime(date2.year, date2.month, date2.day);
  }

  List<DateTime> getTaskDates() {
    List<DateTime> taskDates = [];
    for (int i = -2; i < 7; i++) {
      taskDates.add(DateTime.now().add(Duration(days: i)));
    }
    return taskDates;
  }
}
