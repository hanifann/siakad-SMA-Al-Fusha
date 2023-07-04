import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siakad_sma_al_fusha/widgets/text_widget.dart';

class RowTitleAndText extends StatelessWidget {
  const RowTitleAndText({
    super.key, required this.title, required this.text,
  });

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTextWidget(
          text: title,
          weight: FontWeight.w600,
          size: 14.sp,
        ),
        CustomTextWidget(
          text: text,
          weight: FontWeight.w600,
          size: 14.sp,
        ),
      ],
    );
  }
}