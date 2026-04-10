import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';
import 'package:sensors_plus/sensors_plus.dart';
import '../models/clothing.dart';
import '../services/api_service.dart';

class WardrobeProvider with ChangeNotifier {
  /// Cuántas prendas distintas muestra la sugerencia al azar (sacudida).
  static const int suggestedOutfitPieceCount = 4;

  List<Clothing> _clothes = [];
  List<dynamic> _apiSuggestions = []; // Nueva lista para la API
  List<Clothing> _suggestedOutfitItems = [];
  bool _isLoadingApi = false;

  List<Clothing> get clothes => _clothes;
  List<dynamic> get apiSuggestions => _apiSuggestions;
  List<Clothing> get suggestedOutfitItems => List.unmodifiable(_suggestedOutfitItems);
  bool get isLoadingApi => _isLoadingApi;

  WardrobeProvider() {
    _loadFromDisk();
    _initShakeDetection();
  }
  List<Clothing> get favorites => _clothes.where((c) => c.isFavorite).toList();

  // Caegar datos de la la Fake Store API
  Future<void> fetchSuggestions() async {
    _isLoadingApi = true;
    notifyListeners();

    try {
      _apiSuggestions = await ProductService().getProductos();
      print("SUGERENCIAS: $_apiSuggestions");
    } catch (e) {
      print("Error provider: $e");
      _apiSuggestions = [];
    }

    _isLoadingApi = false;
    notifyListeners();
  }

  void addClothing(  {required String name, required String category, required String image} ) {
    final newItem = Clothing(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      category: category,
      image: image,
      isFavorite: false,
    );
    _clothes.add(newItem);
    _saveToDisk();
    notifyListeners();
  }

  void deleteClothing(Clothing item) async {
    _clothes.removeWhere((c) => c.id == item.id);
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 100); // Vibración al eliminar
    }
    _saveToDisk();
    notifyListeners();
  }

  void toggleFavorite(Clothing item) async {
    item.isFavorite = !item.isFavorite;
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 50); 
    }
    _saveToDisk();
    notifyListeners();
  }

  void _initShakeDetection() {
    accelerometerEvents.listen((AccelerometerEvent event) {
      // Si el movimiento es fuerte (sacudida)
      if (event.x.abs() > 15 || event.y.abs() > 15) {
        _randomizeOutfit();
      }
    });
  }

  void _randomizeOutfit() {
    if (_clothes.isEmpty) return;
    final shuffled = List<Clothing>.from(_clothes)..shuffle(Random());
    final usedCategories = <String>{};
    final picked = <Clothing>[];
    for (final item in shuffled) {
      final key = item.category.trim().toLowerCase();
      if (usedCategories.contains(key)) continue;
      usedCategories.add(key);
      picked.add(item);
      if (picked.length >= suggestedOutfitPieceCount) break;
    }
    _suggestedOutfitItems = picked;
    notifyListeners();
  }

  // Persistencia
  void _saveToDisk() async {
    final prefs = await SharedPreferences.getInstance();
    final String data = json.encode(_clothes.map((c) => c.toMap()).toList());
    await prefs.setString('my_wardrobe', data);
  }

  void _loadFromDisk() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString('my_wardrobe');
    if (data != null) {
      final List decoded = json.decode(data);
      _clothes = decoded.map((m) => Clothing.fromMap(m)).toList();
      notifyListeners();
    }
  }
}