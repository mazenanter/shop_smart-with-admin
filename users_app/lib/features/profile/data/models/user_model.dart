import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userId;
  final String name;
  final String image;
  final String email;
  final List userCart;
  final List wishlist;
  final Timestamp createdAt;

  UserModel({
    required this.name,
    required this.email,
    required this.userCart,
    required this.userId,
    required this.image,
    required this.createdAt,
    required this.wishlist,
  });

  factory UserModel.fromJson(json) {
    return UserModel(
      name: json['name'],
      userId: json['userId'],
      image: json['image'],
      createdAt: json['createdAt'],
      wishlist: json['wishlist'],
      email: json['email'],
      userCart: json['userCart'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'userCart': userCart,
      'wishlist': wishlist,
      'createdAt': createdAt,
      'image': image,
      'userId': userId,
    };
  }
}
