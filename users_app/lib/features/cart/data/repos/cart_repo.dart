import 'package:ecommerce_app_firebase/features/cart/data/models/cart_model.dart';

abstract class CartRepo {
  Future<List<CartModel>> fetchAllUserCart();
  Future<void> removeItemFromCart({
    required String productId,
    required String cartId,
    required String productImage,
    required String productPrice,
    required String productTitle,
    required int qty,
  });
  Future<void> removeAllItemsFromCart();
}
