import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:handicraftmobilefrontend/utils/app_colors.dart';
import 'package:handicraftmobilefrontend/utils/app_sizes.dart';

// ---------------------------------------------------------------------------
// Data model
// ---------------------------------------------------------------------------

class CategoryItem {
  final String title;
  final String subtitle;
  final String imageUrl;

  const CategoryItem({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });
}

const List<CategoryItem> kCategories = [
  CategoryItem(
    title: 'Paintings',
    subtitle: 'Exquisite Traditional Artworks & Thangkas',
    imageUrl: 'https://picsum.photos/seed/paintings/400/300',
  ),
  CategoryItem(
    title: 'Textiles',
    subtitle: 'Premium Cashmere & Hand-loomed Silks',
    imageUrl: 'https://picsum.photos/seed/textiles/400/300',
  ),
  CategoryItem(
    title: 'Jewelry',
    subtitle: 'Handcrafted Silver & Ethnic Gemstones',
    imageUrl: 'https://picsum.photos/seed/jewelry/400/300',
  ),
  CategoryItem(
    title: 'Pottery',
    subtitle: 'Artisanal Terracotta & Glazed Ceramics',
    imageUrl: 'https://picsum.photos/seed/pottery/400/300',
  ),
  CategoryItem(
    title: 'Wood Crafts',
    subtitle: 'Intricate Hand-carved Architectural Pieces',
    imageUrl: 'https://picsum.photos/seed/woodcrafts/400/300',
  ),
  CategoryItem(
    title: 'Metal Crafts',
    subtitle: 'Singing Bowls & Hand-beaten Vessels',
    imageUrl: 'https://picsum.photos/seed/metalcrafts/400/300',
  ),
];

class BrowseCategoriesView extends StatefulWidget {
  const BrowseCategoriesView({super.key});

  @override
  State<BrowseCategoriesView> createState() => _BrowseCategoriesViewState();
}

class _BrowseCategoriesViewState extends State<BrowseCategoriesView> {
  bool _isGridView = true;

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
      body: ListView(
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
          _isGridView ? _buildGrid() : _buildList(),
          const SizedBox(height: AppSizes.paddingLg),
        ],
      ),
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

  // Grid/list toggle row — same pattern as ShopView's sort row
  Widget _buildToggleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '',
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
                color: _isGridView
                    ? AppColors.primary
                    : AppColors.secondary,
              ),
              onPressed: () => setState(() => _isGridView = true),
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
                color: !_isGridView
                    ? AppColors.primary
                    : AppColors.secondary,
              ),
              onPressed: () => setState(() => _isGridView = false),
              constraints: const BoxConstraints(),
              padding: EdgeInsets.zero,
            ),
          ],
        ),
      ],
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
      itemCount: kCategories.length,
      itemBuilder: (context, index) {
        return CategoryCardVertical(item: kCategories[index], onTap: () {});
      },
    );
  }

  Widget _buildList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: kCategories.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return CategoryCardHorizontal(item: kCategories[index], onTap: () {});
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Vertical card — 2-column grid tile
// ---------------------------------------------------------------------------

class CategoryCardVertical extends StatelessWidget {
  final CategoryItem item;
  final VoidCallback onTap;

  const CategoryCardVertical({
    super.key,
    required this.item,
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
            color: Colors.black.withOpacity(
              0.30,
            ), // Stroke: #DDC0BE 30%
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
                child: Image.network(
                  item.imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.white,
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
            // Text area — sits on top of surfaceContainerLow naturally
            Padding(
              padding: const EdgeInsets.all(AppSizes.paddingMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.title,
                    style: GoogleFonts.playfairDisplay(
                      color: AppColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.subtitle,
                    style: GoogleFonts.inter(
                      color: AppColors.secondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
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
  final CategoryItem item;
  final VoidCallback onTap;

  const CategoryCardHorizontal({
    super.key,
    required this.item,
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
              color: Colors.black.withOpacity(
                0.30,
              ), // Stroke: #DDC0BE 30%
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
                child: Image.network(
                  item.imageUrl,
                  width: 96,
                  height: 96,
                  fit: BoxFit.cover,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        item.title,
                        style: GoogleFonts.playfairDisplay(
                          color: AppColors.primary,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.subtitle,
                        style: GoogleFonts.inter(
                          color: AppColors.secondary,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
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
