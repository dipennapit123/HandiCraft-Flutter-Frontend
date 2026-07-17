// lib/views/browse_categories_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:handicraftmobilefrontend/controllers/category_controller.dart';
import 'package:handicraftmobilefrontend/utils/app_colors.dart';
import 'package:handicraftmobilefrontend/utils/app_sizes.dart';

class BrowseCategoriesView extends StatelessWidget {
  BrowseCategoriesView({super.key});

  final CategoryController controller = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background.withOpacity(0.8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: AppColors.primary),
          onPressed: () {},
        ),
        title: Text(
          'KalaKosh',
          style: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.w600,
            fontSize: 24,
            color: AppColors.primary,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.primary),
            onPressed: () {},
          ),
        ],
      ),
      body: Obx(() {
        // Loading state
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        // Error state
        if (controller.error.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.wifi_off_outlined,
                  color: AppColors.secondary,
                  size: 48,
                ),
                const SizedBox(height: 12),
                Text(
                  'Could not load categories',
                  style: GoogleFonts.inter(
                    color: AppColors.secondary,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: controller.fetchCategories,
                  icon: const Icon(Icons.refresh),
                  label: Text(
                    'Retry',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          );
        }

        // Success state
        return ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingMd,
            vertical: AppSizes.paddingSm,
          ),
          physics: const BouncingScrollPhysics(),
          children: [
            _buildHeader(),
            const SizedBox(height: AppSizes.paddingMd),
            _buildToggleRow(),
            const SizedBox(height: AppSizes.paddingMd),
            controller.isGridView.value ? _buildGrid() : _buildList(),
            const SizedBox(height: AppSizes.paddingLg),
          ],
        );
      }),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Browse Categories',
          style: GoogleFonts.playfairDisplay(
            color: AppColors.primary,
            fontSize: 32,
            fontWeight: FontWeight.w600,
            height: 40 / 32,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Discover authentic Himalayan craftsmanship\nthrough our curated collections.',
          style: GoogleFonts.inter(
            color: AppColors.secondary,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 24 / 16,
          ),
        ),
      ],
    );
  }

  Widget _buildToggleRow() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${controller.categories.length} Categories',
            style: GoogleFonts.inter(
              color: AppColors.secondary,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.grid_view,
                  color: controller.isGridView.value
                      ? AppColors.primary
                      : AppColors.secondary,
                ),
                onPressed: () => controller.toggleView(true),
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
              ),
              const SizedBox(width: 12),
              Container(
                height: 20,
                width: 1,
                color: AppColors.secondary.withOpacity(0.3),
              ),
              const SizedBox(width: 12),
              IconButton(
                icon: Icon(
                  Icons.format_list_bulleted,
                  color: !controller.isGridView.value
                      ? AppColors.primary
                      : AppColors.secondary,
                ),
                onPressed: () => controller.toggleView(false),
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: controller.categories.length,
      itemBuilder: (context, index) {
        final c = controller.categories[index];
        return CategoryCardVertical(
          name: c.name ?? '',
          imageUrl: controller.imageUrl(c),
          onTap: () {},
        );
      },
    );
  }

  Widget _buildList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.categories.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final c = controller.categories[index];
        return CategoryCardHorizontal(
          name: c.name ?? '',
          imageUrl: controller.imageUrl(c),
          onTap: () {},
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Vertical card — 2-column grid tile
// ---------------------------------------------------------------------------

class CategoryCardVertical extends StatelessWidget {
  final String name;
  final String imageUrl;
  final VoidCallback onTap;

  const CategoryCardVertical({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0x4DDDC0BE),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image — clips only the top corners
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: imageUrl.isEmpty
                    ? Container(
                        color: AppColors.surfaceContainerLow,
                        child: const Center(
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            color: AppColors.secondary,
                          ),
                        ),
                      )
                    : Image.network(
                        imageUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: AppColors.surfaceContainerLow,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                                strokeWidth: 2,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (_, __, ___) => Container(
                          color: AppColors.surfaceContainerLow,
                          child: const Center(
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              color: AppColors.secondary,
                            ),
                          ),
                        ),
                      ),
              ),
            ),
            // Text area
            Padding(
              padding: const EdgeInsets.all(AppSizes.paddingMd),
              child: Text(
                name,
                style: GoogleFonts.playfairDisplay(
                  color: AppColors.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Horizontal card — full-width list tile
// ---------------------------------------------------------------------------

class CategoryCardHorizontal extends StatelessWidget {
  final String name;
  final String imageUrl;
  final VoidCallback onTap;

  const CategoryCardHorizontal({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0x4DDDC0BE),
              width: 1,
            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                child: imageUrl.isEmpty
                    ? Container(
                        width: 96,
                        height: 96,
                        color: AppColors.surfaceContainerLow,
                        child: const Icon(
                          Icons.image_not_supported_outlined,
                          color: AppColors.secondary,
                        ),
                      )
                    : Image.network(
                        imageUrl,
                        width: 96,
                        height: 96,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            width: 96,
                            height: 96,
                            color: AppColors.surfaceContainerLow,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                                strokeWidth: 2,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (_, __, ___) => Container(
                          width: 96,
                          height: 96,
                          color: AppColors.surfaceContainerLow,
                          child: const Icon(
                            Icons.image_not_supported_outlined,
                            color: AppColors.secondary,
                          ),
                        ),
                      ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingMd,
                    vertical: AppSizes.paddingSm,
                  ),
                  child: Text(
                    name,
                    style: GoogleFonts.playfairDisplay(
                      color: AppColors.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: AppSizes.paddingMd),
                child: Icon(
                  Icons.chevron_right,
                  size: 20,
                  color: AppColors.primary.withOpacity(0.3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}