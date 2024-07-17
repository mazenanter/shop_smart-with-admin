import 'dart:io';

import 'package:admin_app/features/home/data/models/order_model.dart';
import 'package:admin_app/features/home/data/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DashboardRepo {
  Future<void> uploadProduct({
    required String productTitle,
    required String productPrice,
    required String productCategory,
    required String productDescription,
    required String productImage,
    required String productQty,
    required File pickedImage,
    Timestamp? createdAt,
  });

  Stream<List<ProductModel>> fetchAllProducts();
  Future<void> editProduct({
    required String productId,
    required String productTitle,
    required String productPrice,
    required String productCategory,
    required String productDescription,
    required String productImage,
    required String productQty,
    required File pickedImage,
    Timestamp? createdAt,
  });
  Future<List<OrderModel>> fetchAllOrders();
}
