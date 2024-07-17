part of 'fetch_all_orders_cubit.dart';

@immutable
sealed class FetchAllOrdersState {}

final class FetchAllOrdersInitial extends FetchAllOrdersState {}

final class FetchAllOrdersLoading extends FetchAllOrdersState {}

final class FetchAllOrdersSuccess extends FetchAllOrdersState {
  final List<OrderModel> ordersList;

  FetchAllOrdersSuccess(this.ordersList);
}

final class FetchAllOrdersError extends FetchAllOrdersState {
  final String errMsg;

  FetchAllOrdersError(this.errMsg);
}
