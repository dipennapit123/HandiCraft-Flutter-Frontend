class ProductModel {
  final String id;
  final String title;
  final String subTitle;
  final String type;
  final double price;
  final double? originalPrice;
  final String imagePath;
  bool isFavorite;
  final bool isNew;
  final bool isSale;

  ProductModel({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.type,
    required this.price,
    this.originalPrice,
    required this.imagePath,
    this.isFavorite = false,
    this.isNew = false,
    this.isSale = false,
  });

  static List<ProductModel> sampleProducts() {
    return [
      ProductModel(
        id: '1',
        title: 'Sacred Tara Thangka',
        subTitle: 'Hand-painted on canvas',
        type: 'Painting',
        price: 189.0,
        originalPrice: 399.0,
        imagePath: 'assets/images/product1.png',
        isFavorite: false,
        isSale: true,
      ),
      ProductModel(
        id: '2',
        title: 'Tibetan Singing Bowl',
        subTitle: 'Brass alloy, hand-hammered',
        type: 'Music',
        price: 79.0,
        imagePath: 'assets/images/product2.png',
        isFavorite: true,
        isNew: true,
      ),
    ];
  }
}
