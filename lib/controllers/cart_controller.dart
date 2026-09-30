// lib/controllers/cart_controller.dart

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:handicraftmobilefrontend/models/cart_model.dart';
import 'package:handicraftmobilefrontend/services/cart_service.dart';
import 'package:handicraftmobilefrontend/utils/api_constants.dart';
import 'package:handicraftmobilefrontend/view/cartScreen_view.dart';

class CartController extends GetxController {
  static CartController get to => Get.find<CartController>();

  final cartItems = <CartItemModel>[].obs;
  final isLoading = false.obs; // false so cart screen doesn't show spinner on first open
  final error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Don't auto-fetch — API is protected and auth isn't set up yet.
    // Cart is built locally from addToCart calls until auth is ready.
  }


  Future<void> addToCart(Map<String, dynamic> product) async {
    final String productId =
        (product['id'] ?? product['_id'] ?? '').toString();

    if (productId.isEmpty) {
      Get.snackbar(
        'Error',
        'Product ID missing — cannot add to cart.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // ── 1. Update local list immediately (no API needed) ──────────────────
    final existingIndex = cartItems.indexWhere(
      (item) => item.productId == productId,
    );

    if (existingIndex != -1) {
      // Already in cart — bump quantity
      final existing = cartItems[existingIndex];
      cartItems[existingIndex] = CartItemModel(
        id: existing.id,
        productId: existing.productId,
        title: existing.title,
        subtitle: existing.subtitle,
        image: existing.image,
        price: existing.price,
        quantity: (existing.quantity ?? 1) + 1,
      );
      cartItems.refresh();
    } else {
      // New item
      cartItems.add(CartItemModel(
        id: productId,
        productId: productId,
        title: product['title']?.toString() ?? '',
        subtitle: product['subtitle']?.toString() ?? '',
        image: product['imageUrl']?.toString() ?? '',
        price: _parsePrice(product['price']),
        quantity: 1,
      ));
    }

    // ── 2. Fire POST to backend in background (best effort) ───────────────
    try {
      await CartService.addToCart(productId: productId, quantity: 1);
    } catch (e) {
     
      debugPrint('Cart API error (local cart still updated): $e');
    }

    // ── 3. Show confirmation and navigate ─────────────────────────────────
    Get.snackbar(
      'Added to Bag 🛍️',
      '${product['title'] ?? 'Item'} has been added to your bag.',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );

    Get.to(() => const CartScreenView());
  }

  // ── Fetch cart from API (call this once auth is ready) ────────────────────

  Future<void> fetchCart() async {
    try {
      isLoading(true);
      error('');
      final CartModel result = await CartService.getCart();
      debugPrint('Cart fetch success: ${result.success}');
      debugPrint('Cart items count: ${result.items.length}');
      if (result.success == true) {
        cartItems.assignAll(result.items);
      } else {
        error('Failed to load cart');
      }
    } catch (e) {
      debugPrint('Cart fetch error: $e');
      error(e.toString());
    } finally {
      isLoading(false);
    }
  }

  // ── Increment quantity ────────────────────────────────────────────────────

  Future<void> incrementQuantity(CartItemModel item) async {
    final index = cartItems.indexOf(item);
    if (index == -1) return;

    final newQty = (item.quantity ?? 1) + 1;

    // Update locally first
    cartItems[index] = CartItemModel(
      id: item.id,
      productId: item.productId,
      title: item.title,
      subtitle: item.subtitle,
      image: item.image,
      price: item.price,
      quantity: newQty,
    );
    cartItems.refresh();

    // Sync to backend best effort
    try {
      await CartService.updateCartItem(
        productId: item.productId ?? '',
        quantity: newQty,
      );
    } catch (e) {
      debugPrint('Update cart error: $e');
    }
  }

  // ── Decrement quantity ────────────────────────────────────────────────────

  Future<void> decrementQuantity(CartItemModel item) async {
    final index = cartItems.indexOf(item);
    if (index == -1) return;

    final currentQty = item.quantity ?? 1;
    if (currentQty <= 1) return;

    final newQty = currentQty - 1;

    // Update locally first
    cartItems[index] = CartItemModel(
      id: item.id,
      productId: item.productId,
      title: item.title,
      subtitle: item.subtitle,
      image: item.image,
      price: item.price,
      quantity: newQty,
    );
    cartItems.refresh();

    // Sync to backend best effort
    try {
      await CartService.updateCartItem(
        productId: item.productId ?? '',
        quantity: newQty,
      );
    } catch (e) {
      debugPrint('Update cart error: $e');
    }
  }

  // ── Remove item ───────────────────────────────────────────────────────────

  Future<void> removeItem(CartItemModel item) async {
    // Remove locally first
    cartItems.remove(item);

    // Sync to backend best effort
    try {
      await CartService.removeFromCart(item.productId ?? '');
    } catch (e) {
      debugPrint('Remove cart error: $e');
    }
  }

  // ── Clear cart ────────────────────────────────────────────────────────────

  Future<void> clearCart() async {
    cartItems.clear();

    try {
      await CartService.clearCart();
    } catch (e) {
      debugPrint('Clear cart error: $e');
    }
  }

  // ── Computed totals ───────────────────────────────────────────────────────

  int get subtotal => cartItems.fold(
        0,
        (sum, item) => sum + (item.price ?? 0) * (item.quantity ?? 1),
      );

  int get tax => (subtotal * 0.13).round();

  int get total => subtotal + tax;

  int get itemCount =>
      cartItems.fold(0, (sum, item) => sum + (item.quantity ?? 1));

  // ── Image URL helper ──────────────────────────────────────────────────────

  String imageUrl(CartItemModel item) {
    final image = item.image ?? '';
    if (image.isEmpty) return '';
    if (image.startsWith('http')) return image;
    final path = image.startsWith('/') ? image : '/$image';
    return '${ApiConstants.serverUrl}$path';
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  int _parsePrice(dynamic raw) {
    if (raw == null) return 0;
    if (raw is int) return raw;
    if (raw is double) return raw.round();
    // Strip currency symbols like "$1,250.00" → 1250
    final cleaned = raw.toString().replaceAll(RegExp(r'[^\d.]'), '');
    return double.tryParse(cleaned)?.round() ?? 0;
  }
}