// lib/widgets/cart_badge.dart
//
// Reusable cart icon with live badge count.
// Use this anywhere you want a cart icon that shows item count:
//
//   CartBadgeIcon(onTap: () => Get.to(() => const CartScreenView()))
//
// Make sure CartController is registered (Get.put) before this widget renders.

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handicraftmobilefrontend/controllers/cart_controller.dart';
import 'package:handicraftmobilefrontend/utils/app_colors.dart';
import 'package:handicraftmobilefrontend/view/cartScreen_view.dart';

class CartBadgeIcon extends StatelessWidget {
  final VoidCallback? onTap;

  const CartBadgeIcon({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final count = CartController.to.itemCount;
      return Stack(
        clipBehavior: Clip.none,
        children: [
          IconButton(
            onPressed: onTap ?? () => Get.to(() => const CartScreenView()),
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: AppColors.primary,
            ),
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
                constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
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
    });
  }
} 