import 'package:get/get.dart';
import 'package:handicraftmobilefrontend/view/order_success_view.dart';
import '../services/api_client.dart';
import '../models/order_model.dart';
import '../models/checkout_model.dart';

class OrdersController extends GetxController {
  static OrdersController get to => Get.find();

  // ==================== Order List ====================
  final orders = RxList<Order>([]);
  final filteredOrders = RxList<Order>([]);
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  // ==================== Checkout ====================
  final addresses = RxList<AddressModel>([]);
  final deliveryOptions = RxList<DeliveryOptionModel>([]);

  final selectedAddressId = ''.obs;
  final selectedDeliveryOptionId = ''.obs;

  final isPlaceOrderLoading = false.obs;
  final placeOrderMessage = ''.obs;

  // Single order for Success Screen
  final currentOrder = Rxn<Order>();

  // ====================== ORDERS ======================
  /// Get ALL orders (used in OrdersScreen)
  Future<void> fetchOrders() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await ApiClient.dio.get('/api/orders');
      final data = response.data;

      if (data != null && data['success'] == true) {
        orders.value = List<Order>.from(
          (data['orders'] ?? []).map((x) => Order.fromJson(x)),
        );
      } else {
        orders.value = [];
        errorMessage.value = 'Failed to load orders';
      }
    } catch (e) {
      errorMessage.value = e.toString();
      orders.value = [];
    } finally {
      isLoading.value = false;
    }
  }

  void filterByStatus(String? status) {
    if (status == null || status.isEmpty) {
      filteredOrders.value = orders;
      return;
    }
    filteredOrders.value = orders.where((o) =>
        o.orderStatus?.toLowerCase() == status.toLowerCase()).toList();
  }

  void resetFilter() {
    filteredOrders.value = orders;
  }

  // ====================== CHECKOUT ======================
  /// Fetch user's addresses
  Future<void> fetchAddresses() async {
    try {
      final response = await ApiClient.dio.get('/api/addresses');
      final data = response.data;

      if (data != null && data['success'] == true) {
        addresses.value = List<AddressModel>.from(
          (data['addresses'] ?? []).map((x) => AddressModel.fromJson(x)),
        );
      } else {
        addresses.value = [];
      }
    } catch (e) {
      addresses.value = [];
    }
  }

  /// Fetch delivery options
  Future<void> fetchDeliveryOptions() async {
    try {
      final response = await ApiClient.dio.get('/api/delivery-options');
      final data = response.data;

      if (data != null && data['success'] == true) {
        deliveryOptions.value = List<DeliveryOptionModel>.from(
          (data['options'] ?? []).map((x) => DeliveryOptionModel.fromJson(x)),
        );
      } else {
        deliveryOptions.value = [];
      }
    } catch (e) {
      deliveryOptions.value = [];
    }
  }

  /// Place order & show success screen
  Future<void> placeOrder(String addressId, String deliveryOptionId, String? productImageUrl)async {
    isPlaceOrderLoading.value = true;
    placeOrderMessage.value = '';

    try {
      final payload = {
        "shipping_address": addressId,
        "payment_method": "cod", // change if you use stripe/card/etc.
        "discount": 0,
      };

      final response = await ApiClient.dio.post('/api/orders', data: payload);
      final data = response.data;

      if (data != null && data['success'] == true) {
        final model = PlaceOrderModel.fromJson(data);
        placeOrderMessage.value = model.message ?? 'Order placed successfully!';

        if (model.orderId != null) {
          Get.offAll(
            OrderSuccessView(productImageUrl: productImageUrl,),

          );
        }
      } else {
        placeOrderMessage.value = data['message'] ?? 'Something went wrong';
      }
    } catch (e) {
      placeOrderMessage.value = e.toString();
    } finally {
      isPlaceOrderLoading.value = false;
    }
  }

 
  Future<void> fetchOrderById(String orderId) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await ApiClient.dio.get('/api/orders/$orderId');
      final data = response.data;

      if (data != null && data['success'] == true) {
        final orderJson = data['order']; // endpoint returns { success, order }
        if (orderJson != null) {
          currentOrder.value = Order.fromJson(orderJson);
        }
      } else {
        currentOrder.value = null;
      }
    } catch (e) {
      errorMessage.value = e.toString();
      currentOrder.value = null;
    } finally {
      isLoading.value = false;
    }
  }
}