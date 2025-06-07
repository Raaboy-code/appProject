// lib/models/category_model.dart
class Category {
  final String id;
  final String name;
  final String imageUrl; // Assuming your API returns an image URL

  Category({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  // Factory constructor to create a Category object from JSON data
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as String, // Ensure type safety
      name: json['name'] as String, // Ensure type safety
      imageUrl: json['imageUrl'] as String, // Ensure type safety
    );
  }
}