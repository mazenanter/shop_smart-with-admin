import 'dart:developer';

import 'package:ecommerce_app_firebase/core/error/error_dialog.dart';
import 'package:ecommerce_app_firebase/core/widgets/sub_title_text.dart';
import 'package:ecommerce_app_firebase/core/widgets/text_title.dart';
import 'package:ecommerce_app_firebase/features/search/presentation/manager/add_product_to_cart_cubit/add_product_to_cart_cubit.dart';
import 'package:ecommerce_app_firebase/features/search/presentation/manager/add_product_to_wishlist_cubit/add_product_to_wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DetailsSearchWidget extends StatelessWidget {
  const DetailsSearchWidget({
    super.key,
    required this.productTitle,
    required this.productPrice,
    required this.productId,
    required this.qty,
    required this.isAdded,
    required this.onAddToCart,
    required this.isAddedToWishlist,
    required this.onAddToWishlist,
    required this.productImage,
    this.showIcons = true,
  });
  final String productTitle;
  final String productPrice;
  final String productId;
  final String productImage;
  final int qty;
  final bool isAdded;
  final bool isAddedToWishlist;
  final void Function(String) onAddToCart;
  final void Function(String) onAddToWishlist;
  final bool showIcons;
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
        } else if (state is QuantityPlus) {
          Fluttertoast.showToast(
              msg: 'Item quantity plus',
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      builder: (context, state) {
        bool isLoading =
            state is AddProductToCartLoading && state.productId == productId;
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextTitle(
                      label: productTitle,
                      maxLines: 1,
                    ),
                  ),
                  if (showIcons)
                    HeartButtonManagement(
                      productTitle: productTitle,
                      productPrice: productPrice,
                      productImage: productImage,
                      productId: productId,
                      onAddToWishlist: onAddToWishlist,
                      isAddedToWihslist: isAddedToWishlist,
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  SubTitleText(
                    label: '\$$productPrice',
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                  const Spacer(),
                  if (showIcons)
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : Material(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(12),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                BlocProvider.of<AddProductToCartCubit>(context)
                                    .addProductToCart(
                                  productImage: productImage,
                                  productTitle: productTitle,
                                  productPrice: productPrice,
                                  productId: productId,
                                  qty: qty,
                                );
                                log(isAdded.toString());
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  isAdded
                                      ? Icons.done_all
                                      : Icons.add_shopping_cart_outlined,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class HeartButtonManagement extends StatelessWidget {
  const HeartButtonManagement({
    super.key,
    required this.productId,
    required this.onAddToWishlist,
    required this.isAddedToWihslist,
    required this.productTitle,
    required this.productPrice,
    required this.productImage,
  });

  final String productId;
  final void Function(String p1) onAddToWishlist;
  final bool isAddedToWihslist;
  final String productTitle;
  final String productPrice;
  final String productImage;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddProductToWishlistCubit, AddProductToWishlistState>(
      listener: (context, state) {
        if (state is AddProductToWishlistSuccess &&
            state.productId == productId) {
          Fluttertoast.showToast(
              msg: 'Item added to wishlist',
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 16.0);
          onAddToWishlist(productId);
        } else if (state is AddProductToWishlistError) {
          customErrorDialog(context, 'failed to add, try again later');
        } else if (state is ItemRemoveState) {
          Fluttertoast.showToast(
              msg: 'Item removed',
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      builder: (context, state) {
        bool isInWishlist = state is AddProductToWishlistSuccess &&
                state.productId == productId ||
            isAddedToWihslist &&
                !(state is ItemRemoveState && state.productId == productId);
        bool isLoading = state is AddProductToWishlistLoading &&
            state.productId == productId;
        return isLoading
            ? const Center(child: CircularProgressIndicator())
            : IconButton(
                onPressed: () {
                  if (isInWishlist) {
                    BlocProvider.of<AddProductToWishlistCubit>(context)
                        .addProductToWishlist(
                      productId: productId,
                      productTitle: productTitle,
                      productPrice: productPrice,
                      productImage: productImage,
                    );
                  } else {
                    BlocProvider.of<AddProductToWishlistCubit>(context)
                        .addProductToWishlist(
                      productId: productId,
                      productTitle: productTitle,
                      productPrice: productPrice,
                      productImage: productImage,
                    );
                  }
                  log(isInWishlist.toString());
                },
                icon: Icon(
                  IconlyLight.heart,
                  color: isInWishlist ? Colors.red : Colors.black,
                ),
              );
      },
    );
  }
}
