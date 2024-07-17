import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_firebase/features/cart/data/models/cart_model.dart';
import 'package:ecommerce_app_firebase/features/cart/data/repos/cart_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartRepoImpl extends CartRepo {
  @override
  Future<List<CartModel>> fetchAllUserCart() async {
    List<CartModel> cartItems = [];
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      cartItems.clear();
      return [];
    }
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      final data = userDoc.data();
      if (data == null || !data.containsKey('userCart')) {
        return [];
      }
      final userCart = data['userCart'] as List<dynamic>;
      for (var item in userCart) {
        final product = CartModel.fromJson(item as Map<String, dynamic>);
        cartItems.add(product);
      }
      return cartItems;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> removeItemFromCart({
    required String productId,
    required String cartId,
    required String productImage,
    required String productPrice,
    required String productTitle,
    required int qty,
  }) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    final userId = user.uid;

    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'userCart': FieldValue.arrayRemove([
        {
          'productId': productId,
          'cartId': cartId,
          'productImage': productImage,
          'productPrice': productPrice,
          'productTitle': productTitle,
          'quantity': qty,
        }
      ]),
    });
    fetchAllUserCart();
  }

  @override
  Future<void> removeAllItemsFromCart() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    final userId = user.uid;

    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'userCart': [],
    });
  }
}
