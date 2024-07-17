import 'package:ecommerce_app_firebase/core/widgets/empty_bag_widget.dart';
import 'package:ecommerce_app_firebase/features/cart/presentation/views/widgets/custom_cart_item.dart';
import 'package:ecommerce_app_firebase/features/profile/data/repos/profile_repo_impl.dart';
import 'package:ecommerce_app_firebase/features/profile/presentation/manager/fetch_orders_cubit/fetch_orders_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersViewBody extends StatelessWidget {
  const OrdersViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FetchOrdersCubit(ProfileRepoImpl())..fetchAllOrders(),
      child: BlocConsumer<FetchOrdersCubit, FetchOrdersState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is FetchOrdersSuccess && state.ordersList.isNotEmpty) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) => CustomCartItem(
                      cartId: state.ordersList[index].orderId,
                      productId: state.ordersList[index].productId,
                      productTitle: state.ordersList[index].productTitle,
                      productPrice: state.ordersList[index].productPrice,
                      productQty: int.parse(state.ordersList[index].quantity),
                      productImage: state.ordersList[index].imageUrl,
                      showQtyButton: false,
                      showQtyTitle: true,
                      showHeartIcon: false,
                    ),
                    itemCount: state.ordersList.length,
                  ),
                ),
              ],
            );
          } else if (state is FetchOrdersSuccess && state.ordersList.isEmpty) {
            return const EmptyBagWidget(
              image: 'assets/images/bag/order.png',
              title: 'Whoops',
              subTitle: 'No orders has been placed yet',
              buttonTitle: 'Shop now',
            );
          }
          return const EmptyBagWidget(
            image: 'assets/images/bag/order.png',
            title: 'Whoops',
            subTitle: 'No orders has been placed yet',
            buttonTitle: 'Shop now',
          );
        },
      ),
    );
  }
}
