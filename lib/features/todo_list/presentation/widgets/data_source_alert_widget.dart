import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:homework_todo/features/shared/widgets/custom_buitton_widget.dart';
import 'package:homework_todo/features/todo_list/presentation/bloc/todo_list_bloc.dart';

import '../../../../config/constants.dart';
import '../../../../config/enums.dart';
import '../../../network_controller/bloc/network_bloc.dart';
import '../../../user_authentication/presentation/bloc/user_authentication_bloc.dart';

class DataSourceAlertWidget extends StatefulWidget {
  const DataSourceAlertWidget({super.key});

  @override
  State<DataSourceAlertWidget> createState() => _DataSourceAlertWidget();
}

class _DataSourceAlertWidget extends State<DataSourceAlertWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: AlertDialog(
        elevation: 50,
        backgroundColor: background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        actions: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 20.h,
            ),
            width: MediaQuery.of(context).size.width / 1.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Unable to load  network data',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(color: black),
                ),
                Gap(40.h),
                BlocBuilder<NetworkBloc, NetworkState>(
                  builder: (context, state) {
                    return CustomButtonWidget(
                        onPressed: () {
                          if (state.networkStatus == NetworkStatus.connected) {
                            var userId = context.read<UserAuthenticationBloc>().state.userId;
                            context.read<TodoListBloc>().add(LoadRemoteTodoListEvent(userId: userId!));
                            Navigator.pop(context);
                          }
                        },
                        text: 'Try again',
                        color: blue);
                  },
                ),
                Gap(10.h),
                CustomButtonWidget(
                    onPressed: () {
                      Navigator.pop(context);
                      context.read<TodoListBloc>().add(LoadLocalTodoListEvent());
                    },
                    text: 'Load local data',
                    color: blue),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
