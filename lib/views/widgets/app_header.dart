import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/app_colors.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Promo bar
        Container(
          width: double.infinity,
          color: AppColors.promoBar,
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: Text(
            '✦  FREE SHIPPING ON ORDERS ABOVE RS. 5,000  ✦',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: AppColors.white,
              fontSize: 10.5,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.4,
            ),
          ),
        ),
        // App bar row
        Container(
          color: AppColors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              // Search icon (left)
              _HeaderIconButton(
                icon: Icons.search_rounded,
                onTap: () {},
              ),
              const Spacer(),
              // Centered logo
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo circle avatar / fallback
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        'K',
                        style: GoogleFonts.playfairDisplay(
                          color: AppColors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'KALAKOSH',
                    style: GoogleFonts.playfairDisplay(
                      color: AppColors.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // Bell icon (right)
              _HeaderIconButton(
                icon: Icons.notifications_none_rounded,
                onTap: () {},
              ),
            ],
          ),
        ),
        const Divider(height: 1, thickness: 1, color: AppColors.divider),
      ],
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _HeaderIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Icon(icon, color: AppColors.textDark, size: 23),
      ),
    );
  }
}
