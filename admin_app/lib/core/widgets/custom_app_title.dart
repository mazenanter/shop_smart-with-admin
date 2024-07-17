import 'package:admin_app/core/widgets/text_title.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomAppTitle extends StatelessWidget {
  const CustomAppTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Shimmer.fromColors(
        period: const Duration(
          seconds: 4,
        ),
        baseColor: Colors.purple,
        highlightColor: Colors.red,
        child: const TextTitle(
          label: 'ShopSmart',
          fontSize: 24,
        ),
      ),
    );
  }
}
