import 'package:flutter/material.dart';
import 'package:siakad_sma_al_fusha/themes/colors.dart';

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget({
    required this.text, 
    super.key,
    this.size = 12, 
    this.weight = FontWeight.w400, 
    this.color = kPrimaryTextColor,
    this.textAlign = TextAlign.start,
    this.isUsedMaxLines = true,
  });

  final String text;
  final double size;
  final FontWeight weight;
  final Color color;
  final TextAlign textAlign;
  final bool isUsedMaxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: isUsedMaxLines ? 3 : null,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: color,
        overflow: isUsedMaxLines ? TextOverflow.ellipsis : TextOverflow.visible,
      ),
    );
  }
}
