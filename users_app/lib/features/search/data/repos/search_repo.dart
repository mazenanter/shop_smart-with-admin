import 'package:ecommerce_app_firebase/features/search/data/models/product_model.dart';

abstract class SearchRepo {
  Stream<List<ProductModel>> fetchAllProducts();
  Future<List<ProductModel>> searchProducts({required String searchText});
  // Future<void> addProductToCart({required String productId, required int qty});
}
