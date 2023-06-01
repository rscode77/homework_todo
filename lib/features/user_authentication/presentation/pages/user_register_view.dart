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

class UserRegistrationView extends StatefulWidget {
  const UserRegistrationView({super.key});

  @override
  State<UserRegistrationView> createState() => _UserRegistrationViewState();
}

class _UserRegistrationViewState extends State<UserRegistrationView> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SingleChildScrollView(
        child: SafeArea(
          child: BlocListener<UserAuthenticationBloc, UserAuthenticationState>(
            listener: (context, state) {
              if (state.authenticationStatus == AuthenticationStatus.authenticated) {
                context.go('/todoList');
              }
              if (state.authenticationStatus == AuthenticationStatus.connectionError) {
                scaffoldMessenger(context: context, message: 'Failed to connect to the server');
              }
              if (state.authenticationStatus == AuthenticationStatus.userExists) {
                scaffoldMessenger(context: context, message: 'User with this name already exists');
              }
            },
            child: Container(
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
                      'Registration panel',
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
                    text: 'Create account',
                    color: blue,
                    onPressed: () => context.read<UserAuthenticationBloc>().add(RegisterUserEvent(
                          login: loginController.text,
                          password: passwordController.text,
                        )),
                  ),
                  Gap(10.h),
                  CustomButtonWidget(onPressed: () => Navigator.pop(context), text: 'Back', color: black),
                ],
              ),
            ),
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
