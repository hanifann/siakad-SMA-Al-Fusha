import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siakad_sma_al_fusha/themes/colors.dart';
import 'package:siakad_sma_al_fusha/widgets/text_widget.dart';

class ContainerDayWidget extends StatelessWidget {
  const ContainerDayWidget({
    required this.day,
    required this.onTap, 
    this.isSelected = false,
    super.key,
  });

  final String day;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 7.w, vertical: 15.h,
        ),
        width: 64.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.transparent : kPrimaryColor,
          ),
          borderRadius: BorderRadius.circular(8.r),
          color: Colors.white,
          image: isSelected ? const DecorationImage(
            image: AssetImage('assets/images/day.png'),
            fit: BoxFit.cover,
          ) : null,
        ),
        child: CustomTextWidget(
          text: day,
          color: isSelected ? Colors.white : kPrimaryColor,
          weight: FontWeight.w600,
        ),
      ),
    );
  }
}
