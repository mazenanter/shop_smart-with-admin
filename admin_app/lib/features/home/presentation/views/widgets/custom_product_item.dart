import 'package:admin_app/features/home/presentation/views/widgets/custom_product_details.dart';
import 'package:admin_app/features/home/presentation/views/widgets/custom_product_image.dart';
import 'package:flutter/material.dart';

class CustomProductItem extends StatelessWidget {
  const CustomProductItem({
    super.key,
    required this.productImage,
    required this.productTitle,
    required this.productPrice,
    this.onPressItem,
  });
  final String productImage;
  final String productTitle;
  final String productPrice;
  final void Function()? onPressItem;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onPressItem,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomProductImage(
              productImage: productImage,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomProductDetails(
              productPrice: productPrice,
              productTitle: productTitle,
            ),
          ],
        ),
      ),
    );
  }
}
