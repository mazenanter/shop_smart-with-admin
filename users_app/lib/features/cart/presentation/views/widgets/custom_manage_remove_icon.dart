import 'package:ecommerce_app_firebase/core/widgets/custom_dialog.dart';
import 'package:ecommerce_app_firebase/features/cart/data/repos/cart_repo_impl.dart';
import 'package:ecommerce_app_firebase/features/cart/presentation/manager/remove_item_from_cart_cubit/remove_item_from_cart_cubit.dart';
import 'package:ecommerce_app_firebase/features/cart/presentation/manager/fetch_cart_items_cubit/fetch_cart_items_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomManageRemoveIcon extends StatelessWidget {
  const CustomManageRemoveIcon({
    super.key,
    required this.cartId,
    required this.productImage,
    required this.productPrice,
    required this.productTitle,
    required this.productQty,
    required this.productId,
  });

  final String cartId;
  final String productImage;
  final String productPrice;
  final String productTitle;
  final int productQty;
  final String productId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RemoveItemFromCartCubit(CartRepoImpl()),
      child: BlocConsumer<RemoveItemFromCartCubit, RemoveItemFromCartState>(
        listener: (context, state) {
          if (state is RemoveItemFromCartSuccess) {
            Navigator.pop(context);
            BlocProvider.of<FetchCartItemsCubit>(context).fetchCartItems();
          }
        },
        builder: (context, state) {
          return IconButton(
            onPressed: () {
              customDialog(
                context,
                () {
                  BlocProvider.of<RemoveItemFromCartCubit>(context)
                      .removeItemFromCart(
                          cartId: cartId,
                          productImage: productImage,
                          productPrice: productPrice,
                          productTitle: productTitle,
                          qty: productQty,
                          productId: productId);
                },
                'Are you sure to remove this item',
              );
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          );
        },
      ),
    );
  }
}
