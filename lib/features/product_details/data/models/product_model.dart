import 'category_model.dart';
import 'review_model.dart';

class Product {
  final int id;
  final Category category;
  final String name;
  final String price;
  final String discountPrice;
  final String brand;
  final String description;
  final String image;
  final String material;
  final String length;
  final List<Review> reviews;
  final double averageRating;
  final bool isFavorite;

  Product ({
    required this.id,
    required this.category,
    required this.name,
    required this.price,
    required this.discountPrice,
    required this.brand,
    required this.description,
    required this.image,
    required this.material,
    required this.length,
    required this.reviews,
    required this.averageRating,
    required this.isFavorite,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"] ?? 0,
      category:
          json["category"] != null
              ? Category.fromJson(json["category"])
              : Category(id: 0, name: "unknown", slug: ""),
      name: json["name"] ?? "unknown",
      price: json["price"] ?? "0",
      discountPrice: json["discount_price"] ?? "0",
      brand: json["brand"] ?? "",
      description: json["description"] ?? "",
      image: json["image"] ?? "https://via.placeholder.com/150",
      material: json["material"] ?? "",
      length: json["length"] ?? "",
      reviews:
          json["reviews"] != null
              ? (json["reviews"] as List)
                  .map((e) => Review.fromJson(e))
                  .toList()
              : [],
      averageRating:
          json["average_rating"] != null
              ? (json["average_rating"] as num).toDouble()
              : 0.0,
      isFavorite: json["is_favorite"] ?? false,
    );
  }
}
