// lib/view/main_layout.dart
//
// The shell of the app: it holds the bottom navigation bar and swaps
// between the three main screens.

import 'package:flutter/material.dart';
import 'package:handicraftmobilefrontend/utils/app_colors.dart';
import 'package:handicraftmobilefrontend/view/product_details_view.dart';
import 'package:handicraftmobilefrontend/view/shop_view.dart';

class MainLayoutView extends StatefulWidget {
  const MainLayoutView({super.key});

  @override
  State<MainLayoutView> createState() => _MainLayoutViewState();
}

class _MainLayoutViewState extends State<MainLayoutView> {
  // Which tab is open (0 = first tab).
  int _currentIndex = 0;

  // The screens behind the three tabs.
  // ProductDetailView gets showBottomNav: false because this layout
  // already draws the bottom bar.
  final List<Widget> _pages = const [
    ShopView(),
    ProductDetailView(showBottomNav: false),
    Center(
      child: Text('Profile Page', style: TextStyle(color: AppColors.secondary)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      // IndexedStack keeps every screen alive, so the shop keeps its
      // products and scroll position when the user comes back to it.
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          backgroundColor: AppColors.background.withValues(alpha: 0.95),
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.secondary,
          selectedLabelStyle: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() => _currentIndex = index);
          },
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
    );
  }
}
