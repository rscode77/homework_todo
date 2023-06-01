import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homework_todo/config/constants.dart';
import 'package:homework_todo/features/network_controller/bloc/network_bloc.dart';
import 'package:homework_todo/features/todo_list/presentation/bloc/todo_list_bloc.dart';
import 'package:homework_todo/features/user_authentication/presentation/bloc/user_authentication_bloc.dart';

import 'config/routes.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: background,
    systemNavigationBarDividerColor: background,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392.72727272727275, 781.0909090909091),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => UserAuthenticationBloc()..add(const VerifyUserEvent()),
            ),
            BlocProvider(
              create: (context) => TodoListBloc(),
            ),
            BlocProvider(
              create: (context) => NetworkBloc()..add(NetworkObserve()),
            ),
          ],
          child: MaterialApp.router(
            title: 'Clean main',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: blue,
                selectionColor: blue.withOpacity(0.5),
                selectionHandleColor: blue,
              ),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              textTheme: TextTheme(
                displayLarge: GoogleFonts.roboto(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w600,
                  color: black,
                ),
                displayMedium: GoogleFonts.roboto(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  color: black,
                ),
                titleLarge: GoogleFonts.roboto(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w600,
                  color: black,
                ),
                titleMedium: GoogleFonts.roboto(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w400,
                  color: black,
                ),
                titleSmall: GoogleFonts.roboto(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: black,
                ),
                bodyLarge: GoogleFonts.roboto(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: black,
                ),
                bodySmall: GoogleFonts.roboto(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: black,
                ),
                headlineLarge: GoogleFonts.roboto(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: black,
                ),
                headlineMedium: GoogleFonts.roboto(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: black,
                ),
                headlineSmall: GoogleFonts.roboto(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: black,
                ),
                displaySmall: GoogleFonts.roboto(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: black,
                ),
              ),
            ),
            routerConfig: route,
          ),
        );
      },
    );
  }
}
