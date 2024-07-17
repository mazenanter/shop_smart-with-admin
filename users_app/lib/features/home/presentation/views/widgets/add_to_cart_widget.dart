import 'package:ecommerce_app_firebase/core/widgets/text_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class AddToCartWidget extends StatelessWidget {
  const AddToCartWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.heartColor,
  });
  final String title;
  final IconData icon;
  final Color heartColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Material(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(32),
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              IconlyLight.heart,
              color: heartColor,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.7,
          child: ElevatedButton(
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                ),
                const SizedBox(
                  width: 10,
                ),
                TextTitle(
                  label: title,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
