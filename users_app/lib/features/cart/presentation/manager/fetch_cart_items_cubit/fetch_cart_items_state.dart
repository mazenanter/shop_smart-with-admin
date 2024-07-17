part of 'fetch_cart_items_cubit.dart';

@immutable
sealed class FetchCartItemsState {}

final class FetchCartItemsInitial extends FetchCartItemsState {}

final class FetchCartItemsSuccess extends FetchCartItemsState {
  final List<CartModel> cartItem;

  FetchCartItemsSuccess(this.cartItem);
}

final class FetchCartItemsLoading extends FetchCartItemsState {}

final class FetchCartItemsError extends FetchCartItemsState {
  final String errMsg;

  FetchCartItemsError(this.errMsg);
}
