// lib/widgets/product_card.dart
//
// One product tile inside the shop grid:
// picture + heart button + badge + name + rating + price.

import 'package:flutter/material.dart';
import 'package:handicraftmobilefrontend/models/product_model.dart';
import 'package:handicraftmobilefrontend/utils/app_colors.dart';
import 'package:handicraftmobilefrontend/utils/app_sizes.dart';
import 'package:handicraftmobilefrontend/utils/app_text_styles.dart';
import 'package:handicraftmobilefrontend/widgets/product_image.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  // Called when the user taps the card (opens the detail screen).
  final VoidCallback onTap;

  // Called when the user taps the heart icon.
  final VoidCallback onFavoriteTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Picture area. Expanded makes it fill the space left above the text.
          Expanded(child: _buildImageArea()),
          const SizedBox(height: AppSizes.paddingSm),

          // Product name (one line only).
          Text(
            product.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),

          // Star + rating number.
          Row(
            children: [
              const Icon(Icons.star, color: AppColors.primary, size: 14),
              const SizedBox(width: AppSizes.paddingXs),
              Text(
                product.ratingText,
                style: const TextStyle(
                  color: AppColors.secondary,
                  fontFamily: 'Inter',
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),

          // Price.
          Text(
            product.priceText,
            style: const TextStyle(
              color: AppColors.primary,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  /// Picture with the heart button and the badge placed on top of it.
  Widget _buildImageArea() {
    return Stack(
      children: [
        // Rounded picture.
        Container(
          width: double.infinity,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.radiusCard),
            color: AppColors.surfaceContainerLow,
          ),
          child: ProductImage(imageUrl: product.firstImage),
        ),

        // Heart button (top right corner).
        Positioned(
          top: 12,
          right: 12,
          child: GestureDetector(
            onTap: onFavoriteTap,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.6),
                shape: BoxShape.circle,
              ),
              child: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: AppColors.primary,
                size: 20,
              ),
            ),
          ),
        ),

        // Badge such as "SALE" (bottom left corner). Only some products
        // have a badge, so we check for null first.
        if (product.badgeText != null)
          Positioned(bottom: 12, left: 12, child: _buildBadge()),
      ],
    );
  }

  Widget _buildBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(AppSizes.radiusBadge),
      ),
      child: Text(
        product.badgeText!.toUpperCase(),
        style: const TextStyle(
          color: AppColors.primary,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
