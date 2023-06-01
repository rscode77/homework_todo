import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../config/constants.dart';

class SetPrivacyWidget extends StatefulWidget {
  final String text;
  final TextEditingController taskPrivacyController;
  final List<String> fieldValues;
  const SetPrivacyWidget({
    Key? key,
    required this.text,
    required this.taskPrivacyController,
    required this.fieldValues,
  }) : super(key: key);

  @override
  State<SetPrivacyWidget> createState() => _SetPrivacyWidgetState();
}

class _SetPrivacyWidgetState extends State<SetPrivacyWidget> {
  @override
  void initState() {
    super.initState();
    widget.taskPrivacyController.text = widget.fieldValues[0];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: 25.h,
              width: 25.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: blue,
              ),
              child: Center(
                child: Text('3', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white)),
              ),
            ),
            Gap(15.w),
            Text(
              widget.text,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
        Gap(10.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: lightGray.withOpacity(0.8), width: 4),
            color: white,
          ),
          child: DropdownButton<String>(
            borderRadius: BorderRadius.circular(20),
            isExpanded: true,
            value: widget.taskPrivacyController.text,
            icon: Icon(
              Icons.arrow_circle_down_rounded,
              color: gray,
            ),
            elevation: 16,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black),
            underline: Container(height: 0),
            onChanged: (String? value) {
              setState(() {
                widget.taskPrivacyController.text = value!;
              });
            },
            items: widget.fieldValues.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
