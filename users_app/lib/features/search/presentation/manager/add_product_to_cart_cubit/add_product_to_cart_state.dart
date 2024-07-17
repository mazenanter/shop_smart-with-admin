part of 'add_product_to_cart_cubit.dart';

@immutable
abstract class AddProductToCartState {
  final String productId;

  const AddProductToCartState(this.productId);
}

class AddProductToCartInitial extends AddProductToCartState {
  const AddProductToCartInitial() : super('');
}

class AddProductToCartLoading extends AddProductToCartState {
  const AddProductToCartLoading(super.productId);
}

class AddProductToCartSuccess extends AddProductToCartState {
  const AddProductToCartSuccess(super.productId);
}

class QuantityPlus extends AddProductToCartState {
  const QuantityPlus(super.productId);
}

class AddProductToCartError extends AddProductToCartState {
  final String error;

  const AddProductToCartError(super.productId, this.error);
}
