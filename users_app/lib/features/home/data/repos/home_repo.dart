import 'package:ecommerce_app_firebase/features/search/data/models/product_model.dart';

abstract class HomeRepo {
  Stream<List<ProductModel>> fetchLatestArrivelProducts();
  Stream<List<ProductModel>> fetchProductsByCategory(
      {required String category});
}
