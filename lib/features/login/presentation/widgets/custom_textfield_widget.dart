import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siakad_sma_al_fusha/themes/colors.dart';

class CustomTextfieldWidget extends StatelessWidget {
  const CustomTextfieldWidget({
    required this.controller, 
    required this.hint,
    this.suffixIcon,
    this.isObscure = false,
    this.onSuffixTap,
    this.isEnabled = true,
    super.key,
  });
  final TextEditingController controller;
  final String hint;
  final IconData? suffixIcon;
  final bool isObscure;
  final VoidCallback? onSuffixTap;
  final bool isEnabled;


  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: kPrimaryColor,
      obscureText: isObscure,
      enabled: isEnabled,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,
      ),
      decoration: InputDecoration(
        isDense: true,
        hintText: hint,
        suffixIcon: GestureDetector(
          onTap: onSuffixTap,
          child: Icon(
            suffixIcon,
            size: 24.w,
            color: kPrimaryTextColor,
          ),
        ),
        border: InputBorder.none,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: controller.text.isEmpty ? kPrimaryTextColor : kPrimaryColor,
            width: 2,
          ),
        ),
        disabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 2,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: kPrimaryColor,
            width: 2,
          ),
        ),
      ),
    );
  }
}
