// lib/controllers/category_controller.dart
//
// GetX controller for the browse-categories screen.
// It asks CategoryService for data and builds full image links
// using ApiConstants.serverUrl (same host as the shop).

import 'package:get/get.dart';
import 'package:handicraftmobilefrontend/models/category_model.dart';
import 'package:handicraftmobilefrontend/services/category_service.dart';
import 'package:handicraftmobilefrontend/utils/api_constants.dart';

class CategoryController extends GetxController {
  final categories = <Category>[].obs;
  final isLoading = true.obs;
  final error = ''.obs;
  final isGridView = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      isLoading(true);
      error('');
      final CategoryModel result = await CategoryService.getCategories();

      if (result.success == true) {
        categories.assignAll(result.categories);
      } else {
        error('Some error occurred to fetch categories');
      }
    } catch (e) {
      error(e.toString());
    } finally {
      isLoading(false);
    }
  }

  void toggleView(bool gridView) => isGridView(gridView);

  /// Turns a short path like "/images/pottery.jpg" into a full URL.
  String imageUrl(Category category) {
    final image = category.image ?? '';
    if (image.isEmpty) return '';
    if (image.startsWith('http')) return image;

    final path = image.startsWith('/') ? image : '/$image';
    return '${ApiConstants.serverUrl}$path';
  }
}
