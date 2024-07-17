import 'package:ecommerce_app_firebase/core/widgets/sub_title_text.dart';
import 'package:ecommerce_app_firebase/core/widgets/text_title.dart';
import 'package:ecommerce_app_firebase/features/home/presentation/views/widgets/add_to_cart_widget.dart';
import 'package:ecommerce_app_firebase/features/home/presentation/views/widgets/custom_title_and_price_widget.dart';
import 'package:ecommerce_app_firebase/features/search/data/models/product_model.dart';
import 'package:flutter/material.dart';

class DetailsViewBody extends StatelessWidget {
  const DetailsViewBody(
      {super.key,
      required this.productModel,
      required this.inCart,
      required this.inWishlist});
  final ProductModel productModel;
  final bool inCart;
  final bool inWishlist;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Image(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height * 0.40,
              image: NetworkImage(
                productModel.productImage,
              ),
            ),
          ),
          CustomTitleAndPriceWidget(
            prodTitle: productModel.productTitle,
            prodPrice: productModel.productPrice,
          ),
          const SizedBox(
            height: 5,
          ),
          AddToCartWidget(
            heartColor: inWishlist ? Colors.red : Colors.black,
            icon: inCart ? Icons.done_all : Icons.add_shopping_cart_outlined,
            title: inCart ? 'In cart' : 'Add to cart',
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const TextTitle(
                  label: 'About this item',
                  fontSize: 18,
                ),
                const Spacer(),
                SubTitleText(
                  label: 'In ${productModel.productCategory}',
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SubTitleText(
              label: productModel.productDescription,
            ),
          ),
        ],
      ),
    );
  }
}
