// lib/view/product_details_view.dart
//
// The product detail screen. It is opened when the user taps a product
// card in the shop screen.
//
// It receives the product id, then asks the backend for the full details
// with GET /api/products/:id.

import 'package:flutter/material.dart';
import 'package:handicraftmobilefrontend/models/product_model.dart';
import 'package:handicraftmobilefrontend/services/product_service.dart';
import 'package:handicraftmobilefrontend/utils/api_error.dart';
import 'package:handicraftmobilefrontend/utils/app_colors.dart';
import 'package:handicraftmobilefrontend/utils/app_sizes.dart';
import 'package:handicraftmobilefrontend/utils/app_strings.dart';
import 'package:handicraftmobilefrontend/utils/app_text_styles.dart';
import 'package:handicraftmobilefrontend/widgets/add_to_cart_bar.dart';
import 'package:handicraftmobilefrontend/widgets/product_gallery.dart';
import 'package:handicraftmobilefrontend/widgets/specification_row.dart';
import 'package:handicraftmobilefrontend/widgets/status_view.dart';

class ProductDetailView extends StatefulWidget {
  // Id of the product we want to show.
  final String? productId;

  // The product the shop screen already had. We show it right away so the
  // screen does not look empty while the full details load.
  final ProductModel? initialProduct;

  // True only when this screen is a tab inside MainLayoutView.
  final bool showBottomNav;

  const ProductDetailView({
    super.key,
    this.productId,
    this.initialProduct,
    this.showBottomNav = false,
  });

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  final ProductService _productService = ProductService();

  // ----- Data -----
  ProductModel? _product;

  // ----- Screen state -----
  bool _isLoading = true;
  String? _errorMessage;

  // ----- User choices -----
  bool _isFavorite = false;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();

    // Start with whatever the shop screen gave us (can be null).
    _product = widget.initialProduct;
    _isFavorite = widget.initialProduct?.isFavorite ?? false;

    _loadProduct();
  }

  // -------------------------------------------------------------------------
  // API call
  // -------------------------------------------------------------------------

  Future<void> _loadProduct() async {
    setState(() {
      // Show the big spinner only when we have nothing to display yet.
      _isLoading = _product == null;
      _errorMessage = null;
    });

    try {
      final ProductModel? product = await _fetchProduct();

      if (!mounted) return;

      setState(() {
        if (product != null) _product = product;
        _isLoading = false;

        if (_product == null) {
          _errorMessage = AppStrings.productNotFound;
        }
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;

        // If we already show the product from the shop screen, a failed
        // refresh is not worth an error message.
        if (_product == null) {
          _errorMessage = apiErrorMessage(
            error,
            fallback: AppStrings.loadProductError,
          );
        }
      });
    }
  }

  /// Gets the product to display.
  /// Normally we have an id. When this screen is used as a tab there is no
  /// id, so we show the first featured product instead.
  Future<ProductModel?> _fetchProduct() async {
    final String id = widget.productId ?? '';

    if (id.isNotEmpty) {
      return _productService.getProductById(id);
    }

    if (_product != null) {
      return _product;
    }

    final List<ProductModel> featured = await _productService
        .getFeaturedProducts();
    if (featured.isNotEmpty) {
      return featured.first;
    }

    final result = await _productService.getProducts(limit: 1);
    if (result.products.isNotEmpty) {
      return result.products.first;
    }

    return null;
  }

  // -------------------------------------------------------------------------
  // User actions
  // -------------------------------------------------------------------------

  void _onAddToCart() {
    // The cart API belongs to another feature branch, so for now we only
    // confirm the action with a small message.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.primary,
        content: Text('${_product?.name ?? 'Product'} x $_quantity added'),
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
      body: _buildBody(),
      bottomNavigationBar: widget.showBottomNav ? _buildBottomNav() : null,
    );
  }

  AppBar _buildAppBar() {
    // canPop is false when this screen is a tab (there is nothing to go back to).
    final bool canPop = Navigator.of(context).canPop();

    return AppBar(
      backgroundColor: AppColors.background.withValues(alpha: 0.85),
      elevation: 0,
      centerTitle: true,
      title: const Text(
        AppStrings.appTitle,
        style: AppTextStyles.headlineMedium,
      ),
      leading: IconButton(
        icon: Icon(
          canPop ? Icons.arrow_back_ios : Icons.menu,
          color: AppColors.primary,
          size: 22,
        ),
        onPressed: canPop ? () => Navigator.of(context).pop() : () {},
      ),
      actions: [
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

  Widget _buildBody() {
    if (_isLoading) {
      return const LoadingView();
    }

    // We failed and we have nothing to show.
    if (_product == null) {
      return ErrorView(
        message: _errorMessage ?? AppStrings.loadProductError,
        onRetry: _loadProduct,
      );
    }

    final ProductModel product = _product!;

    return Column(
      children: [
        // The scrolling part of the page.
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              ProductGallery(
                images: product.allImages,
                isFavorite: _isFavorite,
                onFavoriteTap: () {
                  setState(() => _isFavorite = !_isFavorite);
                },
              ),
              Padding(
                padding: const EdgeInsets.all(AppSizes.paddingMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitleAndPrice(product),
                    const SizedBox(height: AppSizes.paddingXs),
                    _buildRatingStars(product),
                    const SizedBox(height: AppSizes.paddingLg),
                    _buildDescription(product),
                    const SizedBox(height: AppSizes.paddingLg),
                    _buildSpecifications(product),
                  ],
                ),
              ),
            ],
          ),
        ),

        // The bar that always stays at the bottom.
        AddToCartBar(
          quantity: _quantity,
          onIncrease: () => setState(() => _quantity++),
          onDecrease: () {
            // Never go below one item.
            if (_quantity > 1) setState(() => _quantity--);
          },
          onAddToCart: _onAddToCart,
        ),
      ],
    );
  }

  /// Product name on the left, price on the right.
  Widget _buildTitleAndPrice(ProductModel product) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            product.name,
            style: const TextStyle(
              fontFamily: 'Playfair Display',
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
              height: 1.2,
            ),
          ),
        ),
        const SizedBox(width: AppSizes.paddingSm),
        Text(product.priceText, style: AppTextStyles.headlineMedium),
      ],
    );
  }

  /// Five stars plus the rating number, for example 4.5 -> 4 full stars,
  /// 1 half star.
  Widget _buildRatingStars(ProductModel product) {
    return Row(
      children: [
        for (int position = 1; position <= 5; position++)
          Icon(
            _starIcon(product.rating, position),
            color: const Color(0xFFFFB300),
            size: 18,
          ),
        const SizedBox(width: AppSizes.paddingSm),
        Text(
          product.ratingText,
          style: const TextStyle(
            color: AppColors.secondary,
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }

  /// Picks the icon for one star.
  IconData _starIcon(double rating, int position) {
    if (rating >= position) return Icons.star;
    if (rating >= position - 0.5) return Icons.star_half;
    return Icons.star_border;
  }

  Widget _buildDescription(ProductModel product) {
    // Some products in the database have no description yet.
    final String text = product.description.isEmpty
        ? AppStrings.defaultDescription
        : product.description;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(AppStrings.descriptionTitle),
        const SizedBox(height: AppSizes.paddingSm),
        Text(
          text,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            color: AppColors.secondary,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  /// The small table with material, region, craft type and stock.
  Widget _buildSpecifications(ProductModel product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(AppStrings.detailsTitle),
        const SizedBox(height: AppSizes.paddingSm),
        SpecificationRow(
          label: AppStrings.materialLabel,
          value: product.material,
        ),
        SpecificationRow(label: AppStrings.regionLabel, value: product.region),
        SpecificationRow(
          label: AppStrings.craftTypeLabel,
          value: product.craftType,
        ),
        // The category only exists when the backend sent it.
        if (product.categoryName.isNotEmpty)
          SpecificationRow(
            label: AppStrings.categoryLabel,
            value: product.categoryName,
          ),
        SpecificationRow(
          label: AppStrings.stockLabel,
          value: '${product.stock}',
          showDivider: false,
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'Playfair Display',
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.textDark,
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: 1,
      backgroundColor: AppColors.background,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.secondary,
      type: BottomNavigationBarType.fixed,
      onTap: (_) {},
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.local_mall), label: 'Details'),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined),
          label: 'Profile',
        ),
      ],
    );
  }
}
