// lib/widgets/product_image.dart
//
// Shows a product picture that comes from the backend.
// If the link is empty or the picture fails to load, we show a grey icon
// instead of a broken image.

import 'package:flutter/material.dart';
import 'package:handicraftmobilefrontend/utils/app_colors.dart';

class ProductImage extends StatelessWidget {
  final String imageUrl;
  final double iconSize;

  const ProductImage({super.key, required this.imageUrl, this.iconSize = 40});

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return _placeholder();
    }

    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      // Runs when the link is wrong or the server is offline.
      errorBuilder: (context, error, stackTrace) => _placeholder(),
    );
  }

  Widget _placeholder() {
    return Container(
      color: AppColors.surfaceContainerLow,
      child: Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          color: AppColors.secondary,
          size: iconSize,
        ),
      ),
    );
  }
}
