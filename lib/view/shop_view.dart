// lib/view/ShopView.dart
import 'package:flutter/material.dart';
import 'package:handicraftmobilefrontend/utils/app_colors.dart';
import 'package:handicraftmobilefrontend/utils/app_sizes.dart';
import 'package:handicraftmobilefrontend/utils/app_text_styles.dart';

class ShopView extends StatefulWidget {
  const ShopView({super.key});

  @override
  State<ShopView> createState() => _SHopViewState();
}

class _SHopViewState extends State<ShopView> {
  // Dummy data stored directly inside the view state
  final List<Map<String, dynamic>> products = [
    {
      'title': 'Sacred Oak Buddha',
      'price': '\$1,250.00',
      'rating': '4.9 (124)',
      'badge': 'Limited',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAHVfjVmBYonvc76nEgCIE1unNtnoCjolHtZbF6bsWXIf5D5IIBdMqwNyqW63GQI4iYrJbbGBUqiqwYdV5hmN6BzzFPKJKbHPDiks27afCrHcMAu53N8yjOA3KISqx7F0fGElIdqtypuVaPBmkL45prpt7RjY0tViOkF2Jr63CZSgZ9U5Ti8j6WvqcKD9Igyi2BSAwaHsKBH8NumcfwSqZnpEG6SepTNCHew6Q5kd_wWZEe4R_SGkNudZr2XvqzbOMWuCnf16T2hJx8',
      'isFavorite': true,
    },
    {
      'title': 'Heritage Pashmina',
      'price': '\$420.00',
      'rating': '4.8 (89)',
      'badge': null,
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAVF1zcrywkUatgqcCdI-6XyvviKNxf_eVu1tWiiQJ-TKwo0vjEui5rYeS2-Y6GIRHnGnPz9sRYj0kJLnfmkonc57VON8i1nFsmr0mi3u3vhP04zvChpOu3W_8LmxJavoPcV0WVQB44Z3zc4kpegkB1APqsOTze_W4ePRd1Nbt2nSu1_ZcOorGPpGB-0zeFSQUWE30wfuHqbzKEoSCuugTCZ6Zx-DVueE_aXNcHm0KEOPpYHcnUG9F1ZCuqyZCCdl7gHXVZW0kO00jf',
      'isFavorite': false,
    },
    {
      'title': 'Himalayan Clay Set',
      'price': '\$185.00',
      'rating': '5.0 (42)',
      'badge': 'Eco-Conscious',
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAnbFakJ__BFKlFiOP4hwGfJn8uSnNbsE0upty1qCFMlsEca5WredUb_M-wdcTdlgwrQj_eDk7YkUrCMn5_L5NFPsFRKrABGjZDgjPHOKB1JwpwcNPUoAvqo2MeQLJMFQ6Xsizw1gx-C7Uowmch-9mY_8ymAyw8IJ1eVzWQ8WHcVqA9n7_Tb7kTh8AuIL8lKi2z2u55jqhw37X2K8ssHWBmb-N_npAX1NC-L3M3NXnU7kJU7Bk75B4UDSDgoRYsmczBfoLKs6kwXbPk',
      'isFavorite': false,
    },
    {
      'title': 'Master\'s Singing Bowl',
      'price': '\$340.00',
      'rating': '4.7 (215)',
      'badge': null,
      'imageUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDM6fVp_mfTuaTvlhp3-VyPuM6BniKSTXGe5wxbx8bOcpus3cxv_k8DZ1tmObqUFvTfY2GWOb15Q82lLjM622gv6metxxrTIQVGg4m4XJzRNfB6gLbzdRDWD2Oq2JjMiQ9f50bzFQwA-1W1ge8wK3gJjE8IbDdtD4rZ9G0UzowstW6mHBjylRIAqzFu--HAUt-edO-E8CJkHq3O9XJS-9mfdkJN2x86pM-wHu47d_l7mKIbubqusM4Yd3k9clU_NVa4R3gv2_CrnE5_',
      'isFavorite': false,
    },
    {
      'title': 'Traditional Bronze Tara',
      'price': '\$1,100.00',
      'rating': '4.9 (76)',
      'badge': null,
      'imageUrl':
          'https://images.unsplash.com/photo-1615486511484-92e172cc4ee0?q=80&w=1000&auto=format&fit=crop',
      'isFavorite': false,
    },
    {
      'title': 'Hand-Knotted Hemp Rug',
      'price': '\$280.00',
      'rating': '4.6 (54)',
      'badge': null,
      'imageUrl':
          'https://images.unsplash.com/photo-1600166898405-da9535204843?q=80&w=1000&auto=format&fit=crop',
      'isFavorite': false,
    },
  ];

  final List<String> categories = [
    'Under \$500',
    'Hand-Carved',
    'Natural Silk',
    'Brass Works',
    'Ceramics',
  ];

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
        title: const Text('KalaKosh', style: AppTextStyles.headlineMedium),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.primary),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.notifications_none,
              color: AppColors.primary,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: AppColors.primary,
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.paddingMd,
          vertical: AppSizes.paddingSm,
        ),
        physics: const BouncingScrollPhysics(),
        children: [
          // 1. Heritage Search Field
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search heritage crafts...',
                hintStyle: const TextStyle(
                  color: AppColors.secondary,
                  fontFamily: 'Inter',
                  fontSize: 16,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.secondary,
                ),
                fillColor: AppColors.surfaceContainerLow,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusCircular),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // 2. Horizontal Filter Options
          SizedBox(
            height: 44,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length + 1,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ActionChip(
                      avatar: const Icon(
                        Icons.tune,
                        color: Colors.white,
                        size: 18,
                      ),
                      label: const Text(
                        'Filters',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      side: BorderSide.none,
                      onPressed: () {},
                    ),
                  );
                }
                final category = categories[index - 1];
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: Text(
                      category,
                      style: const TextStyle(
                        color: AppColors.onSecondaryContainer,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    selected: false,
                    backgroundColor: AppColors.secondaryContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    side: BorderSide.none,
                    onSelected: (bool selected) {},
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),

          // 3. Arrangement Header Elements
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    'Sort by: ',
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Text(
                          'New Arrivals',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.primary,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.grid_view, color: AppColors.primary),
                    onPressed: () {},
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
                    icon: const Icon(
                      Icons.format_list_bulleted,
                      color: AppColors.secondary,
                    ),
                    onPressed: () {},
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),

          // 4. Products View Grid Layout (2-Column Aspect Ratio matching 4:5 metric)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 32,
              childAspectRatio: 0.64,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: AppColors.surfaceContainerLow,
                            image: DecorationImage(
                              image: NetworkImage(product['imageUrl']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 12,
                          right: 12,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                product['isFavorite'] = !product['isFavorite'];
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.6),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                product['isFavorite']
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: AppColors.primary,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                        if (product['badge'] != null)
                          Positioned(
                            bottom: 12,
                            left: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                product['badge'].toUpperCase(),
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product['title'],
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF231919),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: AppColors.primary,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        product['rating'],
                        style: const TextStyle(
                          color: AppColors.secondary,
                          fontFamily: 'Inter',
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    product['price'],
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
