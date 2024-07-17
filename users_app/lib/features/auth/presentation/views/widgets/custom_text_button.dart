import 'package:ecommerce_app_firebase/core/widgets/sub_title_text.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.text,
    this.textDecoration,
    this.fontStyle,
    this.onTap,
  });
  final String text;
  final TextDecoration? textDecoration;
  final FontStyle? fontStyle;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: SubTitleText(
        fontStyle: fontStyle,
        label: text,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        textDecoration: textDecoration,
      ),
    );
  }
}
