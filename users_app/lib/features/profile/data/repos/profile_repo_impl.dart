import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_firebase/core/error/failure.dart';
import 'package:ecommerce_app_firebase/features/profile/data/models/order_model.dart';
import 'package:ecommerce_app_firebase/features/profile/data/models/user_model.dart';
import 'package:ecommerce_app_firebase/features/profile/data/repos/profile_repo.dart';
import 'package:ecommerce_app_firebase/features/search/data/models/wishlist_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileRepoImpl extends ProfileRepo {
  @override
  Future<Either<Failure, UserModel>> fetchUserInfo() async {
    User? user = FirebaseAuth.instance.currentUser;
    String userId = user!.uid;
    try {
      var userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      //final userDocDic = userDoc.data();
      var result = UserModel.fromJson(userDoc);
      return right(result);
    } catch (e) {
      if (e is FirebaseAuthException) {
        return left(ServerFailure.fromFirebaseErr(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<List<WishlistModel>> fetchWishlist() async {
    List<WishlistModel> wishlistItems = [];
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      wishlistItems.clear();
      return [];
    }
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      final data = userDoc.data();
      if (data == null || !data.containsKey('wishlist')) {
        return [];
      }
      final userWishlist = data['wishlist'] as List<dynamic>;
      for (var item in userWishlist) {
        final product = WishlistModel.fromJson(item as Map<String, dynamic>);
        wishlistItems.add(product);
      }
      return wishlistItems;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<OrderModel>> fetchAllOrders() async {
    List<OrderModel> orders = [];
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return [];
    }
    final userEmail = user.email;
    try {
      final res = await FirebaseFirestore.instance
          .collection('orders')
          .doc(userEmail)
          .collection('ordersList')
          .get();

      for (var element in res.docs) {
        orders.add(OrderModel.fromJson(element.data()));
      }
      return orders;
    } catch (e) {
      log('Error fetching orders: $e');
      rethrow;
    }
  }
}
