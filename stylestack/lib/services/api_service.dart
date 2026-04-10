import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<dynamic>> getSuggestions() async {
    try {
      //  USAMOS ESTA URL (ESTABLE)
      final url = Uri.parse('https://fakestoreapi.com/products');

      final response = await http.get(url);

      print("STATUS: ${response.statusCode}");

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);

        //  FILTRAMOS SOLO ROPA
        return data.where((item) =>
          item['category'].toString().contains('clothing')
        ).toList();
      }

      return [];
    } catch (e) {
      print("ERROR API: $e");
      return [];
    }
  }
}