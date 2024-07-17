part of 'search_product_cubit.dart';

@immutable
sealed class SearchProductState {}

final class SearchProductInitial extends SearchProductState {}

final class SearchProductSuccess extends SearchProductState {
  final List<ProductModel> searchListResult;

  SearchProductSuccess(this.searchListResult);
}

final class SearchProductError extends SearchProductState {
  final String errMsg;

  SearchProductError(this.errMsg);
}

final class SearchProductLoading extends SearchProductState {}
