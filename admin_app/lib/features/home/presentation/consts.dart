import 'package:admin_app/features/home/data/models/dashboard_model.dart';

class AppConsts {
  static List<DashboardModel> dashboardImages = [
    DashboardModel(
      image: 'assets/images/dashboard/cloud.png',
      title: 'Add a new product',
    ),
    DashboardModel(
      image: 'assets/images/bag/shopping_cart.png',
      title: 'Inspect all product',
    ),
    DashboardModel(
      image: 'assets/images/dashboard/order.png',
      title: 'View orders',
    ),
  ];
  static List<String> categories = [
    'Phones',
    'Laptops',
    'Electronics',
    'Watches',
    'Clothes',
    'Shoes',
    'Books',
    'Cosmetics',
    'Accessories',
  ];
}

String? imageUrl;
