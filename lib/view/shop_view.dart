// lib/view/shop_view.dart
//
// The shop screen. It shows the product grid that comes from the backend.
//
// What this screen does:
//   1. asks ProductService for the categories and the products
//   2. keeps the answer in state variables
//   3. shows a spinner, an error, or the grid
//
// The small UI pieces (search box, chips, product card) live in lib/widgets
// so this file stays about the logic.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:handicraftmobilefrontend/models/product_model.dart';
import 'package:handicraftmobilefrontend/models/sort_option.dart';
import 'package:handicraftmobilefrontend/services/product_service.dart';
import 'package:handicraftmobilefrontend/utils/api_error.dart';
import 'package:handicraftmobilefrontend/utils/app_colors.dart';
import 'package:handicraftmobilefrontend/utils/app_sizes.dart';
import 'package:handicraftmobilefrontend/utils/app_strings.dart';
import 'package:handicraftmobilefrontend/utils/app_text_styles.dart';
import 'package:handicraftmobilefrontend/view/product_details_view.dart';
import 'package:handicraftmobilefrontend/widgets/category_chips.dart';
import 'package:handicraftmobilefrontend/widgets/product_card.dart';
import 'package:handicraftmobilefrontend/widgets/product_search_box.dart';
import 'package:handicraftmobilefrontend/widgets/status_view.dart';

class ShopView extends StatefulWidget {
  const ShopView({super.key});

  @override
  State<ShopView> createState() => _ShopViewState();
}

class _ShopViewState extends State<ShopView> {
  // Talks to the backend for us.
  final ProductService _productService = ProductService();

  // Reads the text the user types in the search box.
  final TextEditingController _searchController = TextEditingController();

  // Waits a moment before searching, so we do not call the API on every letter.
  Timer? _searchTimer;

  // ----- Data from the backend -----
  List<ProductModel> _products = [];
  List<String> _chips = [AppStrings.priceFilterChip];

  // ----- Screen state -----
  bool _isLoading = true;
  String? _errorMessage; // null means "no error"

  // ----- Filters chosen by the user -----
  String? _selectedChip;
  String? _selectedCategory; // sent as ?category=Pottery
  double? _maxPrice; // sent as ?maxPrice=500
  SortOption _sortOption = SortOption.newest;

  @override
  void initState() {
    super.initState();
    // Load everything as soon as the screen opens.
    _loadEverything();
  }

  @override
  void dispose() {
    // Always clean up controllers and timers, otherwise they leak memory.
    _searchTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  // -------------------------------------------------------------------------
  // API calls
  // -------------------------------------------------------------------------

  /// Loads the filter chips and the products together.
  /// Also used by pull-to-refresh.
  Future<void> _loadEverything() async {
    await Future.wait([_loadCategories(), _loadProducts()]);
  }

  /// GET /api/categories -> chips above the grid.
  Future<void> _loadCategories() async {
    try {
      final List<String> names = await _productService.getCategoryNames();
      if (!mounted) return;

      setState(() {
        _chips = [AppStrings.priceFilterChip, ...names];
      });
    } catch (_) {
      // Chips are not important enough to show an error for.
      // The products can still load without them.
    }
  }

  /// GET /api/products (or /api/products/search when the user typed something).
  Future<void> _loadProducts() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final String searchText = _searchController.text.trim();
      List<ProductModel> products;

      if (searchText.isNotEmpty) {
        products = await _productService.searchProducts(searchText);
      } else {
        final result = await _productService.getProducts(
          category: _selectedCategory,
          maxPrice: _maxPrice,
          sort: _sortOption.value,
        );
        products = result.products;
      }

      // The user may have left the screen while we were waiting.
      if (!mounted) return;

      setState(() {
        _products = products;
        _isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
        _errorMessage = apiErrorMessage(
          error,
          fallback: AppStrings.loadProductsError,
        );
      });
    }
  }

  // -------------------------------------------------------------------------
  // User actions
  // -------------------------------------------------------------------------

  /// Runs on every letter typed. We wait 450 ms of silence before calling the
  /// API, otherwise typing "pot" would send three requests.
  void _onSearchChanged(String text) {
    setState(() {}); // redraws the clear (x) button
    _searchTimer?.cancel();
    _searchTimer = Timer(const Duration(milliseconds: 450), _loadProducts);
  }

  /// Empties the search box and shows the normal product list again.
  void _onSearchCleared() {
    _searchController.clear();
    setState(() {});
    _loadProducts();
  }

  /// Tapping a chip turns the filter on. Tapping the same chip again turns
  /// it off.
  void _onChipTap(String chip) {
    setState(() {
      if (_selectedChip == chip) {
        _clearFilterValues();
      } else {
        _selectedChip = chip;

        if (chip == AppStrings.priceFilterChip) {
          _maxPrice = 500;
          _selectedCategory = null;
        } else {
          _maxPrice = null;
          _selectedCategory = chip;
        }
      }
      _searchController.clear();
    });

    _loadProducts();
  }

  /// The "Filters" chip removes every filter and the search text.
  void _onClearFilters() {
    setState(() {
      _clearFilterValues();
      _searchController.clear();
    });
    _loadProducts();
  }

  /// Resets the filter variables. Called from two places, so it is a method.
  void _clearFilterValues() {
    _selectedChip = null;
    _selectedCategory = null;
    _maxPrice = null;
  }

  /// Opens the "Sort by" bottom sheet and reloads with the chosen order.
  Future<void> _openSortMenu() async {
    final SortOption? chosen = await showModalBottomSheet<SortOption>(
      context: context,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => _buildSortSheet(),
    );

    // chosen is null when the user closes the sheet without picking.
    if (chosen == null) return;

    setState(() => _sortOption = chosen);
    _loadProducts();
  }

  /// Opens the detail screen for the tapped product.
  void _openProductDetail(ProductModel product) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductDetailView(
          productId: product.id,
          // We pass the product we already have so the detail screen can
          // show something immediately instead of an empty spinner.
          initialProduct: product,
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // UI
  // -------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: _loadEverything,
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingMd,
            vertical: AppSizes.paddingSm,
          ),
          // Lets the user pull down to refresh even when the list is short.
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          children: [
            ProductSearchBox(
              controller: _searchController,
              onChanged: _onSearchChanged,
              onClear: _onSearchCleared,
            ),
            const SizedBox(height: AppSizes.paddingMd),

            CategoryChips(
              chips: _chips,
              selectedChip: _selectedChip,
              onChipTap: _onChipTap,
              onClearFilters: _onClearFilters,
            ),
            const SizedBox(height: AppSizes.paddingMd),

            _buildSortRow(),
            const SizedBox(height: AppSizes.paddingLg),

            // Only one of these three is shown at a time.
            _buildProductArea(),
            const SizedBox(height: AppSizes.paddingLg),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.background.withValues(alpha: 0.8),
      elevation: 0,
      centerTitle: true,
      title: const Text(
        AppStrings.appTitle,
        style: AppTextStyles.headlineMedium,
      ),
      leading: IconButton(
        icon: const Icon(Icons.menu, color: AppColors.primary),
        onPressed: () {},
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none, color: AppColors.primary),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(
            Icons.shopping_cart_outlined,
            color: AppColors.primary,
          ),
          onPressed: () {},
        ),
        const SizedBox(width: AppSizes.paddingSm),
      ],
    );
  }

  /// "Sort by: New Arrivals" on the left, "12 items" on the right.
  Widget _buildSortRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: _openSortMenu,
          child: Row(
            children: [
              const Text(
                AppStrings.sortByLabel,
                style: TextStyle(
                  color: AppColors.secondary,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Text(
                _sortOption.label,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.primary,
                size: 18,
              ),
            ],
          ),
        ),
        Text(
          _isLoading ? '' : '${_products.length} items',
          style: const TextStyle(
            color: AppColors.secondary,
            fontFamily: 'Inter',
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  /// The bottom sheet with the four sort choices.
  Widget _buildSortSheet() {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: AppSizes.paddingMd),
          const Text(
            AppStrings.sortSheetTitle,
            style: AppTextStyles.headlineMedium,
          ),
          const SizedBox(height: AppSizes.paddingSm),
          for (final SortOption option in SortOption.all)
            ListTile(
              title: Text(option.label, style: AppTextStyles.bodyMedium),
              // A tick marks the option that is active now.
              trailing: _sortOption.value == option.value
                  ? const Icon(Icons.check, color: AppColors.primary)
                  : null,
              onTap: () => Navigator.pop(context, option),
            ),
          const SizedBox(height: AppSizes.paddingSm),
        ],
      ),
    );
  }

  /// Decides what to show where the grid goes: spinner, error, empty text
  /// or the products.
  Widget _buildProductArea() {
    if (_isLoading) {
      return const LoadingView();
    }

    if (_errorMessage != null) {
      return ErrorView(message: _errorMessage!, onRetry: _loadProducts);
    }

    if (_products.isEmpty) {
      return const EmptyView(message: AppStrings.noProductsFound);
    }

    return _buildProductGrid();
  }

  /// Two products per row.
  Widget _buildProductGrid() {
    return GridView.builder(
      // The grid is inside a ListView, so it must not scroll on its own.
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 32,
        childAspectRatio: 0.64,
      ),
      itemCount: _products.length,
      itemBuilder: (context, index) {
        final ProductModel product = _products[index];

        return ProductCard(
          product: product,
          onTap: () => _openProductDetail(product),
          onFavoriteTap: () {
            // Only a UI change for now. Saving favourites needs the
            // wishlist API, which is another feature branch.
            setState(() => product.isFavorite = !product.isFavorite);
          },
        );
      },
    );
  }
}
