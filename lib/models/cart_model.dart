// lib/models/cart_model.dart

class CartModel {
  final bool? success;
  final List<CartItemModel> items;

  CartModel({
    required this.success,
    required this.items,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      success: json['success'],
      items: json['items'] == null
          ? []
          : List<CartItemModel>.from(
              json['items']!.map((x) => CartItemModel.fromJson(x))),
    );
  }
}

class CartItemModel {
  final String? id;
  final String? productId;
  final String? title;
  final String? subtitle;
  final String? image;
  final int? price;
  final int? quantity;

  CartItemModel({
    required this.id,
    required this.productId,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.price,
    required this.quantity,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['_id'],
      productId: json['product_id'],
      title: json['title'],
      subtitle: json['subtitle'],
      image: json['image'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'product_id': productId,
      'title': title,
      'subtitle': subtitle,
      'image': image,
      'price': price,
      'quantity': quantity,
    };
  }
}