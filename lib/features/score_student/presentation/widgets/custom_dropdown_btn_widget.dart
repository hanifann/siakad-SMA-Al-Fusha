import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siakad_sma_al_fusha/themes/colors.dart';

class CustomDropdownBtnWidget extends StatelessWidget {
  const CustomDropdownBtnWidget({
    super.key, 
    required this.items, 
    required this.onChange,
    this.hint = '',
    this.value
  });
  final List<DropdownMenuItem<String>> items;
  final Function(String?) onChange;
  final String hint;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      items: items,
      onChanged: onChange,
      value: value,
      hint: Text(hint),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
        border: InputBorder.none,
        fillColor: Colors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: kPrimaryColor,
          ),
          borderRadius: BorderRadius.circular(10.r)
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: kPrimaryColor,
          ),
          borderRadius: BorderRadius.circular(10.r)
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: kPrimaryColor,
          ),
          borderRadius: BorderRadius.circular(10.r)
        ),
      ),
    );
  }
}