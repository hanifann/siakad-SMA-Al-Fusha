import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:siakad_sma_al_fusha/features/schedule/domain/entities/schedule.dart';
import 'package:siakad_sma_al_fusha/themes/colors.dart';
import 'package:siakad_sma_al_fusha/widgets/text_widget.dart';

class ContainerDataScheduleWidget extends StatelessWidget {
  const ContainerDataScheduleWidget({
    super.key, 
    required this.scheduleData,
  });

  final ScheduleData scheduleData;

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
              text: scheduleData.mapel,
              size: 14.sp,
              weight: FontWeight.bold,
            ),
            CustomTextWidget(
              text: '${scheduleData.jam} - '
              '${DateFormat.Hms().format(totalJamPelajaran(scheduleData.jam))}',
              size: 12.sp,
            ),
            CustomTextWidget(
              text: scheduleData.guruPengampu,
              size: 12.sp,
            ),
            CustomTextWidget(
              text: scheduleData.kelas,
              size: 12.sp,
            ),
          ],
        )
      ),
    );
  }

  DateTime totalJamPelajaran(String jam){
    final tempJam = DateTime.parse('20120227T$jam').addHours(int.parse(scheduleData.jumlahJam));
    return tempJam;
  }
}