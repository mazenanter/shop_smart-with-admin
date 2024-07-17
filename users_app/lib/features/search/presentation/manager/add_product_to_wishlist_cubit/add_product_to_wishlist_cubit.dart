import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_firebase/features/search/data/models/wishlist_model.dart';
import 'package:ecommerce_app_firebase/features/search/data/repos/search_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'add_product_to_wishlist_state.dart';

class AddProductToWishlistCubit extends Cubit<AddProductToWishlistState> {
  AddProductToWishlistCubit(this.searchRepo)
      : super(const AddProductToWishlistInitial());
  final SearchRepo searchRepo;

  // Future<void> addProductToWishlist({
  //   required String productId,
  // }) async {
  //   emit(AddProductToWishlistLoading(productId));
  //   try {
  //     await searchRepo.addProductToWishlist(
  //       productId: productId,
  //     );

  //     emit(AddProductToWishlistSuccess(productId));
  //   } catch (e) {
  //     emit(AddProductToWishlistError(productId, e.toString()));
  //   }
  // }
  Future<void> addProductToWishlist({
    required String productId,
    required String productTitle,
    required String productPrice,
    required String productImage,
  }) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    final userId = user.uid;
    final wishlistId = const Uuid().v4();
    emit(AddProductToWishlistLoading(productId));
    try {
      final firebaseDb = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      final data = firebaseDb.data();
      if (data == null || !data.containsKey('wishlist')) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({
          'wishlist': FieldValue.arrayUnion([
            WishlistModel(
              productId: productId,
              productTitle: productTitle,
              productPrice: productPrice,
              productImage: productImage,
              wishlistId: wishlistId,
            ).toJson()
          ]),
        });
        emit(AddProductToWishlistSuccess(productId));
        return;
      }
      List<dynamic> wishlistData = data['wishlist'];
      dynamic existingItem;

      // ابحث عن المنتج لو موجود في قائمة الرغبات
      for (var item in wishlistData) {
        if (item['productId'] == productId) {
          existingItem = item;
          break;
        }
      }
      if (existingItem != null) {
        emit(ItemIsExist(productId));
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({
          'wishlist': FieldValue.arrayRemove([existingItem]),
        });
        emit(ItemRemoveState(productId));
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({
          'wishlist': FieldValue.arrayUnion([
            WishlistModel(
              productImage: productImage,
              productPrice: productPrice,
              productTitle: productTitle,
              wishlistId: wishlistId,
              productId: productId,
            ).toJson()
          ])
        });
        emit(AddProductToWishlistSuccess(productId));
      }
    } catch (e) {
      emit(AddProductToWishlistError(productId, e.toString()));
      rethrow;
    }
  }
}
