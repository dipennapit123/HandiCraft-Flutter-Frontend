import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handicraftmobilefrontend/view/track_order_view.dart';
import 'package:intl/intl.dart';
import '../controllers/orders_controller.dart';
import '../models/order_model.dart';

class OrderSuccessView extends StatefulWidget {
  final String? productImageUrl;
  const OrderSuccessView({super.key, this.productImageUrl});

  @override
  State<OrderSuccessView> createState() => _OrderSuccessViewState();
}

class _OrderSuccessViewState extends State<OrderSuccessView> {
  final OrdersController _controller = Get.put(OrdersController());
  Order? _order;

  @override
  void initState() {
    super.initState();

    final orderId = Get.arguments as String?;

    if (orderId != null && orderId.isNotEmpty) {
      _controller.fetchOrderById(orderId); // new endpoint
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_controller.orders.isNotEmpty) {
          _order = _controller.orders.first;
          _controller.currentOrder.value = _order;
        }
      });
    }
  }

  void _onTrackOrder() {
    Get.to(() => const TrackOrderView());
  }

  void _onViewMyOrders() => Get.offAllNamed('/orders');
  void _onContinueShopping() => Get.offAllNamed('/');

  @override
  Widget build(BuildContext context) {
    _order = _controller.currentOrder.value;

    return Scaffold(
      body: Container(
        width: 390,
        color: const Color(0xFFF8F7F7),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildSuccessHeader(),
              _buildInfoSection(),
              _buildOrderDetails(),
              _buildButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        children: [
          Container(
            width: 192,
            height: 192,
            decoration: BoxDecoration(
              color: const Color(0xFFF8E4E2),
              borderRadius: BorderRadius.circular(9999),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x19000000),
                  blurRadius: 10,
                  offset: Offset(8, 20),
                ),
              ],
            ),
            child: ClipOval(
              child:
                  widget.productImageUrl != null &&
                      widget.productImageUrl!.isNotEmpty
                  ? Image.network(
                      widget.productImageUrl!,
                      width: 192,
                      height: 192,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.shopping_bag_outlined,
                        size: 80,
                        color: Color(0xFF5C0510),
                      ),
                    )
                  : const Icon(
                      Icons.shopping_bag_outlined,
                      size: 80,
                      color: Color(0xFF5C0510),
                    ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Order\nSuccessful',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Playfair Display',
              fontSize: 48,
              fontWeight: FontWeight.w700,
              color: Color(0xFF5C0510),
              height: 1.17,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
      child: Column(
        children: [
          const Text(
            "Your piece of Nepali heritage is being\nprepared. We’ve sent the receipt to your\nemail.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Color(0xFF564241),
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderDetails() {
    if (_order == null) {
      return const Padding(
        padding: EdgeInsets.all(24),
        child: Center(
          child: Text('Order not found', style: TextStyle(color: Colors.red)),
        ),
      );
    }

    final estimatedArrival = _order!.createdAt != null
        ? DateFormat('MMM d, yyyy').format(_order!.createdAt!)
        : 'TBD';

    return Padding(
      padding: const EdgeInsets.only(top: 32, left: 24, right: 24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF0EF),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: const Color(0xFFDDC0BE).withOpacity(0.3)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x05000000),
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            _buildDetailRow(
              'Order ID',
              '#${_order!.orderNumber ?? 'N/A'}',
              isHighlight: true,
            ),
            _buildDetailRow('Estimated Arrival', estimatedArrival),
            _buildDetailRow(
              'Total Amount',
              '\$${_order!.totalAmount ?? '0.00'}',
              isBig: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    bool isHighlight = false,
    bool isBig = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF605E58),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontFamily: isBig ? 'Playfair Display' : 'Inter',
              fontSize: isBig ? 24 : 16,
              fontWeight: FontWeight.w700,
              color: isHighlight
                  ? const Color(0xFF5C0510)
                  : const Color(0xFF231919),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: const EdgeInsets.only(top: 32, left: 24, right: 24, bottom: 96),
      child: Column(
        children: [
          _buildButton(
            'Track Order',
            isPrimary: true,
            onPressed: _onTrackOrder,
          ),
          _buildButton(
            'View My Orders',
            isPrimary: false,
            onPressed: _onViewMyOrders,
          ),
          _buildButton(
            'Continue Shopping',
            isPrimary: false,
            onPressed: _onContinueShopping,
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
    String text, {
    required bool isPrimary,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: isPrimary ? const Color(0xFF5C0510) : Colors.transparent,
        borderRadius: BorderRadius.circular(9999),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(9999),
          child: Container(
            width: double.infinity,
            height: 52,
            decoration: BoxDecoration(
              color: isPrimary ? const Color(0xFF5C0510) : Colors.transparent,
              border: isPrimary
                  ? null
                  : Border.all(color: const Color(0xFF5C0510).withOpacity(0.2)),
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isPrimary ? Colors.white : const Color(0xFF5C0510),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
