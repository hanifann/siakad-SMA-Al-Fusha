import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siakad_sma_al_fusha/widgets/text_widget.dart';

class AnnouncementDetailStudentView extends StatelessWidget {
  const AnnouncementDetailStudentView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AnnouncementDetailStudentPage();
  }
}

class AnnouncementDetailStudentPage extends StatelessWidget {
  const AnnouncementDetailStudentPage({super.key});

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
            text: 'Pelaksanaan UAS',
            weight: FontWeight.w600,
            size: 16.sp,
          ),
          SizedBox(height: 4.h,),
          const CustomTextWidget(
            text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
            isUsedMaxLines: false,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}