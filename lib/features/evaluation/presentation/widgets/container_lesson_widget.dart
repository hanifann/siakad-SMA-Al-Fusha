import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/domain/entities/lesson_code.dart';
import 'package:siakad_sma_al_fusha/themes/colors.dart';
import 'package:siakad_sma_al_fusha/widgets/text_widget.dart';

class ContainerLessonWidget extends StatelessWidget {
  const ContainerLessonWidget({
    super.key, 
    required this.lessonCodeData, 
  });

  final LessonCodeData lessonCodeData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 4.w),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: kPrimaryColor.withOpacity(.15),
            blurRadius: 15
          )
        ]
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 9.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8.r),
            bottomRight: Radius.circular(8.r)
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextWidget(
              text: lessonCodeData.nama,
              size: 14.sp,
              weight: FontWeight.bold,
            ),
            CustomTextWidget(
              text: lessonCodeData.namaGuru,
              size: 14.sp,
              weight: FontWeight.bold,
            ),
          ],
        )
      ),
    );
  }
}