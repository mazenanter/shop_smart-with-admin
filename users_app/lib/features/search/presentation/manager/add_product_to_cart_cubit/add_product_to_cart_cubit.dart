import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_firebase/features/cart/data/models/cart_model.dart';
import 'package:ecommerce_app_firebase/features/search/data/repos/search_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'add_product_to_cart_state.dart';

class AddProductToCartCubit extends Cubit<AddProductToCartState> {
  AddProductToCartCubit(this.searchRepo)
      : super(const AddProductToCartInitial());

  final SearchRepo searchRepo;

  Future<void> addProductToCart({
    required String productId,
    required String productTitle,
    required String productPrice,
    required int qty,
    required String productImage,
  }) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    final cartId = const Uuid().v4();
    final uId = user.uid;
    try {
      final userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uId).get();
      final data = userDoc.data();
      if (data == null || !data.containsKey('userCart')) {
        await FirebaseFirestore.instance.collection('users').doc(uId).update({
          'userCart': FieldValue.arrayUnion([
            CartModel(
              productImage: productImage,
              productTitle: productTitle,
              productPrice: productPrice,
              cartId: cartId,
              productId: productId,
              qty: qty,
            ).toJson()
          ])
        });
        emit(AddProductToCartSuccess(productId));
        return;
      }
      List<dynamic> userCart = data['userCart'];
      bool productExists = false;
      for (int i = 0; i < userCart.length; i++) {
        if (userCart[i]['productId'] == productId) {
          userCart[i]['quantity'] += qty;
          productExists = true;
          break;
        }
      }
      if (productExists) {
        await FirebaseFirestore.instance.collection('users').doc(uId).update({
          'userCart': userCart,
        });
        emit(QuantityPlus(productId));
      } else {
        await FirebaseFirestore.instance.collection('users').doc(uId).update({
          'userCart': FieldValue.arrayUnion([
            CartModel(
              productTitle: productTitle,
              productPrice: productPrice,
              productImage: productImage,
              cartId: cartId,
              productId: productId,
              qty: qty,
            ).toJson()
          ])
        });
        emit(AddProductToCartSuccess(productId));
      }
    } catch (e) {
      rethrow;
    }
  }
}
