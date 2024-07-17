import 'package:ecommerce_app_firebase/core/widgets/sub_title_text.dart';
import 'package:flutter/material.dart';

class CustomCategoriesWidget extends StatelessWidget {
  const CustomCategoriesWidget({
    super.key,
    required this.image,
    required this.text,
    this.onTapCategory,
  });
  final String image;
  final String text;
  final void Function()? onTapCategory;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapCategory,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.asset(
              height: MediaQuery.sizeOf(context).height * 0.08,
              width: MediaQuery.sizeOf(context).height * 0.06,
              image,
            ),
            const SizedBox(
              height: 5,
            ),
            SubTitleText(
              label: text,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
