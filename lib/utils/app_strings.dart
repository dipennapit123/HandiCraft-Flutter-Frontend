// lib/utils/app_strings.dart
//
// All the text shown in the app. Keeping text here means we never
// type the same sentence twice and translating later is easier.

class AppStrings {
  // General
  static const String appTitle = 'KalaKosh';

  // Shop screen
  static const String searchPlaceholder = 'Search heritage crafts...';
  static const String sortByLabel = 'Sort by: ';
  static const String filterButtonText = 'Filters';
  static const String priceFilterChip = 'Under \$500';
  static const String noProductsFound = 'No products found';
  static const String loadProductsError = 'Could not load products';

  // Sort menu
  static const String sortSheetTitle = 'Sort by';
  static const String sortNewest = 'New Arrivals';
  static const String sortPriceLowHigh = 'Price: Low to High';
  static const String sortPriceHighLow = 'Price: High to Low';
  static const String sortTopRated = 'Top Rated';

  // Product detail screen
  static const String descriptionTitle = 'Description';
  static const String detailsTitle = 'Product Details';
  static const String quantityLabel = 'Select Quantity:';
  static const String addToCart = 'Add to Cart';
  static const String defaultDescription =
      'Hand-crafted by master artisans in Nepal.';
  static const String loadProductError = 'Could not load this product';
  static const String productNotFound = 'Product not found';

  // Specification labels
  static const String materialLabel = 'Material';
  static const String regionLabel = 'Region';
  static const String craftTypeLabel = 'Craft Type';
  static const String categoryLabel = 'Category';
  static const String stockLabel = 'In Stock';
}
