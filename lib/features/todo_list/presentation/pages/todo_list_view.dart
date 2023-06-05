import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:homework_todo/config/constants.dart';

import '../../../../config/enums.dart';
import '../../../network_controller/bloc/network_bloc.dart';

import '../../../user_authentication/presentation/pages/bloc/user_authentication/user_authentication_bloc.dart';
import '../bloc/todo_list_bloc.dart';
import '../widgets/calendar_list_widget.dart';
import '../widgets/filter_list_widget.dart';

import '../widgets/todo_list_header_widget.dart';
import '../widgets/todo_list_widget.dart';

class TodoListView extends StatefulWidget {
  const TodoListView({super.key});

  @override
  State<TodoListView> createState() => _TodoListViewState();
}

class _TodoListViewState extends State<TodoListView> {
  @override
  void initState() {
    _checkDataSource();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: BlocListener<TodoListBloc, TodoListState>(
          listener: (context, state) {
            if (state.errorMessage != null) {
              return scaffoldMessenger(context: context, message: state.errorMessage!);
            }
          },
          child: Stack(
            children: [
              Column(
                children: [
                  Gap(30.h),
                  const TodoListHeaderWidget(),
                  Gap(25.h),
                  const CalendarListWidget(),
                  Gap(5.h),
                  const FilterListWidget(),
                  Gap(10.h),
                  const Expanded(child: TodoListWidget()),
                ],
              ),
              BlocBuilder<NetworkBloc, NetworkState>(
                builder: (context, state) {
                  return state.networkStatus == NetworkStatus.connected
                      ? Positioned(
                          bottom: 25,
                          right: 25,
                          child: FloatingActionButton(
                            backgroundColor: blue,
                            child: Icon(
                              Icons.add,
                              color: white,
                            ),
                            onPressed: () => context.push('/addNewTask'),
                          ),
                        )
                          .animate(onPlay: (controller) => controller.repeat(reverse: true, period: const Duration(milliseconds: 2500)))
                          .shimmer(color: Colors.white24, delay: const Duration(milliseconds: 1500))
                      : Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _checkDataSource() {
    var networkStatus = context.read<NetworkBloc>().state.networkStatus;
    var authenticationState = context.read<UserAuthenticationBloc>().state;

    if (networkStatus == NetworkStatus.connected && authenticationState is UserAuthenticationSuccess) {
      context.read<TodoListBloc>().add(LoadRemoteTodoListEvent(userId: authenticationState.userId));
    } else {
      context.read<TodoListBloc>().add(LoadLocalTodoListEvent());
    }
  }

  void scaffoldMessenger({required BuildContext context, required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: red,
        behavior: SnackBarBehavior.floating,
        content: Container(
          margin: EdgeInsets.symmetric(vertical: 5.h),
          child: Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: white),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
