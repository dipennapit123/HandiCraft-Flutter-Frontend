// lib/view/ProductDetailView.dart
import 'package:flutter/material.dart';
import 'package:handicraftmobilefrontend/utils/app_colors.dart';
import 'package:handicraftmobilefrontend/utils/app_sizes.dart';
import 'package:handicraftmobilefrontend/utils/app_text_styles.dart';


class ProductDetailView extends StatefulWidget {
  const ProductDetailView({super.key});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  int _currentGalleryIndex = 0;
  bool _isFavorite = false;
  int _quantity = 1; 
  
  final int _navigationIndex = 1; 

  final List<String> galleryImages = [
    'https://images.unsplash.com/photo-1542362567-b07eac790abc?q=80&w=600',
    'https://images.unsplash.com/photo-1584917865442-de89df76afd3?q=80&w=600',
    'https://images.unsplash.com/photo-1612196808214-b8e1d6145a8c?q=80&w=600'
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 390),
        child: Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background.withOpacity(0.85),
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: AppSizes.paddingSm),
              child: IconButton(
                icon: const Icon(Icons.menu, color: AppColors.primary, size: 22),
                onPressed: () {},
              ),
            ),
            title: const Text('KalaKosh', style: AppTextStyles.headlineMedium),
            centerTitle: true,
            actions: [
              IconButton(icon: const Icon(Icons.search, color: AppColors.primary, size: 22), onPressed: () {}),
              IconButton(icon: const Icon(Icons.notifications_none, color: AppColors.primary, size: 22), onPressed: () {}),
              IconButton(icon: const Icon(Icons.shopping_cart_outlined, color: AppColors.primary, size: 22), onPressed: () {}),
              const SizedBox(width: AppSizes.paddingSm),
            ],
          ),
          body: Stack(
            children: [
              ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 210), 
                children: [
                  // 1. Resized Image Carousel Gallery Viewport (Changed aspect ratio from 4/5 to 16/10 for a mid-size view)
                  AspectRatio(
                    aspectRatio: 16 / 10,
                    child: Stack(
                      children: [
                        PageView.builder(
                          itemCount: galleryImages.length,
                          onPageChanged: (index) {
                            setState(() {
                              _currentGalleryIndex = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return Image.network(
                              galleryImages[index],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                color: AppColors.surfaceContainerLow,
                                child: const Icon(Icons.image_not_supported, color: AppColors.secondary),
                              ),
                            );
                          },
                        ),
                        // Floating Action Controls
                        Positioned(
                          bottom: 12,
                          right: AppSizes.paddingMd,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isFavorite = !_isFavorite;
                                  });
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.95),
                                    shape: BoxShape.circle,
                                    border: Border.all(color: AppColors.secondaryContainer.withOpacity(0.5)),
                                  ),
                                  child: Icon(
                                    _isFavorite ? Icons.favorite : Icons.favorite_border,
                                    color: AppColors.primary,
                                    size: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(height: AppSizes.paddingSm),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.95),
                                  shape: BoxShape.circle,
                                  border: Border.all(color: AppColors.secondaryContainer.withOpacity(0.5)),
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(Icons.share_outlined, color: AppColors.primary, size: 20),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Pagination Indicators
                        Positioned(
                          bottom: 12,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(galleryImages.length, (index) {
                              bool isActive = _currentGalleryIndex == index;
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.symmetric(horizontal: 3),
                                height: 5,
                                width: isActive ? 16 : 5,
                                decoration: BoxDecoration(
                                  color: isActive ? AppColors.primary : Colors.white.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(AppSizes.radiusCircular),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 2. Product Text Information Context
                  Padding(
                    padding: const EdgeInsets.all(AppSizes.paddingMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Expanded(
                              child: Text(
                                'Sacred Oak Buddha',
                                style: TextStyle(
                                  fontFamily: 'Playfair Display',
                                  fontSize: 28,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textDark,
                                  height: 1.2,
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSizes.paddingSm),
                            Text(
                              '\$249',
                              style: AppTextStyles.headlineMedium.copyWith(fontSize: 24),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSizes.paddingXs),
                        const Row(
                          children: [
                            Icon(Icons.star, color: Color(0xFFFFB300), size: 18),
                            Icon(Icons.star, color: Color(0xFFFFB300), size: 18),
                            Icon(Icons.star_border, color: Color(0xFFFFB300), size: 18),
                          ],
                        ),
                        const SizedBox(height: AppSizes.paddingLg),
                        const Text(
                          'Description',
                          style: TextStyle(
                            fontFamily: 'Playfair Display',
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: AppSizes.paddingSm),
                        const Text(
                          'This Sacred Oak Buddha is hand-carved by master artisans in the Kathmandu Valley. Each piece is unique, reflecting centuries of Himalayan woodcraft tradition.',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            color: AppColors.secondary,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: AppSizes.paddingLg),
                        const Text(
                          'Product Details',
                          style: TextStyle(
                            fontFamily: 'Playfair Display',
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: AppSizes.paddingSm),
                        _buildSpecificationRow('Material', 'Hand-carved Sacred Oak'),
                        _buildSpecificationRow('Dimensions', '12" x 8" x 6"'),
                        _buildSpecificationRow('Weight', '2.5 lbs'),
                      ],
                    ),
                  ),
                ],
              ),
              // 3. Persistent Stacked Bottom Section (Quantity top, Add to Cart bottom)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(AppSizes.paddingMd),
                  decoration: BoxDecoration(
                    color: AppColors.background.withOpacity(0.95),
                    border: Border(
                      top: BorderSide(color: AppColors.secondaryContainer.withOpacity(0.3)),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Select Quantity:',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textDark,
                            ),
                          ),
                          Container(
                            height: 40,
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              color: AppColors.secondaryContainer.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(AppSizes.radiusBadge),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove, size: 16, color: AppColors.textDark),
                                  onPressed: () {
                                    if (_quantity > 1) {
                                      setState(() {
                                        _quantity--;
                                      });
                                    }
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                  child: Text(
                                    '$_quantity',
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textDark,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add, size: 16, color: AppColors.textDark),
                                  onPressed: () {
                                    setState(() {
                                      _quantity++;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          elevation: 4,
                          shadowColor: AppColors.primary.withOpacity(0.3),
                          minimumSize: const Size.fromHeight(48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSizes.radiusBadge),
                          ),
                        ),
                        onPressed: () {},
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shopping_bag_outlined, size: 20),
                            SizedBox(width: AppSizes.paddingSm),
                            Text(
                              'Add to Cart',
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                )
              ],
            ),
            child: BottomNavigationBar(
              currentIndex: _navigationIndex,
              backgroundColor: AppColors.background.withOpacity(0.95),
              selectedItemColor: AppColors.primary,
              unselectedItemColor: AppColors.secondary,
              selectedLabelStyle: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 12),
              unselectedLabelStyle: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 12),
              type: BottomNavigationBarType.fixed,
              onTap: (index) {},
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.local_mall_outlined),
                  activeIcon: Icon(Icons.local_mall),
                  label: 'Details',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle_outlined),
                  activeIcon: Icon(Icons.account_circle),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSpecificationRow(String label, String value) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.secondaryContainer.withOpacity(0.3), width: 1),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              color: AppColors.secondary,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }
}