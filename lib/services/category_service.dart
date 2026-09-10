// lib/services/category_service.dart
//
// Categories API calls.
// The server address comes from ApiConstants (shared with shop and other features).
// Only the route is specific to this service: /categories

import 'dart:convert';

import 'package:handicraftmobilefrontend/models/category_model.dart';
import 'package:handicraftmobilefrontend/utils/api_constants.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  /// GET /api/categories
  static Future<CategoryModel> getCategories() async {
    final Uri url = Uri.parse('${ApiConstants.baseUrl}/categories');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return CategoryModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load categories: ${response.statusCode}');
    }
  }
}
