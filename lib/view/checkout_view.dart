import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handicraftmobilefrontend/controllers/cart_controller.dart';
import 'package:handicraftmobilefrontend/utils/app_colors.dart';
import 'package:handicraftmobilefrontend/utils/app_sizes.dart';
import 'package:handicraftmobilefrontend/utils/app_text_styles.dart';
import 'package:handicraftmobilefrontend/view/main_layout.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _Address {
  final String label;
  final String name;
  final String details;
  final String phone;
  final IconData icon;
  final bool isDefault;

  const _Address({
    required this.label,
    required this.name,
    required this.details,
    required this.phone,
    required this.icon,
    this.isDefault = false,
  });
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final CartController cartController = Get.find<CartController>();

  final List<_Address> _addresses = const [
    _Address(
      label: 'Home',
      name: 'Aarya Sharma',
      details: 'House No. 42, Dhobighat Street\nLalitpur 44700, Nepal',
      phone: '+977 9841234567',
      icon: Icons.location_on,
      isDefault: true,
    ),
    _Address(
      label: 'Workspace',
      name: 'Workspace',
      details: 'Durbar Marg, Heritage Plaza\nKathmandu 44600, Nepal',
      phone: '',
      icon: Icons.home_outlined,
    ),
  ];
  int _selectedAddressIndex = 0;

  static const Map<String, double> _deliveryFees = {
    'Standard': 150,
    'Express': 450,
  };
  static const Map<String, String> _deliverySubtitles = {
    'Standard': '3 - 5 business days delivery',
    'Express': 'Next day delivery in KTM Valley',
  };
  String _deliveryOption = 'Standard';

  String _selectedPaymentMethod = 'eSewa';

  final TextEditingController _promoController = TextEditingController();

  double get _shippingFee => _deliveryFees[_deliveryOption] ?? 0;
  double get _tax => cartController.totalAmount.value * 0.13;
  double get _total => cartController.totalAmount.value + _shippingFee + _tax;

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
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Get.back(),
        ),
        title: const Text('KalaKosh', style: AppTextStyles.headlineMedium),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_none,
              color: AppColors.primary,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: AppColors.primary,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.paddingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(
              'Shipping Address',
              trailing: TextButton(
                onPressed: () {
                  Get.snackbar(
                    'Coming Soon',
                    "Adding new addresses isn't available yet",
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
                child: const Text(
                  '+ Add New',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            for (int i = 0; i < _addresses.length; i++) _buildAddressCard(i),
            const SizedBox(height: 20),

            _buildSectionHeader('Delivery Options'),
            const SizedBox(height: 10),
            _buildDeliveryOption('Standard'),
            const SizedBox(height: 12),
            _buildDeliveryOption('Express'),
            const SizedBox(height: 20),

            _buildSectionHeader('Payment Method'),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildPaymentIconCard(
                    'eSewa',
                    Icons.account_balance_wallet,
                    const Color(0xFF60BB46),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildPaymentIconCard(
                    'Khalti',
                    Icons.payment,
                    const Color(0xFF5C2D91),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildPaymentIconCard(
                    'IME Pay',
                    Icons.credit_score,
                    const Color(0xFFEE3439),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            _buildPaymentListOption(
              'Card',
              Icons.credit_card,
              'Credit / Debit Card',
            ),
            const SizedBox(height: 8),
            _buildPaymentListOption(
              'COD',
              Icons.payments_outlined,
              'Cash on Delivery',
            ),
            const SizedBox(height: 20),

            _buildOrderSummary(),
            const SizedBox(height: 16),

            const Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.lock_outline,
                    size: 14,
                    color: AppColors.secondary,
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Encrypted secure payment',
                    style: TextStyle(color: AppColors.secondary, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Obx(
              () => SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: cartController.cartItems.isEmpty
                      ? null
                      : _placeOrder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Place Order & Pay',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _placeOrder() {
    Get.snackbar(
      'Order Placed Successfully!',
      'Thank you for shopping with KalaKosh',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
    cartController.clearCart();
    Get.offAll(() => const MainLayoutView());
  }

  Widget _buildSectionHeader(String title, {Widget? trailing}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        if (trailing != null) trailing,
      ],
    );
  }

  Widget _buildAddressCard(int index) {
    final address = _addresses[index];
    final isSelected = _selectedAddressIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedAddressIndex = index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : AppColors.secondaryContainer,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(address.icon, color: AppColors.primary, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        address.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        address.details,
                        style: const TextStyle(
                          color: AppColors.secondary,
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),
                      if (address.phone.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          address.phone,
                          style: const TextStyle(
                            color: AppColors.secondary,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            if (address.isDefault)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Default',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryOption(String key) {
    final isSelected = _deliveryOption == key;
    final fee = _deliveryFees[key] ?? 0;
    final subtitle = _deliverySubtitles[key] ?? '';
    return GestureDetector(
      onTap: () => setState(() => _deliveryOption = key),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : AppColors.secondaryContainer,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? AppColors.primary : AppColors.secondary,
              size: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    key,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppColors.secondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'NPR ${fee.toStringAsFixed(0)}',
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentIconCard(String key, IconData icon, Color iconColor) {
    final isSelected = _selectedPaymentMethod == key;
    return GestureDetector(
      onTap: () => setState(() => _selectedPaymentMethod = key),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : AppColors.secondaryContainer,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: iconColor, size: 26),
            const SizedBox(height: 6),
            Text(
              key,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentListOption(String key, IconData icon, String label) {
    final isSelected = _selectedPaymentMethod == key;
    return GestureDetector(
      onTap: () => setState(() => _selectedPaymentMethod = key),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : AppColors.secondaryContainer,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? AppColors.primary : AppColors.secondary,
              size: 20,
            ),
            const SizedBox(width: 10),
            Icon(icon, color: AppColors.secondary, size: 20),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Summary',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            if (cartController.cartItems.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'Your cart is empty',
                  style: TextStyle(color: AppColors.secondary),
                ),
              )
            else
              for (final item in cartController.cartItems)
                _buildOrderItem(item),
            const Divider(height: 24),
            _buildSummaryRow('Subtotal', cartController.totalAmount.value),
            _buildSummaryRow('Shipping Fee', _shippingFee),
            _buildSummaryRow('Tax (VAT 13%)', _tax),
            const Divider(height: 24),
            _buildSummaryRow('Total Amount', _total, isTotal: true),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _promoController,
                    decoration: InputDecoration(
                      hintText: 'Promo code',
                      filled: true,
                      fillColor: AppColors.surfaceContainerLow,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                OutlinedButton(
                  onPressed: () {
                    Get.snackbar(
                      'Promo Codes',
                      'Promo codes are coming soon',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    side: const BorderSide(color: AppColors.primary),
                  ),
                  child: const Text(
                    'Apply',
                    style: TextStyle(color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(CartItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: item.imageUrl != null
                ? Image.network(
                    item.imageUrl!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 50,
                      height: 50,
                      color: AppColors.surfaceContainerLow,
                      child: const Icon(
                        Icons.image_not_supported_outlined,
                        size: 18,
                      ),
                    ),
                  )
                : Container(
                    width: 50,
                    height: 50,
                    color: AppColors.surfaceContainerLow,
                    child: const Icon(
                      Icons.image_not_supported_outlined,
                      size: 18,
                    ),
                  ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Qty: ${item.quantity.value}',
                  style: const TextStyle(
                    color: AppColors.secondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            'NPR ${(item.price * item.quantity.value).toStringAsFixed(0)}',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
              color: isTotal ? AppColors.textDark : AppColors.secondary,
            ),
          ),
          Text(
            'NPR ${amount.toStringAsFixed(0)}',
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              color: isTotal ? AppColors.primary : AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }
}
