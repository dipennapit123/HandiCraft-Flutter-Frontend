import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_images.dart';

class BannerSection extends StatefulWidget {
  const BannerSection({super.key});

  @override
  State<BannerSection> createState() => _BannerSectionState();
}

class _BannerSectionState extends State<BannerSection> {
  final PageController _controller = PageController();

  final List<_BannerData> _banners = [
    _BannerData(
      title: 'Discover Authentic\nNepali Handicrafts',
      subtitle:
          'Connecting local artisans with the world — every piece tells a story of Himalayan heritage.',
      image: AppImages.banner,
    ),
    _BannerData(
      title: 'Handcrafted With\nLove & Tradition',
      subtitle:
          'Each item is carefully crafted by skilled artisans from the hills of Nepal.',
      image: AppImages.support,
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Column(
        children: [
          // Carousel image area
          AspectRatio(
            aspectRatio: 390 / 260,
            child: PageView.builder(
              controller: _controller,
              onPageChanged: (_) {},
              itemCount: _banners.length,
              itemBuilder: (_, i) => _BannerSlide(data: _banners[i]),
            ),
          ),
          // Text content below carousel
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Discover Authentic\n',
                        style: GoogleFonts.playfairDisplay(
                          color: AppColors.textDark,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          height: 1.25,
                        ),
                      ),
                      TextSpan(
                        text: 'Nepali Handicrafts',
                        style: GoogleFonts.playfairDisplay(
                          color: AppColors.primary,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          height: 1.25,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Connecting local artisans with the world — every piece tells a story of Himalayan heritage.',
                  style: GoogleFonts.inter(
                    color: AppColors.textMedium,
                    fontSize: 13,
                    height: 1.55,
                  ),
                ),
                const SizedBox(height: 20),
                // SHOP NOW button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'SHOP NOW',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.6,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Page indicator
                Center(
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: _banners.length,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: AppColors.primary,
                      dotColor: AppColors.divider,
                      dotHeight: 6,
                      dotWidth: 6,
                      expansionFactor: 3,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BannerData {
  final String title;
  final String subtitle;
  final String image;
  _BannerData(
      {required this.title, required this.subtitle, required this.image});
}

class _BannerSlide extends StatelessWidget {
  final _BannerData data;
  const _BannerSlide({required this.data});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      data.image,
      fit: BoxFit.cover,
      width: double.infinity,
      errorBuilder: (_, __, ___) => Container(
        color: AppColors.cardBackground,
        child: const Icon(
          Icons.image_outlined,
          color: AppColors.textLight,
          size: 48,
        ),
      ),
    );
  }
}
