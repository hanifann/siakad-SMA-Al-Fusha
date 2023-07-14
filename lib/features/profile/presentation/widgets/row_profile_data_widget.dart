import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siakad_sma_al_fusha/themes/colors.dart';
import 'package:siakad_sma_al_fusha/widgets/text_widget.dart';

class RowProfileDataWidget extends StatelessWidget {
  const RowProfileDataWidget({
    super.key, required this.title, required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CustomTextWidget(
            text: title,
            color: kSecondaryTextColor,
            size: 14.sp,
          ),
        ),
        Expanded(
          flex: 3,
          child: CustomTextWidget(
            text: value,
            size: 14.sp,
            weight: FontWeight.w600,
            textAlign: TextAlign.end,
          ),
        )
      ],
    );
  }
}