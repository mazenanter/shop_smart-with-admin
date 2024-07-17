import 'package:ecommerce_app_firebase/core/widgets/empty_bag_widget.dart';
import 'package:ecommerce_app_firebase/core/widgets/text_title.dart';
import 'package:ecommerce_app_firebase/features/cart/data/repos/cart_repo_impl.dart';
import 'package:ecommerce_app_firebase/features/cart/presentation/manager/fetch_cart_items_cubit/fetch_cart_items_cubit.dart';
import 'package:ecommerce_app_firebase/features/cart/presentation/views/widgets/checkout_widget.dart';
import 'package:ecommerce_app_firebase/features/cart/presentation/views/widgets/custom_cart_app_bar.dart';
import 'package:ecommerce_app_firebase/features/cart/presentation/views/widgets/custom_cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FetchCartItemsCubit(CartRepoImpl())..fetchCartItems(),
      child: BlocConsumer<FetchCartItemsCubit, FetchCartItemsState>(
        listener: (context, state) {},
        builder: (context, state) {
          var list = BlocProvider.of<FetchCartItemsCubit>(context).cartItems;
          double totalPrice = 0;
          if (state is FetchCartItemsSuccess) {
            for (var item in list) {
              totalPrice += double.parse(
                  item.productPrice); // Assuming productPrice is a String
            }
          }
          return list.isEmpty
              ? const EmptyBagWidget(
                  image: 'assets/images/shopping_cart.png',
                  title: 'Your cart is empty',
                  subTitle:
                      'Looks like you have not added anything in your cart, Go ahead & explore top categories',
                  buttonTitle: 'Shop now',
                )
              : Scaffold(
                  appBar: customCartAppBar(context),
                  body: Column(
                    children: [
                      if (state is FetchCartItemsSuccess) ...[
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) => CustomCartItem(
                              cartId: list[index].cartId,
                              productId: list[index].productId,
                              productQty: list[index].qty,
                              productTitle: list[index].productTitle,
                              productImage: list[index].productImage,
                              productPrice: list[index].productPrice,
                            ),
                            itemCount: list.length,
                          ),
                        ),
                        const Divider(
                          color: Colors.grey,
                          height: 1,
                        ),
                        ChechoutWidget(
                          totalPrice: totalPrice.toString(),
                          totalItems: list.length.toString(),
                        ),
                      ],
                      if (state is FetchCartItemsLoading)
                        const Center(child: TextTitle(label: 'Loading')),
                    ],
                  ),
                );
        },
      ),
    );
  }
}



//







                              