import 'package:flutter/material.dart';

class TextTitle extends StatelessWidget {
  const TextTitle({
    super.key,
    required this.label,
    this.color,
    this.fontSize = 20,
    this.maxLines,
    this.fontWeight = FontWeight.bold,
  });
  final String label;
  final Color? color;
  final double fontSize;
  final int? maxLines;
  final FontWeight fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      maxLines: maxLines,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
