import 'package:ecommerce_app_firebase/core/widgets/text_title.dart';
import 'package:flutter/material.dart';

class CustomProfileButton extends StatelessWidget {
  const CustomProfileButton({
    super.key,
    required this.sizeHeight,
    required this.onTap,
    required this.title,
    required this.icon,
  });

  final double sizeHeight;
  final void Function() onTap;
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: SizedBox(
          width: sizeHeight * 0.2,
          child: ElevatedButton(
            onPressed: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextTitle(
                  label: title,
                ),
                Icon(
                  icon,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
