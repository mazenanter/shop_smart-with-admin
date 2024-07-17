import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_firebase/features/profile/data/repos/profile_repo.dart';
import 'package:ecommerce_app_firebase/features/search/data/models/wishlist_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'fetch_wishlist_items_state.dart';

class FetchWishlistItemsCubit extends Cubit<FetchWishlistItemsState> {
  FetchWishlistItemsCubit(this.profileRepo)
      : super(FetchWishlistItemsInitial());
  final ProfileRepo profileRepo;
  List<WishlistModel> wishlistItems = [];
  Future<List<WishlistModel>> fetchWishlistItem() async {
    emit(FetchWishlistItemsLoading());
    try {
      final items = await profileRepo.fetchWishlist();
      wishlistItems = items;
      emit(FetchWishlistItemsSuccess(wishlistItems));
      return wishlistItems;
    } catch (e) {
      emit(FetchWishlistItemsError());
      rethrow;
    }
  }

  Future<void> removeAllItemsFromWishlist() async {
    emit(RemoveAllItemLoading());
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    final userId = user.uid;

    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'wishlist': [],
    });
    emit(RemoveAllItemSuccess());
  }
}
