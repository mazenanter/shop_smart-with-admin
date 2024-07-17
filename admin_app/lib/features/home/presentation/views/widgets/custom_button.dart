import 'package:admin_app/core/widgets/text_title.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.icon,
    this.bgkColor = Colors.white,
    this.textColor = Colors.deepPurple,
    this.iconColor = Colors.deepPurple,
    this.onPressButton,
  });
  final String title;
  final IconData icon;
  final Color bgkColor;
  final Color textColor;
  final Color iconColor;
  final void Function()? onPressButton;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgkColor,
      ),
      icon: Icon(
        icon,
        color: iconColor,
      ),
      onPressed: onPressButton,
      label: TextTitle(
        label: title,
        color: textColor,
      ),
    );
  }
}
