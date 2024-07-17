import 'package:bloc/bloc.dart';
import 'package:ecommerce_app_firebase/features/cart/data/models/cart_model.dart';
import 'package:ecommerce_app_firebase/features/cart/data/repos/cart_repo.dart';
import 'package:meta/meta.dart';

part 'fetch_cart_items_state.dart';

class FetchCartItemsCubit extends Cubit<FetchCartItemsState> {
  FetchCartItemsCubit(this.cartRepo) : super(FetchCartItemsInitial());
  List<CartModel> cartItems = [];
  final CartRepo cartRepo;
  Future<List<CartModel>> fetchCartItems() async {
    try {
      final items = await cartRepo.fetchAllUserCart();
      cartItems = items;
      emit(FetchCartItemsSuccess(cartItems));
      return cartItems;
    } catch (e) {
      emit(FetchCartItemsError(e.toString()));
      rethrow;
    }
  }
}
