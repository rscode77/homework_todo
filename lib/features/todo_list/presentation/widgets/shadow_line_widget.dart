import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/constants.dart';

class ShadowLineWidget extends StatelessWidget {
  const ShadowLineWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1.h,
      decoration: BoxDecoration(
        color: lightGray,
      ),
    );
  }
}
