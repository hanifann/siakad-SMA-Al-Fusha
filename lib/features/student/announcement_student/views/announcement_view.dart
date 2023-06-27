import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:siakad_sma_al_fusha/themes/colors.dart';
import 'package:siakad_sma_al_fusha/widgets/text_widget.dart';

class AnnouncementView extends StatelessWidget {
  const AnnouncementView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AnnouncementPage();
  }
}

class AnnouncementPage extends StatelessWidget {
  const AnnouncementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        padding: EdgeInsets.all(16.r),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              context.push('/pengumuman_detail');
            },
            child: Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: kPrimaryColor.withOpacity(.15),
                    blurRadius: 10
                  )
                ]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextWidget(
                    text: 'Pelaksanaan UAS',
                    size: 14.sp,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(height: 2.h,),
                  CustomTextWidget(
                    text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book",
                    size: 12.sp,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          );
        }, 
        separatorBuilder: (_,__) => SizedBox(height: 16.h,), 
        itemCount: 5
      ),
    );
  }
}