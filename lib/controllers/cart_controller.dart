import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handicraftmobilefrontend/utils/app_colors.dart';

class CartController extends GetxController {
  static CartController get to => Get.find();

  final RxList<CartItem> cartItems = <CartItem>[].obs;
  final RxDouble totalAmount = 0.0.obs;

  void addToCart(Map<String, dynamic> product, {int quantity = 1}) {
    String productId =
        (product['_id'] ??
                product['id'] ??
                product['title'] ??
                product['name'] ??
                DateTime.now().toString())
            .toString();

    int index = cartItems.indexWhere((item) => item.productId == productId);

    if (index != -1) {
      cartItems[index].quantity.value += quantity; // Fixed
    } else {
      cartItems.add(
        CartItem(
          productId: productId,
          name: product['title'] ?? product['name'] ?? 'Unknown Product',
          price:
              double.tryParse(
                product['price'].toString().replaceAll(RegExp(r'[^0-9.]'), ''),
              ) ??
              0.0,
          quantity: quantity,
          imageUrl: product['imageUrl'],
        ),
      );
    }

    calculateTotal();

    Get.snackbar(
      'Added to Bag',
      '${product['title'] ?? product['name']} added successfully',
      backgroundColor: AppColors.primary,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void removeFromCart(String productId) {
    cartItems.removeWhere((item) => item.productId == productId);
    calculateTotal();
  }

  void updateQuantity(String productId, int quantity) {
    if (quantity < 1) return;
    int index = cartItems.indexWhere((item) => item.productId == productId);
    if (index != -1) {
      cartItems[index].quantity.value = quantity; // Fixed
      calculateTotal();
    }
  }

  void calculateTotal() {
    totalAmount.value = cartItems.fold(
      0.0,
      (sum, item) => sum + (item.price * item.quantity.value), // Fixed .value
    );
  }

  void clearCart() {
    cartItems.clear();
    totalAmount.value = 0.0;
  }
}

class CartItem {
  final String productId;
  final String name;
  final double price;
  final RxInt quantity;
  final String? imageUrl;

  CartItem({
    required this.productId,
    required this.name,
    required this.price,
    required int quantity,
    this.imageUrl,
  }) : quantity = quantity.obs;
}
