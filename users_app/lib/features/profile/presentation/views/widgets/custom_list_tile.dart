import 'package:ecommerce_app_firebase/core/widgets/sub_title_text.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.sizeHeight,
    required this.image,
    required this.text,
    this.icon = Icons.arrow_forward_ios_outlined,
    this.onTap,
  });

  final double sizeHeight;
  final String image;
  final String text;
  final IconData icon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          leading: Image(
            height: sizeHeight * 0.05,
            image: AssetImage(
              image,
            ),
          ),
          title: SubTitleText(
            label: text,
            fontSize: 16,
          ),
          trailing: Icon(
            icon,
            size: 16,
          ),
        ),
      ),
    );
  }
}
