import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siakad_sma_al_fusha/widgets/text_widget.dart';

class RowVisiMisiWidget extends StatelessWidget {
  const RowVisiMisiWidget({
    required this.title, 
    required this.isList, 
    this.value,
    this.list,
    super.key, 
  });

  final String title;
  final List<String>? list;
  final String? value;
  final bool isList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(
          text: '$title : ',
          size: 14.sp,
          weight: FontWeight.bold,
        ),
        if (isList) ListView.builder(
          itemBuilder: (context, index) {
            return CustomTextWidget(
              text: '${index+1}. ${list![index]}',
              textAlign: TextAlign.justify,
              size: 14.sp,
              weight: FontWeight.w500,
            );
          },
          itemCount: list!.length,
          shrinkWrap: true,
        ) else CustomTextWidget(
          text: value!,
          textAlign: TextAlign.justify,
          size: 14.sp,
          weight: FontWeight.w500,
        )
      ],
    );
  }
}
