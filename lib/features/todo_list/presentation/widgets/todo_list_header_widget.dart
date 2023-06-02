import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:homework_todo/config/constants.dart';
import 'package:homework_todo/config/enums.dart';
import 'package:homework_todo/features/todo_list/presentation/bloc/todo_list_bloc.dart';
import 'package:homework_todo/features/user_authentication/presentation/bloc/user_authentication_bloc.dart';
import 'package:intl/intl.dart';

import '../../../network_controller/bloc/network_bloc.dart';
import 'data_source_alert_widget.dart';

class TodoListHeaderWidget extends StatelessWidget {
  const TodoListHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.w),
      color: background,
      child: BlocBuilder<NetworkBloc, NetworkState>(
        builder: (context, networkState) {
          return Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Task manager',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    DateFormat('EEEEE dd-MM-y').format(DateTime.now()),
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(color: textGray, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                height: 50.h,
                width: 50.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: lightGray,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: white,
                    shape: BoxShape.circle,
                  ),
                  margin: const EdgeInsets.all(4),
                  child: Icon(
                    networkState.networkStatus == NetworkStatus.connected ? Icons.wifi_rounded : Icons.wifi_off_rounded,
                    color: black,
                    size: 20,
                  ),
                ),
              ),
              Gap(5.w),
              Container(
                height: 50.h,
                width: 50.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: lightGray,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: blue,
                    shape: BoxShape.circle,
                  ),
                  margin: const EdgeInsets.all(4),
                  child: ElevatedButton(
                    onPressed: () => networkState.networkStatus == NetworkStatus.disconnected
                        ? showDialog(
                            context: context,
                            builder: (context) {
                              return const DataSourceAlertWidget();
                            },
                          )
                        : context.read<TodoListBloc>().add(LoadRemoteTodoListEvent(
                              userId: context.read<UserAuthenticationBloc>().state.userId!,
                            )),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: EdgeInsets.zero,
                      shape: const CircleBorder(),
                      backgroundColor: blue,
                    ),
                    child: Icon(
                      Icons.refresh_rounded,
                      color: white,
                      size: 20,
                    ),
                  )
                      .animate(onPlay: (controller) => controller.repeat(reverse: true, period: const Duration(milliseconds: 2000)))
                      .shimmer(color: Colors.white24, delay: const Duration(milliseconds: 1000))
                      .shake(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
