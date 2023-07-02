import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:siakad_sma_al_fusha/features/student/announcement_student/views/bloc/announcement_bloc.dart';
import 'package:siakad_sma_al_fusha/injection_container.dart';
import 'package:siakad_sma_al_fusha/themes/colors.dart';
import 'package:siakad_sma_al_fusha/widgets/custom_loading_widget.dart';
import 'package:siakad_sma_al_fusha/widgets/error_widget.dart';
import 'package:siakad_sma_al_fusha/widgets/text_widget.dart';

class AnnouncementView extends StatelessWidget {
  const AnnouncementView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AnnouncementBloc>()..add(GetAnnouncementEvent()),
      child: const AnnouncementPage(),
    );
  }
}

class AnnouncementPage extends StatelessWidget {
  const AnnouncementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AnnouncementBloc, AnnouncementState>(
        builder: (context, state) {
          if(state is AnnouncementLoaded){
            return listViewAnnouncementWidget(state);
          } else if (state is AnnouncementFailed) {
            return CustomErrorWidget(message: state.errorModel.message!);
          } else {
            return const CustomLoadingWidget();
          }
        },
      )
    );
  }

  ListView listViewAnnouncementWidget(AnnouncementLoaded state) {
    return ListView.separated(
      padding: EdgeInsets.all(16.r),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            context.push(
              '/pengumuman_detail', 
              extra: state.announcement.data[index]
            );
          },
          child: Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: kPrimaryColor.withOpacity(.15), blurRadius: 10
                )
              ]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                  text: state.announcement.data[index].judul,
                  size: 14.sp,
                  weight: FontWeight.bold,
                ),
                SizedBox(
                  height: 2.h,
                ),
                CustomTextWidget(
                  text: state.announcement.data[index].isiPengumuman,
                  size: 12.sp,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (_, __) => SizedBox(
        height: 16.h,
      ),
      itemCount: state.announcement.data.length
    );
  }
}


