import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../config/constants.dart';
import '../../../../config/enums.dart';

class VeryfyingAccountWidget extends StatelessWidget {
  final NetworkStatus networkStatus;

  const VeryfyingAccountWidget({
    Key? key,
    required this.networkStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(50.h),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(networkStatus == NetworkStatus.disconnected ? 'Connect to internet' : 'Veryfying account',
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(color: black)),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.45,
                child: Text(
                  networkStatus == NetworkStatus.disconnected
                      ? 'Local user data not found, internet connection required...'
                      : 'Please wait, searching for user data...',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(color: textGray, fontSize: 13.sp),
                ),
              ),
            ],
          ),
        ),
        Gap(40.h),
        Center(
          child: networkStatus == NetworkStatus.disconnected
              ? const Icon(
                  Icons.wifi_off_rounded,
                  size: 100,
                )
              : SizedBox(
                  height: 45,
                  width: 45,
                  child: CircularProgressIndicator(
                    color: blue,
                    strokeWidth: 3,
                  ),
                ),
        ),
      ],
    );
  }
}
