import 'package:ecommerce_app_firebase/features/home/presentation/views/widgets/custom_details_app_bar.dart';
import 'package:ecommerce_app_firebase/features/home/presentation/views/widgets/details_view_body.dart';
import 'package:ecommerce_app_firebase/features/search/data/models/product_model.dart';
import 'package:flutter/material.dart';

class DetailsView extends StatelessWidget {
  const DetailsView(
      {super.key,
      required this.productModel,
      required this.inCart,
      required this.inWishlist});
  final ProductModel productModel;
  final bool inCart;
  final bool inWishlist;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customDetailsAppBar(
        context,
        true,
        'ShopSmart',
      ),
      body: DetailsViewBody(
        inWishlist: inWishlist,
        inCart: inCart,
        productModel: productModel,
      ),
    );
  }
}
