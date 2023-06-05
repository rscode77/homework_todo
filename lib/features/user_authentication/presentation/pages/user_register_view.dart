import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:homework_todo/config/constants.dart';
import 'package:homework_todo/features/shared/widgets/custom_buitton_widget.dart';
import 'package:homework_todo/features/user_authentication/presentation/pages/bloc/user_registration/user_registration_bloc.dart';
import 'package:homework_todo/features/user_authentication/presentation/widgets/custom_text_field.dart';
import '../../../shared/widgets/custom_progress_indicator.dart';
import 'bloc/user_authentication/user_authentication_bloc.dart';

class UserRegistrationView extends StatefulWidget {
  const UserRegistrationView({super.key});

  @override
  State<UserRegistrationView> createState() => _UserRegistrationViewState();
}

class _UserRegistrationViewState extends State<UserRegistrationView> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late Image bgImage;

  @override
  void initState() {
    bgImage = Image.asset("assets/images/bg.png");
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(bgImage.image, context);
  }

  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: SafeArea(
              child: BlocConsumer<UserRegistrationBloc, UserRegistrationState>(
                listener: (context, state) {
                  if (state is UserRegistrationSuccess) {
                    context.read<UserAuthenticationBloc>().add(const VerifyUserEvent());
                  }
                  if (state is UserRegistrationError) {
                    scaffoldMessenger(context: context, message: state.message);
                  }
                },
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      bgImage,
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 30.w,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Gap(30.h),
                                Text(
                                  'Register new user',
                                  style: Theme.of(context).textTheme.displayLarge!.copyWith(color: black),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 1.1,
                                  child: Text(
                                    'New user will be added to the primary group, the administrator will assign you to the correct department.',
                                    style: Theme.of(context).textTheme.displayMedium!.copyWith(color: textGray, fontSize: 13.sp),
                                  ),
                                ),
                                Gap(25.h),
                                Padding(
                                  padding: EdgeInsets.only(left: 5.w),
                                  child: Text(
                                    'Registration panel',
                                    style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 16.sp),
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
                                // progress indicator when user is being registered
                                state is UserRegistrationAttempt || state is UserRegistrationSuccess
                                    ? const CustomProgressIndicator(
                                        height: 40,
                                        width: 40,
                                      )
                                    : CustomButtonWidget(
                                        text: 'Create account',
                                        color: blue,
                                        onPressed: () => context.read<UserRegistrationBloc>().add(RegisterUserEvent(
                                              login: loginController.text,
                                              password: passwordController.text,
                                            )),
                                      ),
                                Gap(10.h),
                                CustomButtonWidget(onPressed: () => Navigator.pop(context), text: 'Back', color: black),
                                Gap(40.h),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
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
