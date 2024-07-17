import 'package:ecommerce_app_firebase/core/widgets/sub_title_text.dart';
import 'package:ecommerce_app_firebase/core/widgets/text_title.dart';
import 'package:ecommerce_app_firebase/features/cart/presentation/views/widgets/custom_manage_remove_icon.dart';
import 'package:ecommerce_app_firebase/features/cart/presentation/views/widgets/custom_qty_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

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
                        Column(
                          children: [
                            CustomManageRemoveIcon(
                                cartId: cartId,
                                productImage: productImage,
                                productPrice: productPrice,
                                productTitle: productTitle,
                                productQty: productQty,
                                productId: productId),
                            Visibility(
                              visible: showHeartIcon,
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  IconlyLight.heart,
                                ),
                              ),
                            ),
                          ],
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
                        Visibility(
                            visible: showQtyButton,
                            child: CustomQuantityButton(
                              qty: productQty.toString(),
                            )),
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
