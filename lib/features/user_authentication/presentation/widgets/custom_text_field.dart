import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.textController,
    required this.obscureText,
    required this.hint,
  }) : super(key: key);

  final TextEditingController textController;
  final bool obscureText;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: lightGray.withOpacity(0.8), width: 4),
        color: white,
      ),
      width: double.infinity,
      child: TextField(
        obscureText: obscureText,
        controller: textController,
        keyboardType: TextInputType.text,
        maxLines: 1,
        style: Theme.of(context).textTheme.bodySmall,
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: hint,
          hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey),
        ),
      ),
    );
  }
}
