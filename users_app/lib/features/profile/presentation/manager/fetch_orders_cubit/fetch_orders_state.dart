part of 'fetch_orders_cubit.dart';

@immutable
sealed class FetchOrdersState {}

final class FetchOrdersInitial extends FetchOrdersState {}

final class FetchOrdersLoading extends FetchOrdersState {}

final class FetchOrdersSuccess extends FetchOrdersState {
  final List<OrderModel> ordersList;

  FetchOrdersSuccess(this.ordersList);
}

final class FetchOrdersError extends FetchOrdersState {
  final String errMsg;

  FetchOrdersError(this.errMsg);
}
