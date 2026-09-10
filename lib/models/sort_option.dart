// lib/models/sort_option.dart
//
// One choice in the "Sort by" menu of the shop screen.
// [label] is what the user reads, [value] is what the backend understands
// (it is sent as ?sort=price).

import 'package:handicraftmobilefrontend/utils/app_strings.dart';

class SortOption {
  final String label;
  final String value;

  const SortOption({required this.label, required this.value});

  /// The option selected when the shop screen opens.
  static const SortOption newest = SortOption(
    label: AppStrings.sortNewest,
    value: 'newest',
  );

  /// The list shown in the bottom sheet.
  static const List<SortOption> all = [
    newest,
    SortOption(label: AppStrings.sortPriceLowHigh, value: 'price'),
    SortOption(label: AppStrings.sortPriceHighLow, value: '-price'),
    SortOption(label: AppStrings.sortTopRated, value: 'rating'),
  ];
}
