// lib/services/product_service.dart
//
// All shop related API calls live here.
// The screens (views) never call Dio directly, they call this service.
//
// Backend endpoints used:
//   GET /api/products
//   GET /api/products/search?q=...
//   GET /api/products/:id
//   GET /api/products/featured
//   GET /api/categories

import 'package:dio/dio.dart';
import 'package:handicraftmobilefrontend/models/product_model.dart';
import 'package:handicraftmobilefrontend/services/api_client.dart';

class ProductService {
  final Dio _dio = ApiClient.dio;

  /// Gets the product list for the shop screen.
  ///
  /// [category]  filter by category name, example "Pottery"
  /// [maxPrice]  only products cheaper than this price
  /// [sort]      newest | price | -price | rating
  Future<ProductListResult> getProducts({
    int page = 1,
    int limit = 20,
    String? category,
    double? maxPrice,
    String sort = 'newest',
  }) async {
    // Query values that are sent to the backend as ?page=1&limit=20...
    final Map<String, dynamic> query = {
      'page': page,
      'limit': limit,
      'sort': sort,
    };

    if (category != null && category.isNotEmpty) {
      query['category'] = category;
    }
    if (maxPrice != null) {
      query['maxPrice'] = maxPrice;
    }

    final Response response = await _dio.get(
      '/products',
      queryParameters: query,
    );

    final dynamic data = response.data;

    // Normal case: the backend sends an object with a "products" list.
    if (data is Map) {
      return ProductListResult.fromJson(Map<String, dynamic>.from(data));
    }

    // Just in case the backend sends a plain list.
    if (data is List) {
      final List<ProductModel> products = _toProductList(data);
      return ProductListResult(
        products: products,
        total: products.length,
        page: page,
        totalPages: 1,
      );
    }

    return const ProductListResult.empty();
  }

  /// Searches products by text, used by the search box.
  Future<List<ProductModel>> searchProducts(String text) async {
    final Response response = await _dio.get(
      '/products/search',
      queryParameters: {'q': text},
    );

    return _toProductList(response.data);
  }

  /// Gets one product with full details (used by the detail screen).
  Future<ProductModel?> getProductById(String id) async {
    final Response response = await _dio.get('/products/$id');
    final dynamic data = response.data;

    if (data is Map) {
      final Map<String, dynamic> json = Map<String, dynamic>.from(data);

      // Some endpoints wrap the product like { "product": { ... } }
      final dynamic wrapped = json['product'];
      if (wrapped is Map) {
        return ProductModel.fromJson(Map<String, dynamic>.from(wrapped));
      }

      return ProductModel.fromJson(json);
    }

    return null;
  }

  /// Gets the top rated products.
  Future<List<ProductModel>> getFeaturedProducts() async {
    final Response response = await _dio.get('/products/featured');
    return _toProductList(response.data);
  }

  /// Gets category names for the filter chips, example ["Pottery", "Textiles"].
  Future<List<String>> getCategoryNames() async {
    final Response response = await _dio.get('/categories');
    final dynamic data = response.data;

    // The backend answers { "success": true, "categories": [...] }
    dynamic list = data;
    if (data is Map) {
      list = data['categories'];
    }

    final List<String> names = [];
    if (list is List) {
      for (final dynamic item in list) {
        if (item is Map) {
          final String name = (item['name'] ?? '').toString();
          if (name.isNotEmpty) names.add(name);
        }
      }
    }

    return names;
  }

  /// Turns API data into a list of products.
  List<ProductModel> _toProductList(dynamic data) {
    // Case 1: a plain list of products.
    if (data is List) {
      final List<ProductModel> products = [];
      for (final dynamic item in data) {
        if (item is Map) {
          products.add(ProductModel.fromJson(Map<String, dynamic>.from(item)));
        }
      }
      return products;
    }

    // Case 2: an object that contains a "products" list.
    if (data is Map) {
      return ProductListResult.fromJson(
        Map<String, dynamic>.from(data),
      ).products;
    }

    return [];
  }
}
