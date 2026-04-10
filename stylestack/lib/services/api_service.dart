import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductService {
  static const String _baseUrl = 'https://api.escuelajs.co/api/v1/products';

  Future<List<Producto>> getProductos() async {
  final url = Uri.parse(_baseUrl);

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      return data.map((item) => Producto.fromMap(item)).toList();
    } else {
      throw 'Error HTTP: ${response.statusCode}';
    }
  } catch (e) {
    throw 'Error al cargar productos: $e';
  }
}
}