// lib/widgets/product_gallery.dart
//
// Swipeable picture gallery at the top of the product detail screen.
// It also draws the small dots that show which picture is visible.

import 'package:flutter/material.dart';
import 'package:handicraftmobilefrontend/utils/app_colors.dart';
import 'package:handicraftmobilefrontend/utils/app_sizes.dart';
import 'package:handicraftmobilefrontend/widgets/product_image.dart';

class ProductGallery extends StatefulWidget {
  final List<String> images;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;

  const ProductGallery({
    super.key,
    required this.images,
    required this.isFavorite,
    required this.onFavoriteTap,
  });

  @override
  State<ProductGallery> createState() => _ProductGalleryState();
}

class _ProductGalleryState extends State<ProductGallery> {
  // Which picture the user is looking at (0 = first picture).
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // When the product has no picture we still show one empty slot so the
    // layout does not break.
    final List<String> images = widget.images.isEmpty ? [''] : widget.images;

    return AspectRatio(
      aspectRatio: 16 / 10,
      child: Stack(
        children: [
          // Swipe left/right between pictures.
          PageView.builder(
            itemCount: images.length,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemBuilder: (context, index) {
              return ProductImage(imageUrl: images[index]);
            },
          ),

          // Heart button.
          Positioned(
            bottom: 12,
            right: AppSizes.paddingMd,
            child: GestureDetector(
              onTap: widget.onFavoriteTap,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.95),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
            ),
          ),

          // Dots. Only shown when there is more than one picture.
          if (images.length > 1)
            Positioned(
              bottom: 12,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(images.length, _buildDot),
              ),
            ),
        ],
      ),
    );
  }

  /// One dot. The dot of the visible picture is wider and dark red.
  Widget _buildDot(int index) {
    final bool isActive = index == _currentIndex;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 3),
      height: 5,
      width: isActive ? 16 : 5,
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.primary
            : Colors.white.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(AppSizes.radiusCircular),
      ),
    );
  }
}
