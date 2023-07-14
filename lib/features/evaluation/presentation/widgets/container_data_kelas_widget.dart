import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/domain/entities/class.dart';
import 'package:siakad_sma_al_fusha/themes/colors.dart';
import 'package:siakad_sma_al_fusha/widgets/text_widget.dart';

class ContainerDataKelasWidget extends StatelessWidget {
  const ContainerDataKelasWidget({super.key, required this.classData});

  final ClassData classData;

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
              text: 'Kelas',
              size: 14.sp,
              weight: FontWeight.bold,
            ),
            CustomTextWidget(
              text: classData.nama,
              size: 14.sp,
              weight: FontWeight.bold,
            ),
          ],
        )
      ),
    );
  }
}