// lib/widgets/category_chips.dart
//
// The horizontal row of filter chips under the search box.
// The first chip clears every filter, the other chips come from
// GET /api/categories plus one price filter.

import 'package:flutter/material.dart';
import 'package:handicraftmobilefrontend/utils/app_colors.dart';
import 'package:handicraftmobilefrontend/utils/app_sizes.dart';
import 'package:handicraftmobilefrontend/utils/app_strings.dart';
import 'package:handicraftmobilefrontend/utils/app_text_styles.dart';

class CategoryChips extends StatelessWidget {
  final List<String> chips;

  // Which chip is selected right now. null means "no filter".
  final String? selectedChip;

  // Runs when the user taps a chip.
  final ValueChanged<String> onChipTap;

  // Runs when the user taps the first "Filters" chip.
  final VoidCallback onClearFilters;

  const CategoryChips({
    super.key,
    required this.chips,
    required this.selectedChip,
    required this.onChipTap,
    required this.onClearFilters,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        // "+ 1" because index 0 is the "Filters" chip.
        itemCount: chips.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(right: AppSizes.paddingSm),
              child: _buildFiltersChip(),
            );
          }

          final String chip = chips[index - 1];
          return Padding(
            padding: const EdgeInsets.only(right: AppSizes.paddingSm),
            child: _buildCategoryChip(chip),
          );
        },
      ),
    );
  }

  /// Dark red chip that removes all filters.
  Widget _buildFiltersChip() {
    return ActionChip(
      onPressed: onClearFilters,
      backgroundColor: AppColors.primary,
      side: BorderSide.none,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusCircular),
      ),
      avatar: const Icon(Icons.tune, color: Colors.white, size: 18),
      label: const Text(
        AppStrings.filterButtonText,
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// One category chip, highlighted when it is the selected one.
  Widget _buildCategoryChip(String chip) {
    final bool isSelected = selectedChip == chip;

    return ChoiceChip(
      label: Text(chip, style: AppTextStyles.labelMedium),
      selected: isSelected,
      onSelected: (_) => onChipTap(chip),
      selectedColor: AppColors.primary.withValues(alpha: 0.15),
      backgroundColor: AppColors.secondaryContainer,
      side: BorderSide.none,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusCircular),
      ),
    );
  }
}
