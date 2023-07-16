import 'dart:developer';

import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:siakad_sma_al_fusha/features/schedule/data/models/day_model.dart';
import 'package:siakad_sma_al_fusha/features/schedule/domain/entities/schedule.dart';
import 'package:siakad_sma_al_fusha/features/schedule/presentation/bloc/schedule_bloc.dart';
import 'package:siakad_sma_al_fusha/features/schedule/presentation/widgets/container_day_widget.dart';
import 'package:siakad_sma_al_fusha/features/schedule/presentation/widgets/container_schedule_data_widget.dart';
import 'package:siakad_sma_al_fusha/injection_container.dart';
import 'package:siakad_sma_al_fusha/themes/colors.dart';
import 'package:siakad_sma_al_fusha/widgets/error_widget.dart';
import 'package:siakad_sma_al_fusha/widgets/text_widget.dart';

class ScheduleView extends StatelessWidget {
  const ScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ScheduleBloc>()..add(GetUserIdEvent()),
      child: const SchedulePage(),
    );
  }
}

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
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
          blocConsumeScheduleWidget()
        ],
      ),
    );
  }

  BlocConsumer<ScheduleBloc, ScheduleState> blocConsumeScheduleWidget() {
    return BlocConsumer<ScheduleBloc, ScheduleState>(
      listener: (context, state) {
        if(state is UserDataLoaded){
          if(state.user.data[0].role == '2'){
            context.read<ScheduleBloc>().add(
              GetScheduleEvent(
                id: state.user.data[0].idKelas!,
                day: day.where(
                  (element) => element.isSelected == true
                ).first.day.toLowerCase()
              )
            );
          } else {
            context.read<ScheduleBloc>().add(
              GetTeachingScheduleEvent(
                state.user.data[0].idUsers
              )
            );
          }
        }
      },
      builder: (context, state) {
        if(state is ScheduleLoaded){
          final tempDay = day.where((element) => element.isSelected == true).first.day.toLowerCase();
          final tempState = state.schedule.data.where((element) => element.hari == tempDay).toList();
          return scheduleLoadedWidget(tempState);
        } else if (state is ScheduleFailed){
          return CustomErrorWidget(message: state.error.message!);
        } else {
          return scheduleLoadingWidget();
        }
      },
    );
  }

  ListView scheduleLoadingWidget() {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.white,
          highlightColor: kPrimaryColor.withOpacity(.1),
          child: Container(
            height: 80.h,
            width: 1.sw,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: Colors.white
            ),
          ),
        );
      }, 
      separatorBuilder: (_,__) => SizedBox(height: 16.h,), 
      itemCount: 2
    );
  }

  ListView scheduleLoadedWidget(List<ScheduleData> state) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ContainerDataScheduleWidget(
          scheduleData: state[index],
        );
      }, 
      separatorBuilder: (_,__) => SizedBox(height: 16.h,), 
      itemCount: state.length
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
              context.read<ScheduleBloc>().add(GetUserIdEvent());
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
