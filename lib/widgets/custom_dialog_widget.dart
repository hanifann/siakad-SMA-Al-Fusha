import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siakad_sma_al_fusha/themes/colors.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({required this.errorValue, super.key, });

  final String errorValue;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.sp,
        ),
      ),
      titlePadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
      content: Text(
        errorValue,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
        ),
      ),
      actionsPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      actions: [
        TextButton(
          onPressed: ()=> Navigator.pop(context), 
          child: const Text('kembali'),
        )
      ],
    );
  }
}

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          CircularProgressIndicator.adaptive(
            valueColor: const AlwaysStoppedAnimation(kPrimaryColor),
            backgroundColor: 
              Platform.isAndroid ? Colors.white : kPrimaryColor,
          ),
          const SizedBox(height: 16),
          const Text(
            'Memuat . . .',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
