// lib/services/cart_service.dart
//
// Cart API calls matching the actual API spec:
// GET    /api/cart              — get user's cart
// POST   /api/cart              — add product / increment quantity
// PUT    /api/cart              — update quantity of a cart item
// DELETE /api/cart/:productId   — remove a specific item
// DELETE /api/cart              — clear entire cart

import 'dart:convert';

import 'package:handicraftmobilefrontend/models/cart_model.dart';
import 'package:handicraftmobilefrontend/utils/api_constants.dart';
import 'package:http/http.dart' as http;

class CartService {
  static final String _cartUrl = '${ApiConstants.baseUrl}/cart';

  /// GET /api/cart — fetch user's active cart with products populated
  static Future<CartModel> getCart() async {
    final response = await http.get(Uri.parse(_cartUrl));

    if (response.statusCode == 200) {
      return CartModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load cart: ${response.statusCode}');
    }
  }

  /// POST /api/cart — add product to cart or increment quantity
  /// Body: { product_id, quantity }
  static Future<bool> addToCart({
    required String productId,
    int quantity = 1,
  }) async {
    final response = await http.post(
      Uri.parse(_cartUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'product_id': productId,
        'quantity': quantity,
      }),
    );

    return response.statusCode == 200 || response.statusCode == 201;
  }

  /// PUT /api/cart — update quantity of a specific cart item
  /// Body: { product_id, quantity }
  static Future<bool> updateCartItem({
    required String productId,
    required int quantity,
  }) async {
    final response = await http.put(
      Uri.parse(_cartUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'product_id': productId,
        'quantity': quantity,
      }),
    );

    return response.statusCode == 200;
  }

  /// DELETE /api/cart/:productId — remove a specific item from cart
  static Future<bool> removeFromCart(String productId) async {
    final response = await http.delete(
      Uri.parse('$_cartUrl/$productId'),
    );

    return response.statusCode == 200;
  }

  /// DELETE /api/cart — clear all items from cart
  static Future<bool> clearCart() async {
    final response = await http.delete(Uri.parse(_cartUrl));

    return response.statusCode == 200;
  }
}