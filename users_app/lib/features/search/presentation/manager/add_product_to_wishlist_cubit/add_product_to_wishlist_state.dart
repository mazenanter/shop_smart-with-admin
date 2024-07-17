part of 'add_product_to_wishlist_cubit.dart';

@immutable
abstract class AddProductToWishlistState {
  final String productId;

  const AddProductToWishlistState(this.productId);
}

class AddProductToWishlistInitial extends AddProductToWishlistState {
  const AddProductToWishlistInitial() : super('');
}

class AddProductToWishlistLoading extends AddProductToWishlistState {
  const AddProductToWishlistLoading(super.productId);
}

class AddProductToWishlistSuccess extends AddProductToWishlistState {
  const AddProductToWishlistSuccess(super.productId);
}

class ItemRemoveState extends AddProductToWishlistState {
  const ItemRemoveState(super.productId);
}

class ItemIsExist extends AddProductToWishlistState {
  const ItemIsExist(super.productId);
}

class AddProductToWishlistError extends AddProductToWishlistState {
  final String error;

  const AddProductToWishlistError(super.productId, this.error);
}
