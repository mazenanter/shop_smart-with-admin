// import 'dart:developer';

// import 'package:bloc/bloc.dart';
// import 'package:ecommerce_app_firebase/features/search/data/models/product_model.dart';
// import 'package:ecommerce_app_firebase/features/search/data/repos/search_repo.dart';
// import 'package:meta/meta.dart';

// part 'fetch_all_products_state.dart';

// class FetchAllProductsCubit extends Cubit<FetchAllProductsState> {
//   FetchAllProductsCubit(this.searchRepo) : super(FetchAllProductsInitial());

//   final SearchRepo searchRepo;
//   Stream<void> fetchAllProducts()  {
//     emit(FetchAllProductsLoading());
//     var result = await searchRepo.fetchAllProducts();

//     return result.fold((failure) {
//       log(failure.errMsg);
//       return emit(FetchAllProductsError(failure.errMsg));
//     }, (products) {
//       log(products.length.toString());
//       return emit(FetchAllProductsSuccess(products));
//     });
//   }
// }
