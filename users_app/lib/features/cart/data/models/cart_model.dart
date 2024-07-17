class CartModel {
  final String productId;
  final String productTitle;
  final String productPrice;
  final String productImage;
  final int qty;
  final String cartId;

  CartModel(
      {required this.productId,
      required this.productTitle,
      required this.productImage,
      required this.productPrice,
      required this.qty,
      required this.cartId});

  factory CartModel.fromJson(json) {
    return CartModel(
      productId: json['productId'],
      productTitle: json['productTitle'],
      productPrice: json['productPrice'],
      qty: json['quantity'],
      cartId: json['cartId'],
      productImage: json['productImage'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'cartId': cartId,
      'productTitle': productTitle,
      'productPrice': productPrice,
      'quantity': qty,
      'productImage': productImage,
      'productId': productId,
    };
  }
}
