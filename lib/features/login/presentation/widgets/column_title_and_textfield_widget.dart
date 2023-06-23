import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siakad_sma_al_fusha/widgets/text_widget.dart';

class ColumnTitleAndTextFieldWidget extends StatelessWidget {
  const ColumnTitleAndTextFieldWidget({
    required this.textfield, 
    required this.title,
    super.key,
  });

  final Widget textfield;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(
          text: title,
          weight: FontWeight.bold,
          size: 16.sp,
        ),
        textfield
      ],
    );
  }
}
