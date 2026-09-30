class OrderModel {
    OrderModel({
        required this.success,
        required this.orders,
    });

    final bool? success;
    final List<Order> orders;

    factory OrderModel.fromJson(Map<String, dynamic> json){ 
        return OrderModel(
            success: json["success"],
            orders: json["orders"] == null ? [] : List<Order>.from(json["orders"]!.map((x) => Order.fromJson(x))),
        );
    }

}

class Order {
    Order({
        required this.id,
        required this.userId,
        required this.subtotal,
        required this.shippingCost,
        required this.discount,
        required this.totalAmount,
        required this.shippingAddress,
        required this.paymentMethod,
        required this.paymentStatus,
        required this.orderStatus,
        required this.createdAt,
        required this.updatedAt,
        required this.orderNumber,
        required this.v,
    });

    final String? id;
    final UserId? userId;
    final int? subtotal;
    final int? shippingCost;
    final int? discount;
    final int? totalAmount;
    final ShippingAddress? shippingAddress;
    final String? paymentMethod;
    final String? paymentStatus;
    final String? orderStatus;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final String? orderNumber;
    final int? v;

    factory Order.fromJson(Map<String, dynamic> json){ 
        return Order(
            id: json["_id"],
            userId: json["user_id"] == null ? null : UserId.fromJson(json["user_id"]),
            subtotal: json["subtotal"],
            shippingCost: json["shipping_cost"],
            discount: json["discount"],
            totalAmount: json["total_amount"],
            shippingAddress: json["shipping_address"] == null ? null : ShippingAddress.fromJson(json["shipping_address"]),
            paymentMethod: json["payment_method"],
            paymentStatus: json["payment_status"],
            orderStatus: json["order_status"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            orderNumber: json["order_number"],
            v: json["__v"],
        );
    }

}

class ShippingAddress {
    ShippingAddress({
        required this.name,
        required this.street,
        required this.city,
        required this.state,
        required this.postalCode,
        required this.country,
        required this.phone,
    });

    final String? name;
    final String? street;
    final String? city;
    final String? state;
    final String? postalCode;
    final String? country;
    final String? phone;

    factory ShippingAddress.fromJson(Map<String, dynamic> json){ 
        return ShippingAddress(
            name: json["name"],
            street: json["street"],
            city: json["city"],
            state: json["state"],
            postalCode: json["postal_code"],
            country: json["country"],
            phone: json["phone"],
        );
    }

}

class UserId {
    UserId({
        required this.id,
        required this.name,
        required this.email,
    });

    final String? id;
    final String? name;
    final String? email;

    factory UserId.fromJson(Map<String, dynamic> json){ 
        return UserId(
            id: json["_id"],
            name: json["name"],
            email: json["email"],
        );
    }

}
