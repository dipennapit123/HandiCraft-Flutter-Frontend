import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

import 'widgets/app_header.dart';
import 'widgets/banner_section.dart';
import 'widgets/category_section.dart';
import 'widgets/featured_section.dart';
import 'widgets/support_banner.dart';
import 'widgets/feature_grid.dart';
import 'widgets/artisan_section.dart';
import 'widgets/newsletter_section.dart';
import 'widgets/bottom_nav.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: ScrollConfiguration(
          // Remove glow/stretch overscroll effect
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: ListView(
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.zero,
            children: const [
              AppHeader(),
              BannerSection(),
              CategorySection(),
              FeaturedSection(),
              SupportBanner(),
              FeatureGrid(),
              ArtisanSection(),
              NewsletterSection(),
              _FooterNote(),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNav(
        selectedIndex: _selectedNavIndex,
        onItemTapped: (i) => setState(() => _selectedNavIndex = i),
      ),
    );
  }
}

class _FooterNote extends StatelessWidget {
  const _FooterNote();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        '© 2026 KALAKOSH, NEPAL',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 10.5,
          color: AppColors.textLight,
          letterSpacing: 0.8,
          fontFamily: 'Inter',
        ),
      ),
    );
  }
}
