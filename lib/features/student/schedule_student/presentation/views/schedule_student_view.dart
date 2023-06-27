import 'dart:developer';

import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:siakad_sma_al_fusha/features/student/schedule_student/domain/models/day_model.dart';
import 'package:siakad_sma_al_fusha/features/student/schedule_student/presentation/widgets/container_day_widget.dart';
import 'package:siakad_sma_al_fusha/themes/colors.dart';
import 'package:siakad_sma_al_fusha/widgets/text_widget.dart';

class ScheduleStudentView extends StatelessWidget {
  const ScheduleStudentView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScheduleStudentPage();
  }
}

class ScheduleStudentPage extends StatefulWidget {
  const ScheduleStudentPage({super.key});

  @override
  State<ScheduleStudentPage> createState() => _ScheduleStudentPageState();
}

class _ScheduleStudentPageState extends State<ScheduleStudentPage> {
  List<DayModel> day = [
    DayModel(day: 'Senin'),
    DayModel(day: 'Selasa'),
    DayModel(day: 'Rabu'),
    DayModel(day: 'Kamis'),
    DayModel(day: 'Jumat'),
    DayModel(day: 'Sabtu'),
    DayModel(day: 'Minggu')
  ];

  @override
  void initState() {
    day.where(
      (element) => DateFormat('EEEE', 'id').format(DateTime.now()) 
        == element.day,
    ).map((e) => e.isSelected = true);
    log(day.where(
      (element) => DateFormat('EEEE', 'id').format(DateTime.now()) 
        == element.day,
    ).map((e) => e.isSelected = true).toString(),);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        children: [
          CustomTextWidget(
            text: DateFormat('MMMM yyyy', 'id').format(DateTime.now()),
            size: 18.sp,
            weight: FontWeight.bold,
          ),
          SizedBox(height: 4.h,),
          listViewHariWidget(),
          SizedBox(height: 16.h,),
          CustomTextWidget(
            text: day.where((element) => element.isSelected == true).first.day,
            weight: FontWeight.bold,
            size: 16.sp,
          ),
          SizedBox(height: 4.h,),
          CustomTextWidget(
            text: DateFormat.yMMMd('id').format(
              DateTime.now().startOfISOWeek.addDays(
                day.indexWhere((element) => element.isSelected == true),
              ),
            ),
            size: 14.sp,
            color: kSecondaryTextColor,
            weight: FontWeight.w500,
          ),
          SizedBox(height: 24.h,),
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
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
                          text: 'Matematika',
                          size: 14.sp,
                          weight: FontWeight.bold,
                        ),
                        // SizedBox(height: 10.h,),
                        CustomTextWidget(
                          text: '07.30 - 09.30',
                          size: 12.sp,
                        ),
                      ],
                    )
                  ),
                );
            }, 
            separatorBuilder: (_,__) => SizedBox(height: 16.h,), 
            itemCount: 2
          )
        ],
      ),
    );
  }

  Container listViewHariWidget() {
    return Container(
      height: 48.h,
      margin: EdgeInsets.symmetric(vertical: 2.r),
      child: ListView.separated(
        itemBuilder: (context, index) {
          return ContainerDayWidget(
            day: day[index].day,
            isSelected: day[index].isSelected,
            onTap: () {
              setState(() {
                for (final element in day) {
                  element.isSelected = false;
                }
                day[index].isSelected = true;
              });
            },
          );
        },
        separatorBuilder: (context, index) => SizedBox(width: 8.w,),
        scrollDirection: Axis.horizontal,
        itemCount: day.length,
      ),
    );
  }
}
