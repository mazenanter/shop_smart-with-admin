import 'package:ecommerce_app_firebase/core/widgets/sub_title_text.dart';
import 'package:ecommerce_app_firebase/core/widgets/text_title.dart';
import 'package:ecommerce_app_firebase/features/cart/presentation/manager/fetch_cart_items_cubit/fetch_cart_items_cubit.dart';
import 'package:ecommerce_app_firebase/features/cart/presentation/manager/place_oder_cubit/place_order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChechoutWidget extends StatelessWidget {
  const ChechoutWidget({
    super.key,
    required this.totalItems,
    required this.totalPrice,
  });
  final String totalItems;
  final String totalPrice;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextTitle(
                    label: 'Total ($totalItems Product /$totalItems item)'),
                SubTitleText(
                  label: totalPrice,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
          BlocProvider(
            create: (context) => PlaceOrderCubit(),
            child: BlocConsumer<PlaceOrderCubit, PlaceOrderState>(
              listener: (context, state) {
                if (state is PlaceOrderSuccess) {
                  Fluttertoast.showToast(
                      msg: 'Order completed',
                      timeInSecForIosWeb: 1,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  BlocProvider.of<FetchCartItemsCubit>(context)
                      .fetchCartItems();
                }
              },
              builder: (context, state) {
                if (state is PlaceOrderLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is PlaceOrderError) {
                  return TextTitle(label: 'Error');
                }
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? Theme.of(context).cardColor
                            : Colors.white,
                  ),
                  onPressed: () {
                    BlocProvider.of<PlaceOrderCubit>(context)
                        .placeOrder(context);
                  },
                  child: const TextTitle(
                    label: 'checkout',
                    fontSize: 16,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
