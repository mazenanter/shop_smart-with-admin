import 'package:ecommerce_app_firebase/core/error/error_dialog.dart';
import 'package:ecommerce_app_firebase/core/widgets/sub_title_text.dart';
import 'package:ecommerce_app_firebase/core/widgets/text_title.dart';
import 'package:ecommerce_app_firebase/features/home/presentation/views/details_view.dart';
import 'package:ecommerce_app_firebase/features/search/data/models/product_model.dart';
import 'package:ecommerce_app_firebase/features/search/presentation/manager/add_product_to_cart_cubit/add_product_to_cart_cubit.dart';
import 'package:ecommerce_app_firebase/features/search/presentation/manager/add_product_to_wishlist_cubit/add_product_to_wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomCardLatestArrivel extends StatelessWidget {
  const CustomCardLatestArrivel({
    super.key,
    required this.productImage,
    required this.productTitle,
    required this.productPrice,
    required this.productModel,
    required this.productId,
    required this.qty,
    required this.isAdded,
    required this.onAddToCart,
    required this.onAddToWishlist,
    required this.isAddedToWihslist,
  });
  final String productImage, productTitle, productPrice;
  final ProductModel productModel;
  final String productId;
  final int qty;
  final bool isAdded;
  final void Function(String) onAddToCart;
  final void Function(String p1) onAddToWishlist;
  final bool isAddedToWihslist;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddProductToCartCubit, AddProductToCartState>(
      listener: (context, state) {
        if (state is AddProductToCartSuccess && state.productId == productId) {
          Fluttertoast.showToast(
              msg: 'Item added to cart',
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 16.0);
          onAddToCart(productId);
        } else if (state is AddProductToCartError) {
          customErrorDialog(context, 'failed to add, try again later');
        }
      },
      builder: (context, state) {
        return InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsView(
                  inWishlist: isAddedToWihslist,
                  inCart: isAdded,
                  productModel: productModel,
                ),
              ),
            );
          },
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.6,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: AspectRatio(
                          aspectRatio: 2 / 3,
                          child: Image(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              productImage,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextTitle(
                            label: productTitle,
                            maxLines: 2,
                          ),
                          FittedBox(
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    BlocProvider.of<AddProductToCartCubit>(
                                            context)
                                        .addProductToCart(
                                      productImage: productImage,
                                      productTitle: productTitle,
                                      productPrice: productPrice,
                                      productId: productId,
                                      qty: qty,
                                    );
                                  },
                                  icon: Icon(
                                    isAdded
                                        ? Icons.done_all
                                        : Icons.add_shopping_cart,
                                  ),
                                ),
                                BlocConsumer<AddProductToWishlistCubit,
                                    AddProductToWishlistState>(
                                  listener: (context, state) {
                                    if (state is AddProductToWishlistSuccess &&
                                        state.productId == productId) {
                                      Fluttertoast.showToast(
                                          msg: 'Item added to wishlist',
                                          timeInSecForIosWeb: 1,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                      onAddToWishlist(productId);
                                    } else if (state
                                        is AddProductToWishlistError) {
                                      customErrorDialog(context,
                                          'failed to add, try again later');
                                    } else if (state is ItemRemoveState) {
                                      Fluttertoast.showToast(
                                          msg: 'Item removed',
                                          timeInSecForIosWeb: 1,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                  },
                                  builder: (context, state) {
                                    bool isInWishlist =
                                        state is AddProductToWishlistSuccess &&
                                                state.productId == productId ||
                                            isAddedToWihslist &&
                                                !(state is ItemRemoveState &&
                                                    state.productId ==
                                                        productId);
                                    bool isLoading =
                                        state is AddProductToWishlistLoading &&
                                            state.productId == productId;
                                    return isLoading
                                        ? const Center(
                                            child: CircularProgressIndicator())
                                        : IconButton(
                                            onPressed: () {
                                              if (isInWishlist) {
                                                BlocProvider.of<
                                                            AddProductToWishlistCubit>(
                                                        context)
                                                    .addProductToWishlist(
                                                        productTitle:
                                                            productTitle,
                                                        productPrice:
                                                            productPrice,
                                                        productImage:
                                                            productImage,
                                                        productId: productId);
                                              } else {
                                                BlocProvider.of<
                                                            AddProductToWishlistCubit>(
                                                        context)
                                                    .addProductToWishlist(
                                                        productTitle:
                                                            productTitle,
                                                        productPrice:
                                                            productPrice,
                                                        productImage:
                                                            productImage,
                                                        productId: productId);
                                              }
                                            },
                                            icon: Icon(
                                              IconlyLight.heart,
                                              color: isInWishlist
                                                  ? Colors.red
                                                  : Colors.black,
                                            ),
                                          );
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          FittedBox(
                            child: SubTitleText(
                              label: '\$$productPrice',
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
