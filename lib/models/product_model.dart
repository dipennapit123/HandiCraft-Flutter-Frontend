// lib/models/product_model.dart
//
// A "model" turns the JSON that the backend sends into a Dart object.
// Backend JSON example:
// {
//   "_id": "abc123",
//   "name": "Lokta Diary",
//   "price": 850,
//   "images": ["/images/diary.jpg"],
//   "avg_rating": 4.5
// }

import 'package:handicraftmobilefrontend/utils/api_constants.dart';

class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? discountPrice; // null when there is no discount
  final List<String> images;
  final double rating;
  final String material;
  final String region;
  final String craftType;
  final int stock;
  final String categoryName;
  final String shopName;
  final bool isFeatured;

  // Not from the API. We only use it to colour the heart icon in the UI.
  bool isFavorite;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.images,
    required this.rating,
    required this.material,
    required this.region,
    required this.craftType,
    required this.stock,
    required this.categoryName,
    required this.shopName,
    this.discountPrice,
    this.isFeatured = false,
    this.isFavorite = false,
  });

  /// Builds a ProductModel from one JSON object sent by the backend.
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      // The backend uses "_id" for the product id.
      id: _readString(json['_id'] ?? json['id']),
      name: _readString(json['name'], fallback: 'Unknown Product'),
      description: _readString(json['description']),
      price: _readDouble(json['price']),
      discountPrice: json['discount_price'] == null
          ? null
          : _readDouble(json['discount_price']),
      images: _readImages(json['images']),
      rating: _readDouble(json['avg_rating']),
      material: _readString(json['material'], fallback: 'Handmade'),
      region: _readString(json['region'], fallback: 'Nepal'),
      craftType: _readString(json['craft_type'], fallback: 'Handicraft'),
      stock: _readInt(json['stock']),
      // "category_id" and "vendor_id" arrive as small objects, so we read
      // the field we want out of them.
      categoryName: _readNestedText(json['category_id'], 'name'),
      shopName: _readNestedText(json['vendor_id'], 'shop_name'),
      isFeatured: json['isFeatured'] == true,
    );
  }

  /// Price shown in the UI, for example "$850".
  /// If the product has a discount we show the discounted price.
  String get priceText {
    final double finalPrice = discountPrice ?? price;
    return '\$${finalPrice.toStringAsFixed(0)}';
  }

  /// Rating shown in the UI, for example "4.5".
  String get ratingText => rating.toStringAsFixed(1);

  /// First image of the product (used in the shop grid).
  String get firstImage {
    if (images.isEmpty) return '';
    return fullImageUrl(images.first);
  }

  /// All images of the product (used in the detail page gallery).
  List<String> get allImages {
    final List<String> result = [];
    for (final String image in images) {
      final String url = fullImageUrl(image);
      if (url.isNotEmpty) result.add(url);
    }
    return result;
  }

  /// Small label drawn on top of the product image. Returns null when
  /// the product does not need a label.
  String? get badgeText {
    if (isFeatured) return 'Featured';
    if (discountPrice != null) return 'Sale';
    if (stock > 0 && stock <= 5) return 'Limited';
    return null;
  }

  /// The backend sometimes sends a short path like "/images/pot.jpg".
  /// Flutter needs a complete link, so we add the server address in front.
  static String fullImageUrl(String? path) {
    if (path == null) return '';

    final String cleanPath = path.trim();
    if (cleanPath.isEmpty) return '';

    // Already a complete link.
    if (cleanPath.startsWith('http')) return cleanPath;

    if (cleanPath.startsWith('/')) {
      return '${ApiConstants.serverUrl}$cleanPath';
    }
    return '${ApiConstants.serverUrl}/$cleanPath';
  }
}

// ---------------------------------------------------------------------------
// Small helpers.
// The API can send a number as 850 or "850", so we convert values safely
// instead of crashing the app.
// ---------------------------------------------------------------------------

String _readString(dynamic value, {String fallback = ''}) {
  if (value == null) return fallback;

  final String text = value.toString();
  if (text.isEmpty) return fallback;

  return text;
}

double _readDouble(dynamic value) {
  if (value == null) return 0;
  if (value is num) return value.toDouble();

  return double.tryParse(value.toString()) ?? 0;
}

int _readInt(dynamic value) {
  if (value == null) return 0;
  if (value is num) return value.toInt();

  return int.tryParse(value.toString()) ?? 0;
}

/// Reads the "images" list and keeps only text values.
List<String> _readImages(dynamic value) {
  final List<String> images = [];

  if (value is List) {
    for (final dynamic item in value) {
      if (item != null) images.add(item.toString());
    }
  }

  return images;
}

/// Reads one field out of a nested object.
/// Example: category_id = { "name": "Pottery" } -> "Pottery"
String _readNestedText(dynamic value, String key) {
  if (value is Map) {
    return _readString(value[key]);
  }
  return '';
}

// ---------------------------------------------------------------------------
// The products endpoint does not return a plain list. It returns:
// { "products": [...], "total": 31, "page": 1, "limit": 12, "totalPages": 3 }
// This class holds that response.
// ---------------------------------------------------------------------------

class ProductListResult {
  final List<ProductModel> products;
  final int total;
  final int page;
  final int totalPages;

  const ProductListResult({
    required this.products,
    required this.total,
    required this.page,
    required this.totalPages,
  });

  /// Empty result, used when something goes wrong.
  const ProductListResult.empty()
    : products = const [],
      total = 0,
      page = 1,
      totalPages = 0;

  factory ProductListResult.fromJson(Map<String, dynamic> json) {
    final List<ProductModel> products = [];

    final dynamic list = json['products'];
    if (list is List) {
      for (final dynamic item in list) {
        if (item is Map) {
          products.add(ProductModel.fromJson(Map<String, dynamic>.from(item)));
        }
      }
    }

    return ProductListResult(
      products: products,
      total: _readInt(json['total']),
      page: _readInt(json['page']),
      totalPages: _readInt(json['totalPages']),
    );
  }
}
