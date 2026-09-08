// lib/widgets/add_to_cart_bar.dart
//
// The bar that stays at the bottom of the product detail screen:
// quantity buttons (- 1 +) and the "Add to Cart" button.

import 'package:flutter/material.dart';
import 'package:handicraftmobilefrontend/utils/app_colors.dart';
import 'package:handicraftmobilefrontend/utils/app_sizes.dart';
import 'package:handicraftmobilefrontend/utils/app_strings.dart';

class AddToCartBar extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onAddToCart;

  const AddToCartBar({
    super.key,
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingMd),
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.95),
        border: Border(
          top: BorderSide(
            color: AppColors.secondaryContainer.withValues(alpha: 0.3),
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppStrings.quantityLabel,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
              _buildQuantityPicker(),
            ],
          ),
          const SizedBox(height: 14),
          _buildAddToCartButton(),
        ],
      ),
    );
  }

  /// The small "- 1 +" box.
  Widget _buildQuantityPicker() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.secondaryContainer.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppSizes.radiusBadge),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.remove, size: 16),
            onPressed: onDecrease,
          ),
          Text(
            '$quantity',
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add, size: 16),
            onPressed: onIncrease,
          ),
        ],
      ),
    );
  }

  Widget _buildAddToCartButton() {
    return ElevatedButton(
      onPressed: onAddToCart,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusBadge),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_bag_outlined, size: 20),
          SizedBox(width: AppSizes.paddingSm),
          Text(
            AppStrings.addToCart,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
