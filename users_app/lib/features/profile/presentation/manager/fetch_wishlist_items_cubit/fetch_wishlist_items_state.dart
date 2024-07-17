part of 'fetch_wishlist_items_cubit.dart';

@immutable
sealed class FetchWishlistItemsState {}

final class FetchWishlistItemsInitial extends FetchWishlistItemsState {}

final class FetchWishlistItemsLoading extends FetchWishlistItemsState {}

final class FetchWishlistItemsSuccess extends FetchWishlistItemsState {
  final List<WishlistModel> wishlistItems;

  FetchWishlistItemsSuccess(this.wishlistItems);
}

final class FetchWishlistItemsError extends FetchWishlistItemsState {}

final class RemoveAllItemSuccess extends FetchWishlistItemsState {}

final class RemoveAllItemLoading extends FetchWishlistItemsState {}
