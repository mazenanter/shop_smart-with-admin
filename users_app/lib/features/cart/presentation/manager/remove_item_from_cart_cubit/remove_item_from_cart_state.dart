part of 'remove_item_from_cart_cubit.dart';

@immutable
sealed class RemoveItemFromCartState {}

final class RemoveItemFromCartInitial extends RemoveItemFromCartState {}

final class RemoveItemFromCartLoading extends RemoveItemFromCartState {}

final class RemoveItemFromCartSuccess extends RemoveItemFromCartState {}
