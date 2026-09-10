// lib/widgets/specification_row.dart
//
// One line of the specification table on the product detail screen,
// for example:  Material            Lokta Paper

import 'package:flutter/material.dart';
import 'package:handicraftmobilefrontend/utils/app_colors.dart';
import 'package:handicraftmobilefrontend/utils/app_sizes.dart';

class SpecificationRow extends StatelessWidget {
  final String label;
  final String value;

  // The last row in the table does not need a divider under it.
  final bool showDivider;

  const SpecificationRow({
    super.key,
    required this.label,
    required this.value,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSizes.paddingSm),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.secondary,
                  fontFamily: 'Inter',
                  fontSize: 14,
                ),
              ),
              // Flexible stops long values from overflowing the screen.
              Flexible(
                child: Text(
                  value,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: AppColors.textDark,
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            color: AppColors.secondary.withValues(alpha: 0.15),
          ),
      ],
    );
  }
}
