import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siakad_sma_al_fusha/widgets/text_widget.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key, required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/error.png',
              height: 256.r,
              width: 256.r,
            ),
            SizedBox(height: 16.h,),
            CustomTextWidget(
              text: message,
              size: 14.sp,
              weight: FontWeight.w500,
            )
          ],
        ),
      ),
    );
  }
}