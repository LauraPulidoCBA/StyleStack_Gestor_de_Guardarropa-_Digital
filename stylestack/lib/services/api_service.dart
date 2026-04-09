import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  Future getSuggestions() async {
    final response = await http.get(
      Uri.parse('https://fakestoreapi.com/products/category/clothing'),
    );

    return jsonDecode(response.body);
  }
}