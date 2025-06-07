// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:electric_app/models/category_model.dart'; // Adjust this path!

class ApiService {
  // IMPORTANT: For localhost on Android emulator/iOS simulator,
  // use your machine's IP address or '10.0.2.2' for Android emulator.
  // 'localhost' or '127.0.0.1' won't work directly from the emulator/device.
  // For web, 'localhost' is fine.
  final String baseUrl = "https://10.0.2.2:7151/api/"; // <<< Adjust this for your setup!

  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse('${baseUrl}Category')); // Assuming 'Category' is your endpoint

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Category.fromJson(json as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to load categories: ${response.statusCode}');
    }
  }

  Future<List<Category>> fetchBrands() async {
    // Assuming you have a separate API endpoint for brands, e.g., 'https://localhost:7151/api/Brand'
    // If brands are just categories with a different ID, you might filter them from fetchCategories()
    final response = await http.get(Uri.parse('${baseUrl}Brand')); // Adjust if your brand endpoint is different

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Category.fromJson(json as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to load brands: ${response.statusCode}');
    }
  }
}