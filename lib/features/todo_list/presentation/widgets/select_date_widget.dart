import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:homework_todo/features/shared/widgets/custom_buitton_widget.dart';
import 'package:intl/intl.dart';

import '../../../../config/constants.dart';

class SelectDateWidget extends StatefulWidget {
  const SelectDateWidget({
    Key? key,
    required this.dateController,
  }) : super(key: key);

  final TextEditingController dateController;

  @override
  State<SelectDateWidget> createState() => _SelectDateWidgetState();
}

class _SelectDateWidgetState extends State<SelectDateWidget> {
  @override
  void initState() {
    widget.dateController.text = DateFormat('EEEEE dd-MM-y').format(DateTime.now());
    super.initState();
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
              decoration: BoxDecoration(shape: BoxShape.circle, color: blue),
              child: Center(
                child: Text('4', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white)),
              ),
            ),
            Gap(15.w),
            Text(
              'Select date',
              style: Theme.of(context).textTheme.labelLarge,
            )
          ],
        ),
        Gap(10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: lightGray.withOpacity(0.8), width: 4),
                  color: white,
                ),
                width: 200,
                child: TextField(
                  readOnly: true,
                  onSubmitted: (value) {
                    setState(() {
                      widget.dateController.text = value;
                    });
                  },
                  cursorColor: blue,
                  style: Theme.of(context).textTheme.bodySmall,
                  controller: widget.dateController,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: gray),
                  ),
                ),
              ),
            ),
            Gap(20.w),
            Expanded(
              flex: 2,
              child: CustomButtonWidget(
                onPressed: () => _selectDate(context),
                text: 'Change date',
                color: blue,
              ),
            )
          ],
        ),
      ],
    );
  }

  _selectDate(context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        useRootNavigator: false,
        lastDate: DateTime(DateTime.now().year + 1));

    if (picked != null) {
      setState(() {
        widget.dateController.text = DateFormat('EEEEE dd-MM-y').format(picked);
      });
    }
  }
}
