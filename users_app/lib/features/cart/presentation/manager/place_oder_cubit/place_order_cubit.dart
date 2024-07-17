import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_firebase/features/cart/presentation/manager/fetch_cart_items_cubit/fetch_cart_items_cubit.dart';
import 'package:ecommerce_app_firebase/features/cart/presentation/manager/remove_all_items_from_cart_cubit/remove_all_items_from_cart_cubit.dart';
import 'package:ecommerce_app_firebase/features/profile/data/models/order_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'place_order_state.dart';

class PlaceOrderCubit extends Cubit<PlaceOrderState> {
  PlaceOrderCubit() : super(PlaceOrderInitial());
  Future<void> placeOrder(context) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    emit(PlaceOrderLoading());
    final userId = user.uid;
    try {
      BlocProvider.of<FetchCartItemsCubit>(context)
          .cartItems
          .forEach((element) async {
        final orderId = const Uuid().v4();
        await FirebaseFirestore.instance
            .collection('orders')
            .doc(user.email)
            .collection('ordersList')
            .doc(orderId)
            .set(OrderModel(
              userId: userId,
              orderId: orderId,
              productId: element.productId,
              productTitle: element.productTitle,
              productPrice: element.productPrice,
              userName: user.displayName ?? 'null',
              imageUrl: element.productImage,
              quantity: element.qty.toString(),
              orderDate: Timestamp.now(),
            ).toJson());
      });
      emit(PlaceOrderSuccess());
      BlocProvider.of<RemoveAllItemsFromCartCubit>(context)
          .removeAllItemsFromCart();
    } catch (e) {
      emit(PlaceOrderError());
      log(e.toString());
      rethrow;
    }
  }

  
}
