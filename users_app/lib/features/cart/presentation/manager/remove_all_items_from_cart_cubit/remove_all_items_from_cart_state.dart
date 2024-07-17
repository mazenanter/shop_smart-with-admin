part of 'remove_all_items_from_cart_cubit.dart';

@immutable
sealed class RemoveAllItemsFromCartState {}

final class RemoveAllItemsFromCartInitial extends RemoveAllItemsFromCartState {}

final class RemoveAllItemSFromCartLoading extends RemoveAllItemsFromCartState {}

final class RemoveAllItemSFromCartSuccess extends RemoveAllItemsFromCartState {}
