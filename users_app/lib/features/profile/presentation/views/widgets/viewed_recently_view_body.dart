import 'package:ecommerce_app_firebase/core/widgets/cusom_product_item.dart';
import 'package:ecommerce_app_firebase/core/widgets/empty_bag_widget.dart';
import 'package:ecommerce_app_firebase/features/home/presentation/views/widgets/custom_details_app_bar.dart';
import 'package:ecommerce_app_firebase/features/search/data/models/product_model.dart';
import 'package:flutter/material.dart';

class ViewedRecentlyViewBody extends StatelessWidget {
  const ViewedRecentlyViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return 1 == 1
        ? const Scaffold(
            body: EmptyBagWidget(
              image: 'assets/images/bag/bag_wish.png',
              title: 'No viewed yet',
              subTitle: 'View any product to show here',
              buttonTitle: 'Show now',
            ),
          )
        : Scaffold(
            appBar: customDetailsAppBar(context, false, 'Seen Product'),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: 2,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3.9,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) => CustomProductItem(
                  isAddedToWishlist: false,
                  onAddToWishlist: (p0) {},
                  isAdded: false,
                  onAddToCart: (p0) {},
                  productId: '',
                  qty: 1,
                  productModel: ProductModel(
                      productId: '',
                      productTitle: '',
                      productPrice: '',
                      productCategory: '',
                      productDescription: '',
                      productImage: '',
                      productQty: ''),
                  productPrice: '',
                  productTitle: '',
                  productImage:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9eAqxljTteybiscbJymwvzUIgJKvl-zF6bw&usqp=CAU',
                ),
              ),
            ),
          );
  }
}
