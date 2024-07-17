import 'package:ecommerce_app_firebase/core/utils/app_colors.dart';
import 'package:ecommerce_app_firebase/core/widgets/custom_dialog.dart';
import 'package:ecommerce_app_firebase/core/widgets/text_title.dart';
import 'package:ecommerce_app_firebase/features/cart/presentation/manager/fetch_cart_items_cubit/fetch_cart_items_cubit.dart';
import 'package:ecommerce_app_firebase/features/cart/presentation/manager/remove_all_items_from_cart_cubit/remove_all_items_from_cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

AppBar customCartAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    elevation: 0,
    title: Row(
      children: [
        Image.asset(
          'assets/images/shopping_cart.png',
          height: MediaQuery.sizeOf(context).height * 0.07,
        ),
        const SizedBox(
          width: 10,
        ),
        Shimmer.fromColors(
          period: const Duration(
            seconds: 4,
          ),
          baseColor: Colors.purple,
          highlightColor: Colors.red,
          child: const TextTitle(
            label: 'Shopping Basket',
          ),
        ),
      ],
    ),
    actions: [
      Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(16),
        ),
        child: BlocConsumer<RemoveAllItemsFromCartCubit,
            RemoveAllItemsFromCartState>(
          listener: (context, state) {
            if (state is RemoveAllItemSFromCartSuccess) {
              BlocProvider.of<FetchCartItemsCubit>(context).fetchCartItems();
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return IconButton(
              onPressed: () {
                customDialog(context, () {
                  BlocProvider.of<RemoveAllItemsFromCartCubit>(context)
                      .removeAllItemsFromCart();
                }, 'Are you sure to remove all items');
              },
              icon: const Icon(
                Icons.delete_forever_rounded,
                color: AppColors.darkScaffoldColor,
              ),
            );
          },
        ),
      ),
    ],
  );
}
