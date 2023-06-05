import 'package:flutter/material.dart';

import '../../../config/constants.dart';

class CustomProgressIndicator extends StatelessWidget {
  final double height;
  final double width;
  const CustomProgressIndicator({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Center(
        child: SizedBox(
          height: height,
          width: width,
          child: CircularProgressIndicator(
            color: blue,
            strokeWidth: 3,
          ),
        ),
      ),
    );
  }
}
