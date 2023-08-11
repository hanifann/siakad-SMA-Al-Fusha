import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/presentation/bloc/lesson_code_bloc.dart';
import 'package:siakad_sma_al_fusha/features/evaluation/presentation/widgets/container_lesson_widget.dart';
import 'package:siakad_sma_al_fusha/injection_container.dart';
import 'package:siakad_sma_al_fusha/themes/colors.dart';
import 'package:siakad_sma_al_fusha/widgets/error_widget.dart';

class LessonCodeView extends StatelessWidget {
  const LessonCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LessonCodeBloc>()..add(GetClassIdEvent()),
      child: const LessonCodePage(),
    );
  }
}

class LessonCodePage extends StatelessWidget {
  const LessonCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16.r),
        children: [
          BlocConsumer<LessonCodeBloc, LessonCodeState>(
            listener: (context, state) {
              if(state is LessonCodeClassIdLoaded){
                context.read<LessonCodeBloc>().add(GetLessonCodeEvent(state.classId));
              }
            },
            builder: (context, state) {
              if(state is LessonCodeLoaded){
                return mapelLoadedWidget(state);
              } else if (state is LessonCodeFailed){
                return CustomErrorWidget(message: state.error.message!);
              } else {
                return mapelLoadingWidget();
              }
            },
          )
        ],
      ),
    );
  }

  ListView mapelLoadingWidget() {
    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      padding: EdgeInsets.all(16.r),
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
      separatorBuilder: (_,__) => SizedBox(height: 12.h,), 
      itemCount: 5
    );
  }

  ListView mapelLoadedWidget(LessonCodeLoaded state) {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 12.sp),
      primary: false,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            context.pushNamed(
              '/student',
              queryParameters: {
                'kodeMapel': state.lessonCode.data[index].kode
              }
            );
          },
          child: ContainerLessonWidget(
            lessonCodeData: state.lessonCode.data[index]
          )
        );
      }, 
      separatorBuilder: (_,__)=> SizedBox(height: 16.sp,), 
      itemCount: state.lessonCode.data.length
    );
  }
}