import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_firebase/features/search/data/models/product_model.dart';
import 'package:ecommerce_app_firebase/features/search/data/repos/search_repo.dart';

class SearchRepoImpl extends SearchRepo {
  @override
  Stream<List<ProductModel>> fetchAllProducts() {
    try {
      final firebaseDb = FirebaseFirestore.instance.collection('products');
      List<ProductModel> products = [];
      return firebaseDb.snapshots().map((res) {
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

  // @override
  // Future<void> addProductToCart({
  //   required String productId,
  //   required int qty,
  // }) async {
  //   final User? user = FirebaseAuth.instance.currentUser;
  //   if (user == null) {
  //     return;
  //   }
  //   final cartId = const Uuid().v4();
  //   final uId = user.uid;
  //   try {
  //     final userDoc =
  //         await FirebaseFirestore.instance.collection('users').doc(uId).get();
  //     final data = userDoc.data();
  //     if (data == null || !data.containsKey('userCart')) {
  //       await FirebaseFirestore.instance.collection('users').doc(uId).update({
  //         'userCart': FieldValue.arrayUnion([
  //           CartModel(
  //             cartId: cartId,
  //             productId: productId,
  //             qty: qty,
  //           ).toJson()
  //         ])
  //       });
  //       return;
  //     }
  //     List<dynamic> userCart = data['userCart'];
  //     bool productExists = false;
  //     for (int i = 0; i < userCart.length; i++) {
  //       if (userCart[i]['productId'] == productId) {
  //         userCart[i]['quantity'] += qty;
  //         productExists = true;
  //         break;
  //       }
  //     }
  //     if (productExists) {
  //       await FirebaseFirestore.instance.collection('users').doc(uId).update({
  //         'userCart': userCart,
  //       });
  //     } else {
  //       await FirebaseFirestore.instance.collection('users').doc(uId).update({
  //         'userCart': FieldValue.arrayUnion([
  //           CartModel(
  //             cartId: cartId,
  //             productId: productId,
  //             qty: qty,
  //           ).toJson()
  //         ])
  //       });
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  @override
  Future<List<ProductModel>> searchProducts(
      {required String searchText}) async {
    try {
      final firebaseDb = FirebaseFirestore.instance.collection('products');
      List<ProductModel> searchListResult = [];
      var result = await firebaseDb
          .where('productTitle', isGreaterThanOrEqualTo: searchText)
          .where('productTitle', isLessThanOrEqualTo: '$searchText\uf8ff')
          .get();
      searchListResult.clear();
      for (var element in result.docs) {
        searchListResult.add(ProductModel.fromJson(element.data()));
      }
      return searchListResult;
    } catch (e) {
      rethrow;
    }
  }
}
