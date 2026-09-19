// lib/views/checkout_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:handicraftmobilefrontend/utils/app_colors.dart';
import 'package:handicraftmobilefrontend/utils/app_sizes.dart';

// ---------------------------------------------------------------------------
// Colors from design
// ---------------------------------------------------------------------------

const Color _darkText = Color(0xFF231919);
const Color _cardShadowColor = Color(0x14E50510); // rgba(92,5,16,0.08)
const Color _dividerColor = Color(0x4DDDC0BE);
const Color _promoFieldBg = Color(0xFF6B7280);
const Color _applyBtnBg = Color(0xFFE6E2DA);
const Color _applyBtnText = Color(0xFF66645E);
const Color _orderSummaryBg = Color(0xFFF8E4E2);
const Color _selectedAddressBg = Color(0xFFFFF8F7);
const Color _unselectedAddressBg = Color(0x80FFFFFF);

// ---------------------------------------------------------------------------
// Data models
// ---------------------------------------------------------------------------

class Address {
  final String label;
  final String name;
  final String addressLine;
  final String phone;
  final bool isDefault;

  const Address({
    required this.label,
    required this.name,
    required this.addressLine,
    this.phone = '',
    this.isDefault = false,
  });
}

class DeliveryOption {
  final String name;
  final int price;
  final String description;

  const DeliveryOption({
    required this.name,
    required this.price,
    required this.description,
  });
}

class OrderItem {
  final String title;
  final String subtitle;
  final String imageUrl;
  final int quantity;
  final int price;

  const OrderItem({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.quantity,
    required this.price,
  });
}

// ---------------------------------------------------------------------------
// Dummy data
// ---------------------------------------------------------------------------

const List<Address> _addresses = [
  Address(
    label: 'Home',
    name: 'Aarya Sharma',
    addressLine: 'House No. 42, Dhobighat Street\nLalitpur 44700, Nepal',
    phone: '+977 9841234567',
    isDefault: true,
  ),
  Address(
    label: 'Workspace',
    name: 'Workspace',
    addressLine: 'Durbar Marg, Heritage Plaza\nKathmandu 44600, Nepal',
    isDefault: false,
  ),
];

const List<DeliveryOption> _deliveryOptions = [
  DeliveryOption(
    name: 'Standard',
    price: 150,
    description: '3 - 5 business days delivery',
  ),
  DeliveryOption(
    name: 'Express',
    price: 450,
    description: 'Next day delivery in KTM Valley',
  ),
];

const List<OrderItem> _orderItems = [
  OrderItem(
    title: 'Hand-carved Mandala Platter',
    subtitle: 'Authentic Teak Wood',
    imageUrl: 'https://picsum.photos/seed/mandala/80/80',
    quantity: 1,
    price: 12500,
  ),
  OrderItem(
    title: 'Pure Pashmina Shawl',
    subtitle: 'Maroon / Hand-loomed',
    imageUrl: 'https://picsum.photos/seed/pashmina/80/80',
    quantity: 1,
    price: 8200,
  ),
];

const List<Map<String, String>> _paymentMethods = [
  {'name': 'eSewa', 'icon': 'esewa'},
  {'name': 'Khalti', 'icon': 'khalti'},
  {'name': 'IME Pay', 'icon': 'imepay'},
];

// ---------------------------------------------------------------------------
// Checkout View
// ---------------------------------------------------------------------------

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  int _selectedAddressIndex = 0;
  int _selectedDeliveryIndex = 0;
  int _selectedPaymentIndex = -1; // -1 = none, 3 = card, 4 = COD
  final TextEditingController _promoController = TextEditingController();

  int get _subtotal =>
      _orderItems.fold(0, (sum, item) => sum + item.price * item.quantity);

  int get _shippingFee => _deliveryOptions[_selectedDeliveryIndex].price;

  int get _tax => (_subtotal * 0.13).round();

  int get _total => _subtotal + _shippingFee + _tax;

  @override
  void dispose() {
    _promoController.dispose();
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
            icon: const Icon(Icons.shopping_bag_outlined,
                color: AppColors.primary),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person_outline, color: AppColors.primary),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSizes.paddingMd,
          AppSizes.paddingMd,
          AppSizes.paddingMd,
          120,
        ),
        physics: const BouncingScrollPhysics(),
        children: [
          _buildShippingAddress(),
          const SizedBox(height: 40),
          _buildDeliveryOptions(),
          const SizedBox(height: 40),
          _buildPaymentMethod(),
          const SizedBox(height: 40),
          _buildOrderSummary(),
          const SizedBox(height: AppSizes.paddingMd),
          _buildSecurePaymentNote(),
        ],
      ),
      bottomSheet: _buildPlaceOrderBar(),
    );
  }

  // ── Shipping Address ──────────────────────────────────────────────────────

  Widget _buildShippingAddress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Shipping Address',
              style: GoogleFonts.playfairDisplay(
                color: _darkText,
                fontSize: 24,
                fontWeight: FontWeight.w600,
                height: 32 / 24,
              ),
            ),
            GestureDetector(
              onTap: () {
                // TODO: add new address
              },
              child: Row(
                children: [
                  const Icon(Icons.add, color: AppColors.primary, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    'Add New',
                    style: GoogleFonts.inter(
                      color: AppColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.paddingMd),
        Column(
          children: List.generate(
            _addresses.length,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: AppSizes.paddingMd),
              child: _AddressCard(
                address: _addresses[index],
                isSelected: _selectedAddressIndex == index,
                onTap: () => setState(() => _selectedAddressIndex = index),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── Delivery Options ──────────────────────────────────────────────────────

  Widget _buildDeliveryOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Delivery Options',
          style: GoogleFonts.playfairDisplay(
            color: _darkText,
            fontSize: 24,
            fontWeight: FontWeight.w600,
            height: 32 / 24,
          ),
        ),
        const SizedBox(height: AppSizes.paddingMd),
        Column(
          children: List.generate(
            _deliveryOptions.length,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: AppSizes.paddingMd),
              child: _DeliveryOptionCard(
                option: _deliveryOptions[index],
                isSelected: _selectedDeliveryIndex == index,
                onTap: () =>
                    setState(() => _selectedDeliveryIndex = index),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── Payment Method ────────────────────────────────────────────────────────

  Widget _buildPaymentMethod() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Method',
          style: GoogleFonts.playfairDisplay(
            color: _darkText,
            fontSize: 24,
            fontWeight: FontWeight.w600,
            height: 32 / 24,
          ),
        ),
        const SizedBox(height: AppSizes.paddingMd),
        // Digital wallets row
        Row(
          children: List.generate(
            _paymentMethods.length,
            (index) => Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: index < _paymentMethods.length - 1 ? 12 : 0,
                ),
                child: _PaymentWalletCard(
                  name: _paymentMethods[index]['name']!,
                  isSelected: _selectedPaymentIndex == index,
                  onTap: () => setState(() => _selectedPaymentIndex = index),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSizes.paddingSm),
        // Card option
        _PaymentOptionRow(
          icon: Icons.credit_card_outlined,
          label: 'Credit / Debit Card',
          isSelected: _selectedPaymentIndex == 3,
          onTap: () => setState(() => _selectedPaymentIndex = 3),
          trailing: const Icon(Icons.credit_card,
              color: _darkText, size: 22, semanticLabel: 'Card'),
        ),
        const SizedBox(height: AppSizes.paddingSm),
        // COD option
        _PaymentOptionRow(
          icon: Icons.local_shipping_outlined,
          label: 'Cash on Delivery',
          isSelected: _selectedPaymentIndex == 4,
          onTap: () => setState(() => _selectedPaymentIndex = 4),
        ),
      ],
    );
  }

  // ── Order Summary ─────────────────────────────────────────────────────────

  Widget _buildOrderSummary() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: const Color(0xFFF8E4E2), width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.08),
            blurRadius: 40,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: GoogleFonts.playfairDisplay(
              color: _darkText,
              fontSize: 24,
              fontWeight: FontWeight.w600,
              height: 32 / 24,
            ),
          ),
          const SizedBox(height: AppSizes.paddingLg),
          // Order items
          Column(
            children: _orderItems
                .map((item) => Padding(
                      padding:
                          const EdgeInsets.only(bottom: AppSizes.paddingLg),
                      child: _OrderItemRow(item: item),
                    ))
                .toList(),
          ),
          // Price breakdown
          Container(
            padding: const EdgeInsets.only(top: 32),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: _dividerColor, width: 1),
              ),
            ),
            child: Column(
              children: [
                _SummaryLine(
                  label: 'Subtotal',
                  value: 'NPR ${_formatPrice(_subtotal)}',
                ),
                const SizedBox(height: AppSizes.paddingSm),
                _SummaryLine(
                  label: 'Shipping Fee',
                  value: 'NPR ${_formatPrice(_shippingFee)}',
                ),
                const SizedBox(height: AppSizes.paddingSm),
                _SummaryLine(
                  label: 'Tax (VAT 13%)',
                  value: 'NPR ${_formatPrice(_tax)}',
                ),
                const SizedBox(height: AppSizes.paddingMd),
                Container(
                  padding: const EdgeInsets.only(top: AppSizes.paddingMd),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Color(0x80DDC0BE),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Amount',
                        style: GoogleFonts.inter(
                          color: _darkText,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          height: 24 / 16,
                        ),
                      ),
                      Text(
                        'NPR ${_formatPrice(_total)}',
                        style: GoogleFonts.playfairDisplay(
                          color: AppColors.primary,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          height: 32 / 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.paddingMd),
          // Promo code
          _buildPromoField(),
        ],
      ),
    );
  }

  Widget _buildPromoField() {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        TextField(
          controller: _promoController,
          style: GoogleFonts.inter(color: _darkText, fontSize: 16),
          decoration: InputDecoration(
            hintText: 'Promo code',
            hintStyle: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
              fontSize: 16,
            ),
            filled: true,
            fillColor: AppColors.background,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSizes.paddingLg,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9999),
              borderSide: const BorderSide(color: Color(0xFFDDC0BE)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9999),
              borderSide: const BorderSide(color: Color(0xFFDDC0BE)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: _applyBtnBg,
              foregroundColor: _applyBtnText,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9999),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingMd,
                vertical: 6,
              ),
            ),
            onPressed: () {
              // TODO: apply promo
            },
            child: Text(
              'Apply',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: _applyBtnText,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── Secure payment note ───────────────────────────────────────────────────

  Widget _buildSecurePaymentNote() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.lock_outline, color: AppColors.secondary, size: 16),
        const SizedBox(width: AppSizes.paddingSm),
        Text(
          'ENCRYPTED SECURE PAYMENT',
          style: GoogleFonts.inter(
            color: AppColors.secondary,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.6,
          ),
        ),
      ],
    );
  }

  // ── Place order bar ───────────────────────────────────────────────────────

  Widget _buildPlaceOrderBar() {
    return Container(
      padding: EdgeInsets.only(
        left: AppSizes.paddingMd,
        right: AppSizes.paddingMd,
        top: AppSizes.paddingLg,
        bottom: MediaQuery.of(context).padding.bottom + AppSizes.paddingLg,
      ),
      decoration: BoxDecoration(
        color: AppColors.background.withOpacity(0.9),
        border: const Border(
          top: BorderSide(color: Color(0x4DDDC0BE), width: 1),
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
            padding: const EdgeInsets.symmetric(vertical: AppSizes.paddingLg),
            elevation: 0,
          ),
          onPressed: () {
            // TODO: place order
          },
          icon: const Icon(Icons.arrow_forward, color: Colors.white, size: 16),
          label: Text(
            'Place Order & Pay',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              height: 24 / 16,
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
// Address card
// ---------------------------------------------------------------------------

class _AddressCard extends StatelessWidget {
  final Address address;
  final bool isSelected;
  final VoidCallback onTap;

  const _AddressCard({
    required this.address,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSizes.paddingLg),
        decoration: BoxDecoration(
          color: isSelected ? _selectedAddressBg : _unselectedAddressBg,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? AppColors.primary : const Color(0xFFDDC0BE),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.08),
                    blurRadius: 40,
                    offset: const Offset(0, 10),
                  ),
                ]
              : [],
        ),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  isSelected ? Icons.location_on : Icons.location_on_outlined,
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.secondary,
                  size: 20,
                ),
                const SizedBox(width: AppSizes.paddingMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        address.name,
                        style: GoogleFonts.inter(
                          color: _darkText,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          height: 24 / 16,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        address.addressLine +
                            (address.phone.isNotEmpty
                                ? '\n${address.phone}'
                                : ''),
                        style: GoogleFonts.inter(
                          color: AppColors.secondary,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 22.75 / 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (address.isDefault)
              Positioned(
                top: -AppSizes.paddingLg,
                right: -AppSizes.paddingLg,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingMd,
                    vertical: 4,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(22),
                      bottomLeft: Radius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Default',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 24 / 16,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Delivery option card
// ---------------------------------------------------------------------------

class _DeliveryOptionCard extends StatelessWidget {
  final DeliveryOption option;
  final bool isSelected;
  final VoidCallback onTap;

  const _DeliveryOptionCard({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSizes.paddingLg),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFDDC0BE), width: 1),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        option.name,
                        style: GoogleFonts.inter(
                          color: _darkText,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          height: 24 / 16,
                        ),
                      ),
                      Text(
                        'NPR ${option.price}',
                        style: GoogleFonts.inter(
                          color: AppColors.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          height: 24 / 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.paddingSm),
                  Text(
                    option.description,
                    style: GoogleFonts.inter(
                      color: AppColors.secondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      height: 16 / 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSizes.paddingMd),
            // Radio button
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.primary
                      : const Color(0xFFDDC0BE),
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Center(
                      child: CircleAvatar(
                        radius: 4,
                        backgroundColor: Colors.white,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Payment wallet card (eSewa, Khalti, IME Pay)
// ---------------------------------------------------------------------------

class _PaymentWalletCard extends StatelessWidget {
  final String name;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentWalletCard({
    required this.name,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSizes.paddingMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : const Color(0xFFDDC0BE),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: _orderSummaryBg,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.account_balance_wallet_outlined,
                color: AppColors.primary,
                size: 24,
              ),
            ),
            const SizedBox(height: AppSizes.paddingSm),
            Text(
              name,
              style: GoogleFonts.inter(
                color: _darkText,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                height: 16 / 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Payment option row (card, COD)
// ---------------------------------------------------------------------------

class _PaymentOptionRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Widget? trailing;

  const _PaymentOptionRow({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSizes.paddingLg),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFDDC0BE), width: 1),
        ),
        child: Row(
          children: [
            // Radio
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.primary
                      : const Color(0xFFDDC0BE),
                  width: 1,
                ),
              ),
              child: isSelected
                  ? const Center(
                      child: CircleAvatar(
                        radius: 4,
                        backgroundColor: Colors.white,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: AppSizes.paddingMd),
            Icon(icon, color: AppColors.secondary, size: 20),
            const SizedBox(width: AppSizes.paddingSm),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.inter(
                  color: _darkText,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 24 / 16,
                ),
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Order item row inside summary card
// ---------------------------------------------------------------------------

class _OrderItemRow extends StatelessWidget {
  final OrderItem item;

  const _OrderItemRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            item.imageUrl,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              width: 80,
              height: 80,
              color: _orderSummaryBg,
              child: const Icon(Icons.image_not_supported_outlined,
                  color: AppColors.secondary),
            ),
          ),
        ),
        const SizedBox(width: AppSizes.paddingMd),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: GoogleFonts.inter(
                  color: _darkText,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  height: 20 / 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                item.subtitle,
                style: GoogleFonts.inter(
                  color: AppColors.secondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 20 / 14,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Qty: ${item.quantity}',
                    style: GoogleFonts.inter(
                      color: AppColors.secondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      height: 16 / 12,
                    ),
                  ),
                  Text(
                    'NPR ${item.price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}',
                    style: GoogleFonts.inter(
                      color: AppColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      height: 24 / 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Summary price line
// ---------------------------------------------------------------------------

class _SummaryLine extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryLine({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: AppColors.secondary,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 24 / 16,
          ),
        ),
        Text(
          value,
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
}