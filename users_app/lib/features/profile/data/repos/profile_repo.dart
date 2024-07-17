import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_firebase/core/error/failure.dart';
import 'package:ecommerce_app_firebase/features/profile/data/models/order_model.dart';
import 'package:ecommerce_app_firebase/features/profile/data/models/user_model.dart';
import 'package:ecommerce_app_firebase/features/search/data/models/wishlist_model.dart';

abstract class ProfileRepo {
  Future<Either<Failure, UserModel>> fetchUserInfo();
  Future<List<WishlistModel>> fetchWishlist();
  Future<List<OrderModel>> fetchAllOrders();
}
