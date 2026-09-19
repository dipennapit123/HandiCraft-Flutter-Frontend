// lib/view/product_details_view.dart  (updated sections only)
//
// Changes from original:
// 1. CartController registered via Get.put in build so it's always available.
// 2. Cart icon in AppBar now shows a badge with live item count via Obx.
// 3. "Add to Cart" button calls CartController.to.addToCart(product).

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handicraftmobilefrontend/utils/app_colors.dart';
import 'package:handicraftmobilefrontend/view/cartScreen_view.dart';
import 'package:handicraftmobilefrontend/widgets/product_details.dart';
import 'package:handicraftmobilefrontend/controllers/cart_controller.dart';

class ProductView extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductView({super.key, required this.product});

  double get _ratingValue {
    final match = RegExp(r'[\d.]+').firstMatch(
      product['rating']?.toString() ?? '',
    );
    return double.tryParse(match?.group(0) ?? '') ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    // Ensure CartController is registered — safe to call even if already put
    if (!Get.isRegistered<CartController>()) {
      Get.put(CartController());
    }

    final String title = product['title'] ?? 'Unknown Product';
    final String price = product['price']?.toString() ?? '';
    final String? imageUrl = product['imageUrl'];
    final String description = product['description'] ??
        'Hand-crafted by master artisans in the Kathmandu Valley. Each piece is unique, reflecting centuries of Himalayan craft tradition.';
    final String material = product['material'] ?? 'Hand-crafted, natural materials';
    final String dimensions = product['dimensions'] ?? 'Varies by piece';
    final String weight = product['weight'] ?? 'Varies by piece';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'KalaKosh',
          style: TextStyle(
            fontFamily: 'Playfair Display',
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: AppColors.primary),
            onPressed: () {},
          ),
          // Cart icon with live badge
          Obx(() {
            final count = CartController.to.itemCount;
            return Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  onPressed: () => Get.to(() => const CartScreenView()),
                  icon: const Icon(Icons.shopping_cart, color: AppColors.primary),
                ),
                if (count > 0)
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        count > 99 ? '99+' : '$count',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            );
          }),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image Section
            Container(
              height: 280,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: imageUrl != null
                        ? Image.network(
                            imageUrl,
                            height: 280,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.image_not_supported_outlined, size: 64),
                          )
                        : const Icon(Icons.image_not_supported_outlined, size: 64),
                  ),
                  Positioned(
                    bottom: 50,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.favorite_border, color: Colors.grey, size: 18),
                    ),
                  ),
                  Positioned(
                    bottom: 15,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.share, color: Colors.grey, size: 18),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        price,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      ...List.generate(5, (i) {
                        final diff = _ratingValue - i;
                        IconData icon;
                        if (diff >= 1) {
                          icon = Icons.star;
                        } else if (diff >= 0.5) {
                          icon = Icons.star_half;
                        } else {
                          icon = Icons.star_border;
                        }
                        return Icon(icon, color: Colors.amber, size: 20);
                      }),
                      const SizedBox(width: 8),
                      Text(
                        product['rating']?.toString() ?? '',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  const Text(
                    'Description',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 14),

                  const Text(
                    'Product Details',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ProductDetail(label: 'Material', value: material),
                  ProductDetail(label: 'Dimensions', value: dimensions),
                  ProductDetail(label: 'Weight', value: weight),

                  const SizedBox(height: 40),

                  // Add to Cart button — calls controller
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () => CartController.to.addToCart(product),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_cart, color: Colors.white),
                          SizedBox(width: 12),
                          Text(
                            'Add to Cart',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}