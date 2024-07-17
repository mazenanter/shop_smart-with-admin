import 'dart:developer';
import 'dart:io';

import 'package:admin_app/features/home/data/models/order_model.dart';
import 'package:admin_app/features/home/data/models/product_model.dart';
import 'package:admin_app/features/home/data/repos/dashboard_repo.dart';
import 'package:admin_app/features/home/presentation/consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class DashboardRepoImpl extends DashboardRepo {
  @override
  Future<void> uploadProduct(
      {required String productTitle,
      required String productPrice,
      required String productCategory,
      required String productDescription,
      required File pickedImage,
      required String productImage,
      required String productQty,
      Timestamp? createdAt}) async {
    var firestore = FirebaseFirestore.instance;
    var productId = const Uuid().v4();
    var ref = FirebaseStorage.instance
        .ref()
        .child('productsImage')
        .child('$productId.jpg');
    await ref.putFile(File(pickedImage.path));
    productImage = await ref.getDownloadURL();
    imageUrl = productImage;

    var value =
        await firestore.collection('products').doc(productId).set(ProductModel(
              productId: productId,
              productTitle: productTitle,
              productPrice: productPrice,
              productCategory: productCategory,
              productDescription: productDescription,
              productImage: productImage,
              productQty: productQty,
              createdAt: Timestamp.now(),
            ).toJson());
    return value;
  }

  @override
  Stream<List<ProductModel>> fetchAllProducts() {
    try {
      var db = FirebaseFirestore.instance.collection('products');
      List<ProductModel> products = [];
      return db.snapshots().map((snaphot) {
        products.clear();
        for (var element in snaphot.docs) {
          products.add(ProductModel.fromJson(element));
        }
        return products;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
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
  }) async {
    var firestore = FirebaseFirestore.instance;
    var ref = FirebaseStorage.instance
        .ref()
        .child('productsImage')
        .child('$productId.jpg');
    await ref.putFile(File(pickedImage.path));
    productImage = await ref.getDownloadURL();
    imageUrl = productImage;

    var value = await firestore
        .collection('products')
        .doc(productId)
        .update(ProductModel(
          productId: productId,
          productTitle: productTitle,
          productPrice: productPrice,
          productCategory: productCategory,
          productDescription: productDescription,
          productImage: productImage,
          productQty: productQty,
          createdAt: Timestamp.now(),
        ).toJson());
    return value;
  }

  @override
  Future<List<OrderModel>> fetchAllOrders() async {
    List<OrderModel> orders = [];

    try {
      final QuerySnapshot<Map<String, dynamic>> res =
          await FirebaseFirestore.instance.collection('orders').get();

      for (var doc in res.docs) {
        // لكل وثيقة في مجموعة 'orders'
        final QuerySnapshot<Map<String, dynamic>> ordersListRes =
            await doc.reference.collection('ordersList').get();

        // لكل وثيقة في مجموعة 'ordersList'، قم بإضافة OrderModel إلى قائمة الطلبات
        for (var orderDoc in ordersListRes.docs) {
          orders.add(OrderModel.fromJson(orderDoc.data()));
        }
      }

      return orders;
    } catch (e) {
      log('Error fetching orders: $e');
      rethrow;
    }
  }
}
