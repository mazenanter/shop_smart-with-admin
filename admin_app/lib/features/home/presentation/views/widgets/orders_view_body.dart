import 'dart:developer';

import 'package:admin_app/core/widgets/empty_bag_widget.dart';
import 'package:admin_app/features/home/data/repos/dashboard_repo_impl.dart';
import 'package:admin_app/features/home/presentation/manager/fetch_all_orders_cubit/fetch_all_orders_cubit.dart';
import 'package:admin_app/features/home/presentation/views/widgets/custom_cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersViewBody extends StatelessWidget {
  const OrdersViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FetchAllOrdersCubit(DashboardRepoImpl())..fetchAllOrders(),
      child: BlocConsumer<FetchAllOrdersCubit, FetchAllOrdersState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is FetchAllOrdersSuccess) {
            log(state.ordersList.length.toString());
          }
          if (state is FetchAllOrdersSuccess && state.ordersList.isNotEmpty) {
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
          } else if (state is FetchAllOrdersSuccess &&
              state.ordersList.isEmpty) {
            return const EmptyBagWidget(
              image: 'assets/images/bag/order.png',
              title: 'Whoops',
              subTitle: 'No orders has been placed yet',
            );
          }
          return const EmptyBagWidget(
            image: 'assets/images/bag/order.png',
            title: 'Whoops',
            subTitle: 'No orders has been placed yet',
          );
        },
      ),
    );
  }
}
