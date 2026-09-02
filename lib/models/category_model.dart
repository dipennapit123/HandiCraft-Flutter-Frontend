class CategoryModel {
    CategoryModel({
        required this.success,
        required this.categories,
    });

    final bool? success;
    final List<Category> categories;

    factory CategoryModel.fromJson(Map<String, dynamic> json){ 
        return CategoryModel(
            success: json["success"],
            categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
        );
    }

}

class Category {
    Category({
        required this.id,
        required this.name,
        required this.parentCategory,
        required this.image,
        required this.status,
        required this.slug,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String? id;
    final String? name;
    final dynamic parentCategory;
    final String? image;
    final String? status;
    final String? slug;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    factory Category.fromJson(Map<String, dynamic> json){ 
        return Category(
            id: json["_id"],
            name: json["name"],
            parentCategory: json["parent_category"],
            image: json["image"],
            status: json["status"],
            slug: json["slug"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            v: json["__v"],
        );
    }

}
