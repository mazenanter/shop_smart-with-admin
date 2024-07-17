import 'package:bloc/bloc.dart';
import 'package:ecommerce_app_firebase/features/cart/data/repos/cart_repo.dart';
import 'package:meta/meta.dart';

part 'remove_all_items_from_cart_state.dart';

class RemoveAllItemsFromCartCubit extends Cubit<RemoveAllItemsFromCartState> {
  RemoveAllItemsFromCartCubit(this.cartRepo)
      : super(RemoveAllItemsFromCartInitial());
  final CartRepo cartRepo;

  Future<void> removeAllItemsFromCart() async {
    emit(RemoveAllItemSFromCartLoading());
    await cartRepo.removeAllItemsFromCart();
    emit(RemoveAllItemSFromCartSuccess());
  }
}
