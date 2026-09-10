

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:handicraftmobilefrontend/utils/app_colors.dart';
import 'package:handicraftmobilefrontend/utils/app_sizes.dart';



class CartItem {
  final String title;
  final String subtitle;
  final String imageUrl;
  final int price;
  int quantity;

  CartItem({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.price,
    this.quantity = 1,
  });
}

class RecommendedItem {
  final String title;
  final int price;
  final String imageUrl;

  const RecommendedItem({
    required this.title,
    required this.price,
    required this.imageUrl,
  });
}

// ---------------------------------------------------------------------------
// Dummy data
// ---------------------------------------------------------------------------

final List<CartItem> dummyCartItems = [
  CartItem(
    title: 'Hand-Carved Cedar Ganesh',
    subtitle: 'Authentic Newari Craft',
    imageUrl: 'https://picsum.photos/seed/ganesh/96/96',
    price: 12500,
  ),
  CartItem(
    title: 'Pure Cashmere Wrap',
    subtitle: 'Natural Fiber • Soft Ivory',
    imageUrl: 'https://picsum.photos/seed/cashmere/96/96',
    price: 8200,
  ),
];

const List<RecommendedItem> dummyRecommended = [
  RecommendedItem(
    title: 'Ceramic Lotus Bowl',
    price: 1800,
    imageUrl: 'https://picsum.photos/seed/lotus/160/160',
  ),
  RecommendedItem(
    title: 'Traditional Singing Bowl',
    price: 4500,
    imageUrl: 'https://picsum.photos/seed/singingbowl/160/160',
  ),
  RecommendedItem(
    title: 'Mini Wool Runner',
    price: 15000,
    imageUrl: 'https://picsum.photos/seed/woolrunner/160/160',
  ),
];

// ---------------------------------------------------------------------------
// Colors from design not in AppColors
// ---------------------------------------------------------------------------

const Color _darkText = Color(0xFF231919);
const Color _freeShippingColor = Color(0xFF0B4F52);
const Color _priceSummaryBg = Color(0xFFF8E4E2);
const Color _couponFieldBg = Color(0xFFFFF0EF);
const Color _couponHintColor = Color(0xFF8A7170);
const Color _quantityBg = Color(0xFFE6E2DA);
const Color _dividerColor = Color(0x80DDC0BE); // 50% opacity

// ---------------------------------------------------------------------------
// Cart View
// ---------------------------------------------------------------------------

class CartScreenView extends StatefulWidget {
  const CartScreenView({super.key});

  @override
  State<CartScreenView> createState() => _CartScreenViewState();  
}

class _CartScreenViewState extends State<CartScreenView> {
  final List<CartItem> _cartItems = dummyCartItems;
  final TextEditingController _couponController = TextEditingController();

  int get _subtotal =>
      _cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);

  int get _tax => (_subtotal * 0.13).round(); // 13% VAT

  int get _total => _subtotal + _tax;

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background.withOpacity(0.8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: AppColors.primary),
          onPressed: () {},
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
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSizes.paddingMd,
          AppSizes.paddingMd,
          AppSizes.paddingMd,
          120, // clears the checkout button
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
      ),
      // Checkout button floats at bottom
      bottomSheet: _buildCheckoutBar(),
    );
  }

  // ── Header ────────────────────────────────────────────────────────────────

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
        Text(
          '${_cartItems.length} Items in your collection',
          style: GoogleFonts.inter(
            color: AppColors.secondary,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 24 / 16,
          ),
        ),
      ],
    );
  }

  // ── Cart items list ───────────────────────────────────────────────────────

  Widget _buildCartItems() {
    return Column(
      children: _cartItems
          .map((item) => Padding(
                padding: const EdgeInsets.only(bottom: AppSizes.paddingMd),
                child: _CartItemCard(
                  item: item,
                  onRemove: () => setState(() => _cartItems.remove(item)),
                  onIncrement: () => setState(() => item.quantity++),
                  onDecrement: () => setState(() {
                    if (item.quantity > 1) item.quantity--;
                  }),
                ),
              ))
          .toList(),
    );
  }

  // ── Coupon section ────────────────────────────────────────────────────────

  Widget _buildCouponSection() {
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
            // Input field
            TextField(
              controller: _couponController,
              style: GoogleFonts.inter(
                color: _darkText,
                fontSize: 16,
              ),
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
            // Apply button overlaid on right
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
                  // TODO: apply coupon
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

  // ── Recommended section ───────────────────────────────────────────────────

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
            itemCount: dummyRecommended.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              return _RecommendedCard(item: dummyRecommended[index]);
            },
          ),
        ),
      ],
    );
  }

  // ── Price summary ─────────────────────────────────────────────────────────

  Widget _buildPriceSummary() {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingLg),
      decoration: BoxDecoration(
        color: _priceSummaryBg,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: const Color(0x4DDDC0BE),
          width: 1,
        ),
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
          _PriceLine(label: 'Subtotal', value: 'रू ${_formatPrice(_subtotal)}'),
          const SizedBox(height: AppSizes.paddingSm),
          _PriceLine(
            label: 'Shipping',
            value: 'FREE',
            valueColor: _freeShippingColor,
          ),
          const SizedBox(height: AppSizes.paddingSm),
          _PriceLine(
            label: 'Taxes (VAT)',
            value: 'रू ${_formatPrice(_tax)}',
          ),
          const SizedBox(height: AppSizes.paddingSm),
          Divider(color: _dividerColor, thickness: 1),
          const SizedBox(height: AppSizes.paddingSm),
          _PriceLine(
            label: 'Total',
            value: 'रू ${_formatPrice(_total)}',
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
    );
  }

  // ── Checkout bar ──────────────────────────────────────────────────────────

  Widget _buildCheckoutBar() {
    return Container(
      padding: EdgeInsets.only(
        left: AppSizes.paddingLg,
        right: AppSizes.paddingLg,
        top: AppSizes.paddingMd,
        bottom: MediaQuery.of(context).padding.bottom + AppSizes.paddingMd,
      ),
      decoration: BoxDecoration(
        color: AppColors.background.withOpacity(0.9),
        border: Border(
          top: BorderSide(
            color: const Color(0x33DDC0BE),
            width: 1,
          ),
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
            padding: const EdgeInsets.symmetric(vertical: AppSizes.paddingMd),
            elevation: 4,
            shadowColor: Colors.black.withOpacity(0.15),
          ),
          onPressed: () {
            // TODO: navigate to checkout
          },
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
// Cart item card
// ---------------------------------------------------------------------------

class _CartItemCard extends StatelessWidget {
  final CartItem item;
  final VoidCallback onRemove;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const _CartItemCard({
    required this.item,
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
            child: Image.network(
              item.imageUrl,
              width: 96,
              height: 96,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 96,
                height: 96,
                color: AppColors.surfaceContainerLow,
                child: const Icon(
                  Icons.image_not_supported_outlined,
                  color: AppColors.secondary,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSizes.paddingMd),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Title row + delete
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
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
                      child: const Icon(
                        Icons.delete_outline,
                        color: AppColors.secondary,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // Subtitle
                Text(
                  item.subtitle,
                  style: GoogleFonts.inter(
                    color: AppColors.secondary,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 24 / 16,
                  ),
                ),
                const SizedBox(height: 8),
                // Price + quantity row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'रू ${item.price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}',
                      style: GoogleFonts.playfairDisplay(
                        color: AppColors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 24 / 16,
                      ),
                    ),
                    _QuantityControl(
                      quantity: item.quantity,
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
// Quantity control (– count +)
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
              child: const Icon(Icons.remove, size: 16, color: AppColors.secondary),
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
              child: const Icon(Icons.add, size: 16, color: AppColors.secondary),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Recommended product card (horizontal scroll)
// ---------------------------------------------------------------------------

class _RecommendedCard extends StatelessWidget {
  final RecommendedItem item;

  const _RecommendedCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with add-to-cart overlay button
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
                    child: const Icon(
                      Icons.image_not_supported_outlined,
                      color: AppColors.secondary,
                    ),
                  ),
                ),
              ),
              // Add button (bottom-right)
              Positioned(
                bottom: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () {
                    // TODO: add to cart
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
                    child: const Icon(
                      Icons.add,
                      color: AppColors.primary,
                      size: 18,
                    ),
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
// Price summary row
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