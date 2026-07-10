// lib/view/MainLayoutView.dart
import 'package:flutter/material.dart';
import 'package:handicraftmobilefrontend/utils/app_colors.dart';
import 'package:handicraftmobilefrontend/view/shop_view.dart';

class MainLayoutView extends StatefulWidget {
  const MainLayoutView({super.key});

  @override
  State<MainLayoutView> createState() => _MainLayoutViewState();
}

class _MainLayoutViewState extends State<MainLayoutView> {
  int _currentIndex = 0;

  // Swapped the middle tab to display your new product details page for easy viewing!
  final List<Widget> _pages = [
    const ShopView(),
    const Center(
      child: Text('Orders Page', style: TextStyle(color: AppColors.secondary)),
    ),
    const Center(
      child: Text('Profile Page', style: TextStyle(color: AppColors.secondary)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          backgroundColor: AppColors.background.withOpacity(0.9),
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
            setState(() {
              _currentIndex = index;
            });
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
