// lib/models/checkout_model.dart

class AddressModel {
  final String? id;
  final String? label;
  final String? name;
  final String? addressLine;
  final String? phone;
  final bool? isDefault;

  AddressModel({
    required this.id,
    required this.label,
    required this.name,
    required this.addressLine,
    required this.phone,
    required this.isDefault,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['_id'],
      label: json['label'],
      name: json['name'],
      addressLine: json['address_line'],
      phone: json['phone'],
      isDefault: json['is_default'],
    );
  }
}

class AddressListModel {
  final bool? success;
  final List<AddressModel> addresses;

  AddressListModel({
    required this.success,
    required this.addresses,
  });

  factory AddressListModel.fromJson(Map<String, dynamic> json) {
    return AddressListModel(
      success: json['success'],
      addresses: json['addresses'] == null
          ? []
          : List<AddressModel>.from(
              json['addresses']!.map((x) => AddressModel.fromJson(x))),
    );
  }
}

class DeliveryOptionModel {
  final String? id;
  final String? name;
  final int? price;
  final String? description;

  DeliveryOptionModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
  });

  factory DeliveryOptionModel.fromJson(Map<String, dynamic> json) {
    return DeliveryOptionModel(
      id: json['_id'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
    );
  }
}

class DeliveryOptionsModel {
  final bool? success;
  final List<DeliveryOptionModel> options;

  DeliveryOptionsModel({
    required this.success,
    required this.options,
  });

  factory DeliveryOptionsModel.fromJson(Map<String, dynamic> json) {
    return DeliveryOptionsModel(
      success: json['success'],
      options: json['options'] == null
          ? []
          : List<DeliveryOptionModel>.from(
              json['options']!.map((x) => DeliveryOptionModel.fromJson(x))),
    );
  }
}

class PlaceOrderModel {
  final bool? success;
  final String? message;
  final String? orderId;

  PlaceOrderModel({
    required this.success,
    required this.message,
    required this.orderId,
  });

  factory PlaceOrderModel.fromJson(Map<String, dynamic> json) {
    return PlaceOrderModel(
      success: json['success'],
      message: json['message'],
      orderId: json['order_id'],
    );
  }
}