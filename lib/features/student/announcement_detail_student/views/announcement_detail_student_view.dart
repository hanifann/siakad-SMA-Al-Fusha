import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siakad_sma_al_fusha/features/student/announcement_student/domain/entities/announcement.dart';
import 'package:siakad_sma_al_fusha/widgets/text_widget.dart';

class AnnouncementDetailStudentView extends StatelessWidget {
  const AnnouncementDetailStudentView({super.key, required this.announcement});

  final AnnouncementDatum announcement;

  @override
  Widget build(BuildContext context) {
    return AnnouncementDetailStudentPage(announcement: announcement,);
  }
}

class AnnouncementDetailStudentPage extends StatelessWidget {
  const AnnouncementDetailStudentPage({super.key, required this.announcement});

  final AnnouncementDatum announcement;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        elevation: 1,
        title: CustomTextWidget(
          text: 'Pengumuman',
          weight: FontWeight.bold,
          size: 24.sp,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.r),
        children: [
          CustomTextWidget(
            text: announcement.judul,
            weight: FontWeight.w600,
            size: 16.sp,
          ),
          SizedBox(height: 4.h,),
          CustomTextWidget(
            text: announcement.isiPengumuman,
            isUsedMaxLines: false,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}