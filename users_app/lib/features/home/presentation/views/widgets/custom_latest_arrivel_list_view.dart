import 'package:ecommerce_app_firebase/core/widgets/text_title.dart';
import 'package:ecommerce_app_firebase/features/home/data/repos/home_repo_impl.dart';
import 'package:ecommerce_app_firebase/features/home/presentation/views/widgets/custom_card_latest_arrivel.dart';
import 'package:ecommerce_app_firebase/features/search/data/models/product_model.dart';
import 'package:flutter/material.dart';

class CustomLatestArrivelListView extends StatefulWidget {
  const CustomLatestArrivelListView({
    super.key,
  });

  @override
  State<CustomLatestArrivelListView> createState() =>
      _CustomLatestArrivelListViewState();
}

class _CustomLatestArrivelListViewState
    extends State<CustomLatestArrivelListView> {
  final Map<String, bool> addedToCart = {};
  final Map<String, bool> addedToWishlist = {};
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.22,
      child: StreamBuilder<List<ProductModel>>(
          stream: HomeRepoImpl().fetchLatestArrivelProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: TextTitle(
                  label: 'Loading...',
                  fontSize: 22,
                ),
              );
            } else if (snapshot.data == null) {
              return const Center(
                child: TextTitle(
                  label: 'No data found',
                ),
              );
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                final product = snapshot.data![index];
                final isAdded = addedToCart[product.productId] ?? false;
                final isAddedToWishlist =
                    addedToWishlist[product.productId] ?? false;
                return CustomCardLatestArrivel(
                  isAddedToWihslist: isAddedToWishlist,
                  onAddToWishlist: (productId) {
                    setState(() {
                      addedToWishlist[productId] = true;
                    });
                  },
                  isAdded: isAdded,
                  onAddToCart: (productId) {
                    setState(() {
                      addedToCart[productId] = true;
                    });
                  },
                  productId: snapshot.data![index].productId,
                  qty: 1,
                  productImage: snapshot.data![index].productImage,
                  productTitle: snapshot.data![index].productTitle,
                  productPrice: snapshot.data![index].productPrice,
                  productModel: snapshot.data![index],
                );
              },
              itemCount: snapshot.data!.length,
              scrollDirection: Axis.horizontal,
            );
          }),
    );
  }
}
