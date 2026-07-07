import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/app_colors.dart';

class FeatureGrid extends StatelessWidget {
  const FeatureGrid({super.key});

  static const _features = [
    _FeatureItem(
      icon: Icons.verified_outlined,
      title: '100% Authentic',
      subtitle: 'Genuine handcrafted ite...',
    ),
    _FeatureItem(
      icon: Icons.local_shipping_outlined,
      title: 'Free Delivery',
      subtitle: 'Orders above \$50',
    ),
    _FeatureItem(
      icon: Icons.lock_outline_rounded,
      title: 'Secure Pay',
      subtitle: 'Safe & encrypted payme...',
    ),
    _FeatureItem(
      icon: Icons.favorite_outline_rounded,
      title: 'Ethical Sourcing',
      subtitle: 'Tibetan handicrafts',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      // Use a fixed 2-column grid with calculated rows instead of GridView
      // to avoid nested scroll conflicts and ensure proper height.
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _FeatureCard(feature: _features[0])),
              const SizedBox(width: 12),
              Expanded(child: _FeatureCard(feature: _features[1])),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _FeatureCard(feature: _features[2])),
              const SizedBox(width: 12),
              Expanded(child: _FeatureCard(feature: _features[3])),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeatureItem {
  final IconData icon;
  final String title;
  final String subtitle;
  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}

class _FeatureCard extends StatelessWidget {
  final _FeatureItem feature;
  const _FeatureCard({required this.feature});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          // Icon circle
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              feature.icon,
              color: AppColors.primary,
              size: 17,
            ),
          ),
          const SizedBox(width: 9),
          // Text — Expanded prevents overflow
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  feature.title,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 1),
                Text(
                  feature.subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 9.5,
                    color: AppColors.textLight,
                    height: 1.3,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
