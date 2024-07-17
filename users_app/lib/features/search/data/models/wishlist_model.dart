class WishlistModel {
  final String productId;
  final String productTitle;
  final String productPrice;
  final String productImage;
  final String wishlistId;

  WishlistModel({
    required this.productId,
    required this.wishlistId,
    required this.productTitle,
    required this.productImage,
    required this.productPrice,
  });

  factory WishlistModel.fromJson(json) {
    return WishlistModel(
      productId: json['productId'],
      wishlistId: json['wishlistId'],
      productTitle: json['productTitle'],
      productImage: json['productImage'],
      productPrice: json['productPrice'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'wishlistId': wishlistId,
      'productId': productId,
      'productImage': productImage,
      'productPrice': productPrice,
      'productTitle': productTitle,
    };
  }
}
