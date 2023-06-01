import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:homework_todo/config/constants.dart';
import 'package:homework_todo/features/shared/widgets/custom_buitton_widget.dart';
import 'package:homework_todo/features/user_authentication/presentation/bloc/user_authentication_bloc.dart';

import 'package:homework_todo/features/user_authentication/presentation/widgets/custom_text_field.dart';

import '../../../../config/enums.dart';
import '../../../network_controller/bloc/network_bloc.dart';

class UserAuthenticationView extends StatelessWidget {
  const UserAuthenticationView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController loginController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: background,
      body: SingleChildScrollView(
        child: SafeArea(
          child: BlocBuilder<NetworkBloc, NetworkState>(
            builder: (context, networkState) {
              return BlocConsumer<UserAuthenticationBloc, UserAuthenticationState>(
                listener: (context, state) async {
                  if (state.authenticationStatus == AuthenticationStatus.authenticated) {
                    context.go('/todoList');
                  }
                  if (networkState.networkStatus == NetworkStatus.disconnected && state.userId != null) {
                    context.go('/todoList');
                  }
                  if (state.authenticationStatus == AuthenticationStatus.connectionError) {
                    scaffoldMessenger(context: context, message: 'Failed to connect to the server');
                  }
                  if (state.authenticationStatus == AuthenticationStatus.authenticationFaild) {
                    scaffoldMessenger(context: context, message: 'Wrong username or password');
                  }
                  if (state.authenticationStatus == AuthenticationStatus.completeTheData) {
                    scaffoldMessenger(context: context, message: 'Complete the data!');
                  }
                },
                builder: (context, state) {
                  return state.authenticationStatus == AuthenticationStatus.userVerification
                      ? const Center(child: CircularProgressIndicator())
                      : Container(
                          height: MediaQuery.of(context).size.height - 100,
                          margin: EdgeInsets.symmetric(
                            horizontal: 30.w,
                            vertical: 30.h,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Image.asset(
                                  'assets/images/logo.png',
                                  width: 200.w,
                                  height: 200.h,
                                ),
                              ),
                              Gap(55.h),
                              Padding(
                                padding: EdgeInsets.only(left: 5.w),
                                child: Text(
                                  'Login panel',
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                              Gap(10.h),
                              CustomTextField(
                                textController: loginController,
                                obscureText: false,
                                hint: 'type login',
                              ),
                              Gap(10.h),
                              CustomTextField(
                                textController: passwordController,
                                obscureText: true,
                                hint: 'type password',
                              ),
                              Gap(20.h),
                              CustomButtonWidget(
                                text: 'Login',
                                color: blue,
                                onPressed: () => context.read<UserAuthenticationBloc>().add(LoginUserEvent(
                                      login: loginController.text,
                                      password: passwordController.text,
                                    )),
                              ),
                              Gap(10.h),
                              CustomButtonWidget(onPressed: () => context.push('/register'), text: 'Register', color: black),
                            ],
                          ),
                        );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void scaffoldMessenger({required BuildContext context, required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: red,
      behavior: SnackBarBehavior.floating,
      content: Container(
        margin: EdgeInsets.symmetric(vertical: 5.h), // Set custom margin
        child: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: white),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Set custom border radius
      ),
      duration: const Duration(seconds: 1),
    ));
  }
}
