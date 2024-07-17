import 'package:flutter/material.dart';

class SubTitleText extends StatelessWidget {
  const SubTitleText({
    super.key,
    required this.label,
    this.color,
    this.fontSize = 18,
    this.fontWeight = FontWeight.normal,
    this.textDecoration,
    this.fontStyle,
  });
  final String label;
  final Color? color;
  final double fontSize;
  final FontWeight fontWeight;
  final TextDecoration? textDecoration;
  final FontStyle? fontStyle;
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontStyle: fontStyle,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: textDecoration,
      ),
    );
  }
}
