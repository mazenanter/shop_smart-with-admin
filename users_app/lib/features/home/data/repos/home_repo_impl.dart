import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_firebase/features/home/data/repos/home_repo.dart';
import 'package:ecommerce_app_firebase/features/search/data/models/product_model.dart';

class HomeRepoImpl extends HomeRepo {
  @override
  Stream<List<ProductModel>> fetchLatestArrivelProducts() {
    try {
      final firebaseDb = FirebaseFirestore.instance.collection('products');
      List<ProductModel> products = [];
      return firebaseDb
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((res) {
        products.clear();
        for (var element in res.docs) {
          products.add(
            ProductModel.fromJson(element),
          );
        }
        return products;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<List<ProductModel>> fetchProductsByCategory(
      {required String category}) {
    try {
      final firebaseDb = FirebaseFirestore.instance.collection('products');
      List<ProductModel> productsByCategory = [];
      return firebaseDb
          .where('productCategory', isEqualTo: category)
          .snapshots()
          .map((res) {
        productsByCategory.clear();
        for (var element in res.docs) {
          productsByCategory.add(
            ProductModel.fromJson(element),
          );
        }
        return productsByCategory;
      });
    } catch (e) {
      rethrow;
    }
  }
}
