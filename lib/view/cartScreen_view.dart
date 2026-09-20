// lib/view/cartScreen_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:handicraftmobilefrontend/controllers/cart_controller.dart';
import 'package:handicraftmobilefrontend/models/cart_model.dart';
import 'package:handicraftmobilefrontend/utils/app_colors.dart';
import 'package:handicraftmobilefrontend/utils/app_sizes.dart';
import 'package:handicraftmobilefrontend/view/checkout_view.dart';

// ---------------------------------------------------------------------------
// Colors
// ---------------------------------------------------------------------------

const Color _darkText = Color(0xFF231919);
const Color _freeShippingColor = Color(0xFF0B4F52);
const Color _priceSummaryBg = Color(0xFFF8E4E2);
const Color _couponFieldBg = Color(0xFFFFF0EF);
const Color _couponHintColor = Color(0xFF8A7170);
const Color _quantityBg = Color(0xFFE6E2DA);
const Color _dividerColor = Color(0x80DDC0BE);

// ---------------------------------------------------------------------------
// Recommended items (still dummy — replace when API is ready)
// ---------------------------------------------------------------------------

class _RecommendedItem {
  final String title;
  final int price;
  final String imageUrl;

  const _RecommendedItem({
    required this.title,
    required this.price,
    required this.imageUrl,
  });
}

const List<_RecommendedItem> _dummyRecommended = [
  _RecommendedItem(
    title: 'Ceramic Lotus Bowl',
    price: 1800,
    imageUrl: 'https://picsum.photos/seed/lotus/160/160',
  ),
  _RecommendedItem(
    title: 'Traditional Singing Bowl',
    price: 4500,
    imageUrl: 'https://picsum.photos/seed/singingbowl/160/160',
  ),
  _RecommendedItem(
    title: 'Mini Wool Runner',
    price: 15000,
    imageUrl: 'https://picsum.photos/seed/woolrunner/160/160',
  ),
];

// ---------------------------------------------------------------------------
// Cart screen
// ---------------------------------------------------------------------------

class CartScreenView extends StatelessWidget {
  const CartScreenView({super.key});

  CartController get _cart => CartController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background.withOpacity(0.8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'KalaKosh',
          style: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.w600,
            fontSize: 24,
            color: AppColors.primary,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.primary),
            onPressed: () {},
          ),
        ],
      ),
      body: Obx(() {
        // ── Loading ──────────────────────────────────────────────────────────
        if (_cart.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        // ── Error ────────────────────────────────────────────────────────────
        if (_cart.error.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.wifi_off_outlined,
                    size: 48, color: AppColors.secondary),
                const SizedBox(height: 12),
                Text(
                  'Could not load your cart',
                  style: GoogleFonts.inter(color: AppColors.secondary),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9999),
                    ),
                  ),
                  onPressed: _cart.fetchCart,
                  icon: const Icon(Icons.refresh),
                  label: Text('Retry',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          );
        }

        // ── Empty ────────────────────────────────────────────────────────────
        if (_cart.cartItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.shopping_bag_outlined,
                    size: 64, color: AppColors.secondary),
                const SizedBox(height: 16),
                Text(
                  'Your bag is empty',
                  style: GoogleFonts.playfairDisplay(
                    color: AppColors.primary,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Add some items to get started',
                  style: GoogleFonts.inter(
                    color: AppColors.secondary,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.paddingLg,
                      vertical: AppSizes.paddingMd,
                    ),
                  ),
                  onPressed: () => Get.back(),
                  child: Text(
                    'Continue Shopping',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          );
        }

        // ── Content ──────────────────────────────────────────────────────────
        return ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSizes.paddingMd,
            AppSizes.paddingMd,
            AppSizes.paddingMd,
            120,
          ),
          physics: const BouncingScrollPhysics(),
          children: [
            _buildHeader(),
            const SizedBox(height: AppSizes.paddingLg),
            _buildCartItems(),
            const SizedBox(height: AppSizes.paddingLg),
            _buildCouponSection(),
            const SizedBox(height: AppSizes.paddingLg),
            _buildRecommendedSection(),
            const SizedBox(height: AppSizes.paddingLg),
            _buildPriceSummary(),
          ],
        );
      }),
      bottomSheet: _buildCheckoutBar(context),
    );
  }

  // ── Header ─────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Bag',
          style: GoogleFonts.playfairDisplay(
            color: AppColors.primary,
            fontSize: 28,
            fontWeight: FontWeight.w600,
            height: 36 / 28,
          ),
        ),
        const SizedBox(height: 4),
        Obx(() => Text(
              '${_cart.cartItems.length} Items in your collection',
              style: GoogleFonts.inter(
                color: AppColors.secondary,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 24 / 16,
              ),
            )),
      ],
    );
  }

  // ── Cart items ──────────────────────────────────────────────────────────────

  Widget _buildCartItems() {
    return Obx(() => Column(
          children: _cart.cartItems
              .map((item) => Padding(
                    padding:
                        const EdgeInsets.only(bottom: AppSizes.paddingMd),
                    child: _CartItemCard(
                      item: item,
                      imageUrl: _cart.imageUrl(item),
                      onRemove: () => _cart.removeItem(item),
                      onIncrement: () => _cart.incrementQuantity(item),
                      onDecrement: () => _cart.decrementQuantity(item),
                    ),
                  ))
              .toList(),
        ));
  }

  // ── Coupon section ──────────────────────────────────────────────────────────

  Widget _buildCouponSection() {
    final TextEditingController couponController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'APPLY COUPON',
          style: GoogleFonts.inter(
            color: AppColors.secondary,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            letterSpacing: 1.6,
          ),
        ),
        const SizedBox(height: AppSizes.paddingSm),
        Stack(
          alignment: Alignment.centerRight,
          children: [
            TextField(
              controller: couponController,
              style: GoogleFonts.inter(color: _darkText, fontSize: 16),
              decoration: InputDecoration(
                hintText: 'Enter code (e.g. NAMASTE20)',
                hintStyle: GoogleFonts.inter(
                  color: _couponHintColor,
                  fontSize: 16,
                ),
                filled: true,
                fillColor: _couponFieldBg,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingLg,
                  vertical: 18,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9999),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingLg,
                    vertical: AppSizes.paddingSm,
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  // TODO: apply coupon API
                },
                child: Text(
                  'Apply',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ── Recommended section ─────────────────────────────────────────────────────

  Widget _buildRecommendedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recommended for You',
          style: GoogleFonts.playfairDisplay(
            color: AppColors.primary,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 24 / 16,
          ),
        ),
        const SizedBox(height: AppSizes.paddingMd),
        SizedBox(
          height: 232,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: _dummyRecommended.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              return _RecommendedCard(item: _dummyRecommended[index]);
            },
          ),
        ),
      ],
    );
  }

  // ── Price summary ───────────────────────────────────────────────────────────

  Widget _buildPriceSummary() {
    return Obx(() => Container(
          padding: const EdgeInsets.all(AppSizes.paddingLg),
          decoration: BoxDecoration(
            color: _priceSummaryBg,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: const Color(0x4DDDC0BE), width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PRICE SUMMARY',
                style: GoogleFonts.inter(
                  color: AppColors.secondary,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.6,
                ),
              ),
              const SizedBox(height: AppSizes.paddingMd),
              _PriceLine(
                label: 'Subtotal',
                value: 'रू ${_formatPrice(_cart.subtotal)}',
              ),
              const SizedBox(height: AppSizes.paddingSm),
              _PriceLine(
                label: 'Shipping',
                value: 'FREE',
                valueColor: _freeShippingColor,
              ),
              const SizedBox(height: AppSizes.paddingSm),
              _PriceLine(
                label: 'Taxes (VAT)',
                value: 'रू ${_formatPrice(_cart.tax)}',
              ),
              const SizedBox(height: AppSizes.paddingSm),
              Divider(color: _dividerColor, thickness: 1),
              const SizedBox(height: AppSizes.paddingSm),
              _PriceLine(
                label: 'Total',
                value: 'रू ${_formatPrice(_cart.total)}',
                labelStyle: GoogleFonts.playfairDisplay(
                  color: _darkText,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                valueStyle: GoogleFonts.playfairDisplay(
                  color: AppColors.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ));
  }

  // ── Checkout bar ────────────────────────────────────────────────────────────

  Widget _buildCheckoutBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: AppSizes.paddingLg,
        right: AppSizes.paddingLg,
        top: AppSizes.paddingMd,
        bottom: MediaQuery.of(context).padding.bottom + AppSizes.paddingMd,
      ),
      decoration: BoxDecoration(
        color: AppColors.background.withOpacity(0.9),
        border: const Border(
          top: BorderSide(color: Color(0x33DDC0BE), width: 1),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9999),
            ),
            padding:
                const EdgeInsets.symmetric(vertical: AppSizes.paddingMd),
            elevation: 4,
            shadowColor: Colors.black.withOpacity(0.15),
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CheckoutView()),
          ),
          icon: const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
          label: Text(
            'Proceed to Checkout',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              height: 28 / 18,
            ),
          ),
        ),
      ),
    );
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
  }
}

// ---------------------------------------------------------------------------
// Cart item card — uses CartItemModel from controller
// ---------------------------------------------------------------------------

class _CartItemCard extends StatelessWidget {
  final CartItemModel item;
  final String imageUrl;
  final VoidCallback onRemove;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const _CartItemCard({
    required this.item,
    required this.imageUrl,
    required this.onRemove,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0x1ADDC0BE), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: imageUrl.isEmpty
                ? Container(
                    width: 96,
                    height: 96,
                    color: AppColors.surfaceContainerLow,
                    child: const Icon(Icons.image_not_supported_outlined,
                        color: AppColors.secondary),
                  )
                : Image.network(
                    imageUrl,
                    width: 96,
                    height: 96,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 96,
                      height: 96,
                      color: AppColors.surfaceContainerLow,
                      child: const Icon(Icons.image_not_supported_outlined,
                          color: AppColors.secondary),
                    ),
                  ),
          ),
          const SizedBox(width: AppSizes.paddingMd),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title + delete
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        item.title ?? '',
                        style: GoogleFonts.playfairDisplay(
                          color: AppColors.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          height: 22.5 / 18,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: onRemove,
                      child: const Icon(Icons.delete_outline,
                          color: AppColors.secondary, size: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // Subtitle
                Text(
                  item.subtitle ?? '',
                  style: GoogleFonts.inter(
                    color: AppColors.secondary,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 24 / 16,
                  ),
                ),
                const SizedBox(height: 8),
                // Price + quantity
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'रू ${(item.price ?? 0).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}',
                      style: GoogleFonts.playfairDisplay(
                        color: AppColors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 24 / 16,
                      ),
                    ),
                    _QuantityControl(
                      quantity: item.quantity ?? 1,
                      onIncrement: onIncrement,
                      onDecrement: onDecrement,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Quantity control
// ---------------------------------------------------------------------------

class _QuantityControl extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const _QuantityControl({
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _quantityBg,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: onDecrement,
            child: Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: const Icon(Icons.remove,
                  size: 16, color: AppColors.secondary),
            ),
          ),
          const SizedBox(width: 4),
          Text(
            '$quantity',
            style: GoogleFonts.inter(
              color: _darkText,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 24 / 16,
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onIncrement,
            child: Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: const Icon(Icons.add,
                  size: 16, color: AppColors.secondary),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Recommended card
// ---------------------------------------------------------------------------

class _RecommendedCard extends StatelessWidget {
  final _RecommendedItem item;

  const _RecommendedCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.network(
                  item.imageUrl,
                  width: 160,
                  height: 160,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 160,
                    height: 160,
                    color: AppColors.surfaceContainerLow,
                    child: const Icon(Icons.image_not_supported_outlined,
                        color: AppColors.secondary),
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () {
                    // TODO: add recommended item to cart
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.background.withOpacity(0.9),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.add,
                        color: AppColors.primary, size: 18),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            item.title,
            style: GoogleFonts.inter(
              color: _darkText,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 24 / 16,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            'रू ${item.price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}',
            style: GoogleFonts.inter(
              color: AppColors.primary,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 24 / 16,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Price line
// ---------------------------------------------------------------------------

class _PriceLine extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;

  const _PriceLine({
    required this.label,
    required this.value,
    this.valueColor,
    this.labelStyle,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: labelStyle ??
              GoogleFonts.inter(
                color: _darkText,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 24 / 16,
              ),
        ),
        Text(
          value,
          style: valueStyle ??
              GoogleFonts.inter(
                color: valueColor ?? _darkText,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 24 / 16,
              ),
        ),
      ],
    );
  }
}