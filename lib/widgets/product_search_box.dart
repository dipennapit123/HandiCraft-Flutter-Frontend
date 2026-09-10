// lib/widgets/product_search_box.dart
//
// The rounded search field at the top of the shop screen.
// This widget only draws the field. The shop screen decides what happens
// when the text changes, so the API logic stays in one place.

import 'package:flutter/material.dart';
import 'package:handicraftmobilefrontend/utils/app_colors.dart';
import 'package:handicraftmobilefrontend/utils/app_sizes.dart';
import 'package:handicraftmobilefrontend/utils/app_strings.dart';

class ProductSearchBox extends StatelessWidget {
  final TextEditingController controller;

  // Runs on every letter the user types.
  final ValueChanged<String> onChanged;

  // Runs when the user taps the small clear (x) button.
  final VoidCallback onClear;

  const ProductSearchBox({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: AppStrings.searchPlaceholder,
        hintStyle: const TextStyle(
          color: AppColors.secondary,
          fontFamily: 'Inter',
          fontSize: 16,
        ),
        prefixIcon: const Icon(Icons.search, color: AppColors.secondary),
        // The clear button only appears when there is text to clear.
        suffixIcon: controller.text.isEmpty
            ? null
            : IconButton(
                icon: const Icon(Icons.clear, color: AppColors.secondary),
                onPressed: onClear,
              ),
        filled: true,
        fillColor: AppColors.surfaceContainerLow,
        contentPadding: const EdgeInsets.symmetric(
          vertical: AppSizes.paddingMd,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusCircular),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
