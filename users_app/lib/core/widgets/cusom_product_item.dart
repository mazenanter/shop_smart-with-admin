import 'package:ecommerce_app_firebase/features/home/presentation/views/details_view.dart';
import 'package:ecommerce_app_firebase/features/search/data/models/product_model.dart';
import 'package:ecommerce_app_firebase/features/search/presentation/views/widgets/custom_search_image.dart';
import 'package:ecommerce_app_firebase/features/search/presentation/views/widgets/details_search_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomProductItem extends StatelessWidget {
  CustomProductItem({
    super.key,
    required this.productImage,
    required this.productTitle,
    required this.productPrice,
    this.productModel,
    this.onCartPress,
    required this.productId,
    required this.qty,
    required this.isAdded,
    required this.onAddToCart,
    required this.isAddedToWishlist,
    required this.onAddToWishlist,
    this.tapItem = true,
  });
  final String productImage;
  final String productTitle;
  final String productPrice;
  final String productId;
  final int qty;
  ProductModel? productModel;
  final Function()? onCartPress;
  final bool isAdded;
  final bool isAddedToWishlist;
  final void Function(String) onAddToCart;
  final void Function(String) onAddToWishlist;
  final bool tapItem;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: tapItem
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsView(
                    inWishlist: isAddedToWishlist,
                    inCart: isAdded,
                    productModel: productModel!,
                  ),
                ),
              );
            }
          : null,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSearchImage(
              productImage: productImage,
            ),
            const SizedBox(
              height: 10,
            ),
            DetailsSearchWidget(
              showIcons: tapItem,
              productImage: productImage,
              isAddedToWishlist: isAddedToWishlist,
              onAddToWishlist: onAddToWishlist,
              isAdded: isAdded,
              onAddToCart: onAddToCart,
              productId: productId,
              qty: qty,
              productTitle: productTitle,
              productPrice: productPrice,
            ),
          ],
        ),
      ),
    );
  }
}
