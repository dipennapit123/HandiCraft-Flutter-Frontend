import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handicraftmobilefrontend/controllers/nav_controller.dart';
import 'package:handicraftmobilefrontend/utils/color_palette.dart';

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
    imageUrl: 'https://picsum.photos/96',
  ),
  CategoryItem(
    title: 'Textiles',
    subtitle: 'Premium Cashmere & Hand-loomed Silks',
    imageUrl: 'https://picsum.photos/96',
  ),
  CategoryItem(
    title: 'Jewelry',
    subtitle: 'Handcrafted Silver & Ethnic Gemstones',
    imageUrl: 'https://picsum.photos/96',
  ),
  CategoryItem(
    title: 'Pottery',
    subtitle: 'Artisanal Terracotta & Glazed Ceramics',
    imageUrl: 'https://picsum.photos/96',
  ),
  CategoryItem(
    title: 'Wood Crafts',
    subtitle: 'Intricate Hand-carved Architectural Pieces',
    imageUrl: 'https://picsum.photos/96',
  ),
  CategoryItem(
    title: 'Metal Crafts',
    subtitle: 'Singing Bowls & Hand-beaten Vessels',
    imageUrl: 'https://picsum.photos/96',
  ),
];

class BrowseCategoriesView extends StatelessWidget {
  BrowseCategoriesView({super.key});

  final NavController navController = Get.put(NavController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.kBgColor,
      body: Stack(
        children: [
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 96, 16, 0),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      _buildHeader(),
                      const SizedBox(height: 24),
                    ]),
                  ),
                ),
                // _buildGridSliver(),
                _buildListSliver(), 
              ],
            ),
          ),
          _buildTopAppBar(context),
          _buildBottomNavBar(),
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
            color: ColorPalette.kPrimaryColor,
            fontSize: 32,
            fontWeight: FontWeight.w600,
            height: 40 / 32,
          ),
        ),

        const SizedBox(height: 4),
        Text(
          'Discover authentic Himalayan craftmanship\nthrough our curated collections.',
          style: GoogleFonts.inter(
            color: ColorPalette.kSecondaryTextColor,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 24 / 16,
          ),
        ),
      ],
    );
  }

  Widget _buildTopAppBar(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: ColorPalette.kBgColor.withValues(alpha: 0.9),
              border: Border(
                bottom: BorderSide(
                  color: ColorPalette.kBorderColor.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.menu,
                      color: ColorPalette.kPrimaryColor,
                    ),
                    onPressed: () => Navigator.maybePop(context),
                  ),
                  const Spacer(),
                  Text(
                    'KalaKosh',
                    style: GoogleFonts.playfairDisplay(
                      color: ColorPalette.kPrimaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      height: 32 / 24,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.search,
                      color: ColorPalette.kPrimaryColor,
                    ),
                    onPressed: () {
                      // TODO: open search
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          color: ColorPalette.kBgColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          border: Border(
            top: BorderSide(
              color: ColorPalette.kBorderColor.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0D000000),
              blurRadius: 12,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _NavBarItem(
                  icon: Icons.home_outlined,
                  label: 'Home',
                  selected: navController.selectedIndex.value == 0,
                  onTap: () => navController.changeTab(0),
                ),
                _NavBarItem(
                  icon: Icons.shopping_bag_outlined,
                  label: 'Orders',
                  selected: navController.selectedIndex.value == 1,
                  onTap: () => navController.changeTab(1),
                ),
                _NavBarItem(
                  icon: Icons.person_outline,
                  label: 'Profile',
                  selected: navController.selectedIndex.value == 2,
                  onTap: () => navController.changeTab(2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGridSliver() {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 128),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.62,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          final c = kCategories[index];
          return _CategoryCardVertical(item: c, onTap: () {});
        }, childCount: kCategories.length),
      ),
    );
  }

  Widget _buildListSliver() {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 128),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final c = kCategories[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _CategoryCardHorizontal(item: c, onTap: () {}),
          );
        }, childCount: kCategories.length),
      ),
    );
  }
}

class _CategoryCardHorizontal extends StatelessWidget {
  final CategoryItem item;
  final VoidCallback onTap;

  const _CategoryCardHorizontal({required this.item, required this.onTap});

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
              color: ColorPalette.kBorderColor.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        item.title,
                        style: GoogleFonts.playfairDisplay(
                          color: ColorPalette.kPrimaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          height: 32 / 24,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.subtitle,
                        style: GoogleFonts.inter(
                          color: ColorPalette.kSecondaryTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 20 / 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16, bottom: 6),
                child: Icon(
                  Icons.chevron_right,
                  size: 20,
                  color: ColorPalette.kPrimaryColor.withValues(alpha: 0.3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryCardVertical extends StatelessWidget {
  final CategoryItem item;
  final VoidCallback onTap;

  const _CategoryCardVertical({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: ColorPalette.kBorderColor.withValues(alpha: 0.3),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Image.network(
                  item.imageUrl,
                  width: double.infinity,
                  height: 169,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 169,
                      color: ColorPalette.kBorderColor.withValues(alpha: 0.2),
                      child: const Icon(Icons.image_not_supported_outlined),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item.title,
                      style: GoogleFonts.playfairDisplay(
                        color: ColorPalette.kPrimaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        height: 28 / 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.subtitle,
                      style: GoogleFonts.inter(
                        color: ColorPalette.kSecondaryTextColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 16 / 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected
        ? ColorPalette.kPrimaryColor
        : ColorPalette.kSecondaryTextColor;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.inter(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: 16 / 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
