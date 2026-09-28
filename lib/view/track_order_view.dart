import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrackOrderView extends StatelessWidget {
  const TrackOrderView({super.key});

  static const Color background = Color(0xFFFFF8F7);
  static const Color maroon = Color(0xFF5C0510);
  static const Color textDark = Color(0xFF231919);
  static const Color textMuted = Color(0xFF605E58);
  static const Color border = Color(0xFFDDC0BE);
  static const Color gold = Color(0xFFD4AF37);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(
                top: 88,
                bottom: 80,
              ),
              child: Column(
                children: [
                  _buildHeroSection(),
                  const SizedBox(height: 32),
                  _buildProgressSection(),
                  const SizedBox(height: 32),
                  _buildProductCard(),
                  const SizedBox(height: 24),
                ],
              ),
            ),

            // Top navigation
            _buildTopBar(),

            // Bottom navigation
            _buildBottomNavigation(),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // TOP BAR
  // ---------------------------------------------------------------------------

  Widget _buildTopBar() {
    return Container(
      height: 88,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: background.withOpacity(0.80),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: const SizedBox(
              width: 40,
              height: 40,
              child: Center(
                child: Icon(
                  Icons.arrow_back,
                  size: 22,
                  color: maroon,
                ),
              ),
            ),
          ),

          const SizedBox(width: 16),

          const Text(
            'Track\nOrder',
            style: TextStyle(
              fontFamily: 'Playfair Display',
              fontSize: 24,
              fontWeight: FontWeight.w600,
              height: 1.0,
              color: maroon,
            ),
          ),

          const Spacer(),

          const SizedBox(
            width: 40,
            height: 40,
            child: Center(
              child: Icon(
                Icons.more_horiz,
                size: 22,
                color: maroon,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // HERO
  // ---------------------------------------------------------------------------

  Widget _buildHeroSection() {
    return SizedBox(
      width: double.infinity,
      height: 540,
      child: Stack(
        children: [
          // Hero image
          Positioned.fill(
            child: Image.network(
              'https://placehold.co/390x778',
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) {
                return Container(
                  color: const Color(0xFFE8DAD6),
                  child: const Center(
                    child: Icon(
                      Icons.image_outlined,
                      size: 60,
                      color: textMuted,
                    ),
                  ),
                );
              },
            ),
          ),

          // Bottom gradient
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    background.withOpacity(0.95),
                  ],
                  stops: const [
                    0.55,
                    1.0,
                  ],
                ),
              ),
            ),
          ),

          // Delivery card
          Positioned(
            left: 24,
            right: 24,
            bottom: 0,
            child: _buildDeliveryCard(),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: background.withOpacity(0.90),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: border.withOpacity(0.30),
        ),
        boxShadow: [
          BoxShadow(
            color: maroon.withOpacity(0.08),
            blurRadius: 40,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ARRIVING IN',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.4,
                        color: textMuted,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '12-18 Minutes',
                      style: TextStyle(
                        fontFamily: 'Playfair Display',
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: maroon,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6E2DA).withOpacity(0.50),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.location_on,
                  size: 20,
                  color: maroon,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Container(
            height: 1,
            color: border.withOpacity(0.20),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              // Courier avatar
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: border),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  'https://placehold.co/38x38',
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) {
                    return const Icon(
                      Icons.person,
                      color: textMuted,
                    );
                  },
                ),
              ),

              const SizedBox(width: 16),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Arjun K.',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: textDark,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Verified\nArtisan\nCourier',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        height: 1.33,
                        color: textMuted,
                      ),
                    ),
                  ],
                ),
              ),

              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.phone,
                  size: 14,
                  color: Colors.white,
                ),
                label: const Text(
                  'Call Courier',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: maroon,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  shape: const StadiumBorder(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // ORDER PROGRESS
  // ---------------------------------------------------------------------------

  Widget _buildProgressSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Progress',
                      style: TextStyle(
                        fontFamily: 'Playfair Display',
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: maroon,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'ID: #KK-902341-NP',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        color: textMuted,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF7B1E23).withOpacity(0.20),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: maroon.withOpacity(0.10),
                  ),
                ),
                child: const Text(
                  'In Transit',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: maroon,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 48),

          _buildTimeline(),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    final events = [
      _TimelineData(
        title: 'Order Confirmed',
        description:
            'Your request for hand-carved heritage\npieces has been received.',
        time: 'Oct 24, 10:30 AM',
        completed: true,
      ),
      _TimelineData(
        title: 'Artisan Packed',
        description:
            'Items have been safely secured in\nsustainable lokta paper packaging.',
        time: 'Oct 24, 02:15 PM',
        completed: true,
      ),
      _TimelineData(
        title: 'Shipped from Gallery',
        description:
            'Parcel is en route from our Kathmandu\nCentral Workshop.',
        time: 'Oct 25, 09:00 AM',
        completed: true,
      ),
      _TimelineData(
        title: 'Out for Delivery',
        description:
            'Arjun is nearby with your heritage\nitems.',
        time: 'Today, 11:45 AM',
        completed: false,
        current: true,
      ),
      _TimelineData(
        title: 'Delivered',
        description: 'Signature required upon arrival.',
        time: 'Estimated 12:15 PM',
        completed: false,
      ),
    ];

    return Stack(
      children: [
        // Timeline vertical line
        Positioned(
          left: 11,
          top: 8,
          bottom: 8,
          child: Container(
            width: 2,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  maroon,
                  Color(0xFFE6E2DA),
                ],
              ),
            ),
          ),
        ),

        Column(
          children: [
            for (int i = 0; i < events.length; i++)
              Padding(
                padding: EdgeInsets.only(
                  bottom: i == events.length - 1 ? 0 : 48,
                ),
                child: _buildTimelineItem(events[i]),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildTimelineItem(_TimelineData event) {
    return Padding(
      padding: const EdgeInsets.only(left: 32),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                event.title,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.7,
                  color: event.completed || event.current
                      ? maroon
                      : textMuted,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                event.description,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight:
                      event.current ? FontWeight.w600 : FontWeight.w400,
                  height: 1.5,
                  color: event.completed || event.current
                      ? textDark
                      : textMuted,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                event.time,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  height: 1.33,
                  color: textMuted,
                ),
              ),
            ],
          ),

          // Timeline dot
          Positioned(
            left: -44,
            top: 0,
            child: _buildTimelineDot(event),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineDot(_TimelineData event) {
    if (event.current) {
      return Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: gold,
          shape: BoxShape.circle,
          border: Border.all(
            color: background,
            width: 4,
          ),
        ),
        child: Center(
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      );
    }

    if (event.completed) {
      return Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: maroon,
          shape: BoxShape.circle,
          border: Border.all(
            color: background,
            width: 4,
          ),
        ),
        child: const Center(
          child: Icon(
            Icons.check,
            size: 12,
            color: Colors.white,
          ),
        ),
      );
    }

    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: const Color(0xFFE6E2DA),
        shape: BoxShape.circle,
        border: Border.all(
          color: background,
          width: 4,
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.circle,
          size: 8,
          color: textMuted,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // PRODUCT
  // ---------------------------------------------------------------------------

  Widget _buildProductCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFFEE9E8),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: border.withOpacity(0.20),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              'https://placehold.co/80x80',
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) {
                return Container(
                  color: const Color(0xFFE8DAD6),
                  child: const Icon(
                    Icons.image_outlined,
                    color: textMuted,
                  ),
                );
              },
            ),
          ),

          const SizedBox(width: 16),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Newari Heritage Box',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.7,
                    color: maroon,
                  ),
                ),

                SizedBox(height: 2),

                Text(
                  'Hand-carved Rosewood • 1 Unit',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    color: textMuted,
                  ),
                ),

                SizedBox(height: 8),

                Text(
                  'NPR 8,500',
                  style: TextStyle(
                    fontFamily: 'Playfair Display',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: maroon,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // BOTTOM NAVIGATION
  // ---------------------------------------------------------------------------

  Widget _buildBottomNavigation() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: background.withOpacity(0.90),
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(12),
          ),
          border: Border(
            top: BorderSide(
              color: border.withOpacity(0.30),
            ),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x10000000),
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _bottomNavItem(
              icon: Icons.home_outlined,
              label: 'Home',
              active: false,
              onTap: () => Get.offAllNamed('/'),
            ),

            _bottomNavItem(
              icon: Icons.receipt_long_outlined,
              label: 'Orders',
              active: true,
              onTap: () => Get.offAllNamed('/orders'),
            ),

            _bottomNavItem(
              icon: Icons.person_outline,
              label: 'Profile',
              active: false,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomNavItem({
    required IconData icon,
    required String label,
    required bool active,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: active ? 16 : 12,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: active
              ? const Color(0xFFE6E2DA).withOpacity(0.50)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 19,
              color: active ? maroon : textMuted,
            ),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.7,
                color: active ? maroon : textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// TIMELINE MODEL
// -----------------------------------------------------------------------------

class _TimelineData {
  final String title;
  final String description;
  final String time;
  final bool completed;
  final bool current;

  const _TimelineData({
    required this.title,
    required this.description,
    required this.time,
    this.completed = false,
    this.current = false,
  });
}