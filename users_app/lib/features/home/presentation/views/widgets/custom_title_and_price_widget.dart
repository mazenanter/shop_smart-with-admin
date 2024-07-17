import 'package:ecommerce_app_firebase/core/widgets/text_title.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widgets/sub_title_text.dart';

class CustomTitleAndPriceWidget extends StatelessWidget {
  const CustomTitleAndPriceWidget({
    super.key,
    required this.prodTitle,
    required this.prodPrice,
  });
  final String prodTitle, prodPrice;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextTitle(
              label: prodTitle,
              maxLines: 2,
            ),
          ),
          SubTitleText(
            label: '\$$prodPrice',
            fontWeight: FontWeight.w900,
            color: Colors.blue,
            fontSize: 20,
          ),
        ],
      ),
    );
  }
}
