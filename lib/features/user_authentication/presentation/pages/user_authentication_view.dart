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

class UserAuthenticationView extends StatefulWidget {
  const UserAuthenticationView({Key? key}) : super(key: key);

  @override
  State<UserAuthenticationView> createState() => _UserAuthenticationViewState();
}

class _UserAuthenticationViewState extends State<UserAuthenticationView> {
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
                builder: (context, userAuthenticationState) {
                  return userAuthenticationState.authenticationStatus == AuthenticationStatus.unAuthenticated
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height / 1.1,
                          child: Stack(
                            children: [
                              bgImage,
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
                                      'Login to your account',
                                      style: Theme.of(context).textTheme.displayLarge!.copyWith(color: black),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width / 1.45,
                                      child: Text(
                                        'A task manager is a software tool or application that helps individuals and teams organize.',
                                        style: Theme.of(context).textTheme.displayMedium!.copyWith(color: textGray, fontSize: 13.sp),
                                      ),
                                    ),
                                    Gap(25.h),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.w),
                                      child: Text(
                                        'Login panel',
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
                              ),
                            ],
                          ))
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            bgImage,
                            Gap(50.h),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 30.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Veryfying account',
                                    style: Theme.of(context).textTheme.displayLarge!.copyWith(color: black),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width / 1.45,
                                    child: Text(
                                      'Internet connection required, searching for user data...',
                                      style: Theme.of(context).textTheme.displayMedium!.copyWith(color: textGray, fontSize: 13.sp),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Gap(80.h),
                            BlocConsumer<NetworkBloc, NetworkState>(
                              listener: (context, state) {},
                              listenWhen: (previous, current) {
                                if (previous.networkStatus != current.networkStatus) {
                                  context.read<UserAuthenticationBloc>().add(const VerifyUserEvent());
                                }
                                return true;
                              },
                              builder: (context, networkState) {
                                return Center(
                                  child: networkState.networkStatus == NetworkStatus.disconnected && userAuthenticationState.userId == null
                                      ? Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                                          child: CustomButtonWidget(
                                            onPressed: () => context.read<UserAuthenticationBloc>().add(const VerifyUserEvent()),
                                            text: 'Retry',
                                            color: blue,
                                          ),
                                        )
                                      : SizedBox(
                                          height: 45,
                                          width: 45,
                                          child: CircularProgressIndicator(
                                            color: blue,
                                          ),
                                        ),
                                );
                              },
                            )
                          ],
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
    ));
  }
}
