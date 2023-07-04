import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siakad_sma_al_fusha/features/score_student/domain/entities/nilai.dart';
import 'package:siakad_sma_al_fusha/themes/colors.dart';
import 'package:siakad_sma_al_fusha/widgets/text_widget.dart';

import 'row_title_and_text_widget.dart';

class ContainerNilaiWidget extends StatelessWidget {
  const ContainerNilaiWidget({
    super.key, 
    required this.isExpand, 
    required this.nilai, 
    required this.onIconTap
  });

  final bool isExpand;
  final NilaiDatum nilai;
  final VoidCallback onIconTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onIconTap,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: kPrimaryColor.withOpacity(.15),
              blurRadius: 15
            )
          ]
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: Container(
            padding: EdgeInsets.only(left: 4.w),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                left: BorderSide(
                  color: kPrimaryColor,
                  width: 6.w
                )
              ),
            ),
            child: Column(
              children: [
                containerHeader(),
                containerBody()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget containerBody() {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
      child: Container(
        color: Colors.white,
        width: 1.sw,
        child: !isExpand
            ? null
            : Padding(
              padding: EdgeInsets.fromLTRB(10.w, 0, 12.w, 9.h),
              child: columnDetailNilai(),
            )
      ),
    );
  }

  Column columnDetailNilai() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RowTitleAndText(
          title: 'Nilai PAT',
          text: nilai.pat,
        ),
        SizedBox(height: 4.h,),
        RowTitleAndText(
          title: 'Nilai PTS',
          text: nilai.pts,
        ),
        SizedBox(height: 4.h,),
        RowTitleAndText(
          title: 'Nilai RPH',
          text: nilai.rph,
        ),
        SizedBox(height: 4.h,),
        RowTitleAndText(
          title: 'Nilai Total',
          text: nilai.jumlah,
        ),
      ],
    );
  }

  Container containerHeader() {
    return Container(
      height: 60.h,
      padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 9.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(8.r),
          bottomRight: Radius.circular(isExpand ? 0 : 8.r)
        ),
      ),
      child: Row(
        children: [
          CustomTextWidget(
            text: nilai.nama,
            weight: FontWeight.w600,
            size: 14.sp,
          ),
          const Spacer(),
          CustomTextWidget(
            text: nilai.rataRata,
            weight: FontWeight.w600,
            size: 14.sp,
            color: const Color.fromRGBO(77, 138, 240, 1),
          ),
          SizedBox(width: 8.w,),
          GestureDetector(
            onTap: onIconTap,
            child: AnimatedRotation(
              turns: isExpand ? 1/2 : 0,
              duration: const Duration(milliseconds: 300),
              child: const Icon(Icons.expand_more)
            )
          )
        ],
      ),
    );
  }
}