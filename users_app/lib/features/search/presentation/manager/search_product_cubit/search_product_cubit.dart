import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app_firebase/features/search/data/models/product_model.dart';
import 'package:ecommerce_app_firebase/features/search/data/repos/search_repo.dart';
import 'package:meta/meta.dart';

part 'search_product_state.dart';

class SearchProductCubit extends Cubit<SearchProductState> {
  SearchProductCubit(this.searchRepo) : super(SearchProductInitial());
  final SearchRepo searchRepo;
  List<ProductModel>? searchList;
  Future<void> searchProducts({required String searchText}) async {
    emit(SearchProductLoading());

    await searchRepo.searchProducts(searchText: searchText).then((value) {
      searchList = value;
      emit(SearchProductSuccess(value));
    }).catchError((onError) {
      emit(SearchProductError(onError.toString()));
    });
    log(searchList!.length.toString());
  }
}
