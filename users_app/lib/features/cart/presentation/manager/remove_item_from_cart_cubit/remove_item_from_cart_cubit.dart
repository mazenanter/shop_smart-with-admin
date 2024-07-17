import 'package:bloc/bloc.dart';
import 'package:ecommerce_app_firebase/features/cart/data/repos/cart_repo.dart';
import 'package:meta/meta.dart';

part 'remove_item_from_cart_state.dart';

class RemoveItemFromCartCubit extends Cubit<RemoveItemFromCartState> {
  RemoveItemFromCartCubit(this.cartRepo) : super(RemoveItemFromCartInitial());
  final CartRepo cartRepo;

  Future<void> removeItemFromCart({
    required String productId,
    required String cartId,
    required String productImage,
    required String productPrice,
    required String productTitle,
    required int qty,
  }) async {
    emit(RemoveItemFromCartLoading());
    await cartRepo.removeItemFromCart(
      productId: productId,
      cartId: cartId,
      productImage: productImage,
      productTitle: productTitle,
      productPrice: productPrice,
      qty: qty,
    );
    emit(RemoveItemFromCartSuccess());
  }
}
