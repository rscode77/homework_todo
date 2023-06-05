import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:homework_todo/features/shared/widgets/custom_buitton_widget.dart';
import 'package:homework_todo/features/todo_list/presentation/bloc/todo_list_bloc.dart';

import '../../../../config/constants.dart';

import '../../../../config/enums.dart';
import '../../../network_controller/bloc/network_bloc.dart';
import '../../../user_authentication/presentation/pages/bloc/user_authentication/user_authentication_bloc.dart';

class DataSourceAlertWidget extends StatelessWidget {
  const DataSourceAlertWidget({Key? key}) : super(key: key);

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
                const Center(
                  child: Icon(
                    Icons.wifi_off_rounded,
                    size: 60,
                  ),
                ),
                Gap(20.h),
                Text(
                  'Connection failed',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(color: black),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 40),
                  child: Text(
                    'Check your internet connection to load content from remote server.',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(color: textGray),
                  ),
                ),
                Gap(30.h),
                BlocBuilder<NetworkBloc, NetworkState>(
                  builder: (context, networkState) {
                    return BlocBuilder<UserAuthenticationBloc, UserAuthenticationState>(
                      builder: (context, authenticationState) {
                        return Column(
                          children: [
                            CustomButtonWidget(
                              onPressed: () {
                                if (networkState.networkStatus == NetworkStatus.connected && authenticationState is UserAuthenticationSuccess) {
                                  context.read<TodoListBloc>().add(LoadRemoteTodoListEvent(userId: authenticationState.userId));
                                  Navigator.pop(context);
                                }
                              },
                              text: 'Try again',
                              color: blue,
                            ),
                            Gap(10.h),
                            CustomButtonWidget(
                              onPressed: () {
                                Navigator.pop(context);
                                context.read<TodoListBloc>().add(LoadLocalTodoListEvent());
                              },
                              text: 'Load local data',
                              color: black,
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
