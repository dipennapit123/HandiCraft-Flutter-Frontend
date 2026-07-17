// lib/services/category_service.dart

import 'dart:convert';
import 'package:handicraftmobilefrontend/utils/app_strings.dart';
import 'package:http/http.dart' as http;
import 'package:handicraftmobilefrontend/models/category_model.dart';

class CategoryService {
  
  static const String _baseUrl = AppStrings.baseUrl;
  
  static Future<CategoryModel> getCategories() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/api/categories'),
    );

    if (response.statusCode == 200) {
      return CategoryModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load categories: ${response.statusCode}');
    }
  }
}