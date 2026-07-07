class CategoryModel {
  final String id;
  final String title;
  final String imagePath;
  final bool isSelected;

  CategoryModel({
    required this.id,
    required this.title,
    required this.imagePath,
    this.isSelected = false,
  });

  static List<CategoryModel> sampleCategories() {
    return [
      CategoryModel(
        id: '1',
        title: 'Painting',
        imagePath: 'assets/images/product1.png',
        isSelected: true,
      ),
      CategoryModel(
        id: '2',
        title: 'Textiles',
        imagePath: 'assets/images/category.png',
      ),
      CategoryModel(
        id: '3',
        title: 'Pottery',
        imagePath: 'assets/images/support.png',
      ),
      CategoryModel(
        id: '4',
        title: 'Jewelry',
        imagePath: 'assets/images/category.png',
      ),
    ];
  }
}
