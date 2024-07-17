import 'package:admin_app/core/widgets/sub_title_text.dart';
import 'package:admin_app/core/widgets/text_title.dart';
import 'package:flutter/material.dart';

class CustomProductDetails extends StatelessWidget {
  const CustomProductDetails({
    super.key,
    required this.productTitle,
    required this.productPrice,
  });
  final String productTitle;
  final String productPrice;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextTitle(
            label: productTitle,
            maxLines: 2,
          ),
          SubTitleText(
            label: '\$$productPrice',
            fontWeight: FontWeight.w600,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
