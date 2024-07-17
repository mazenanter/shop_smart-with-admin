import 'package:admin_app/core/widgets/sub_title_text.dart';
import 'package:admin_app/core/widgets/text_title.dart';
import 'package:flutter/material.dart';

class CustomCartItem extends StatelessWidget {
  const CustomCartItem({
    super.key,
    this.showQtyButton = true,
    this.showQtyTitle = false,
    this.showHeartIcon = true,
    required this.productImage,
    required this.productTitle,
    required this.productPrice,
    required this.productQty,
    required this.productId,
    required this.cartId,
  });
  final bool showQtyButton;
  final bool showQtyTitle;
  final bool showHeartIcon;
  final String productImage;
  final String productTitle;
  final String productPrice;
  final int productQty;
  final String productId;
  final String cartId;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: FittedBox(
        child: IntrinsicWidth(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
                child: Image(
                  height: MediaQuery.sizeOf(context).height * 0.2,
                  image: NetworkImage(
                    productImage,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.6,
                          child: TextTitle(
                            label: productTitle,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SubTitleText(
                          label: "$productPrice\$",
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                        const Spacer(),
                      ],
                    ),
                    Visibility(
                      visible: showQtyTitle,
                      child: SubTitleText(
                        label: 'Qty:$productQty',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              //const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
