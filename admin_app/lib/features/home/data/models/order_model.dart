import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String userId;
  final String orderId;
  final String productId;
  final String productTitle;
  final String productPrice;
  final String userName;
  final String imageUrl;
  final String quantity;
  final Timestamp orderDate;

  OrderModel({
    required this.userId,
    required this.orderId,
    required this.productId,
    required this.productTitle,
    required this.productPrice,
    required this.userName,
    required this.imageUrl,
    required this.quantity,
    required this.orderDate,
  });
  factory OrderModel.fromJson(json) {
    return OrderModel(
      userId: json['userId'],
      orderId: json['orderId'],
      productId: json['productId'],
      productTitle: json['productTitle'],
      productPrice: json['productPrice'],
      userName: json['userName'],
      imageUrl: json['imageUrl'],
      quantity: json['quantity'],
      orderDate: json['orderDate'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'orderId': orderId,
      'productId': productId,
      'productTitle': productTitle,
      'productPrice': productPrice,
      'userName': userName,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'orderDate': orderDate,
    };
  }
}
