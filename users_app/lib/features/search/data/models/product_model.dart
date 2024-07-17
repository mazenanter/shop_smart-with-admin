import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String productId;
  final String productTitle;
  final String productPrice;
  final String productCategory;
  final String productDescription;
  final String productImage;
  final String productQty;
  final Timestamp? createdAt;

  ProductModel(
      {required this.productId,
      required this.productTitle,
      required this.productPrice,
      required this.productCategory,
      required this.productDescription,
      required this.productImage,
      required this.productQty,
      this.createdAt});

  factory ProductModel.fromJson(json) {
    return ProductModel(
      productId: json['productId'],
      productTitle: json['productTitle'],
      productPrice: json['productPrice'],
      productCategory: json['productCategory'],
      productDescription: json['productDescription'],
      productImage: json['productImage'],
      productQty: json['productQty'],
      createdAt: json['createdAt'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productTitle': productTitle,
      'productCategory': productCategory,
      'productPrice': productPrice,
      'productDescription': productDescription,
      'productImage': productImage,
      'productQty': productQty,
      'createdAt': createdAt,
    };
  }
}
