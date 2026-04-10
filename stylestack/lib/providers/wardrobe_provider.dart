import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';
import 'package:sensors_plus/sensors_plus.dart';
import '../models/clothing.dart';
import '../services/api_service.dart';

class WardrobeProvider with ChangeNotifier {
  List<Clothing> _clothes = [];
  List<dynamic> _apiSuggestions = []; // Nueva lista para la API
  Clothing? _suggestedOutfit;
  bool _isLoadingApi = false;

  List<Clothing> get clothes => _clothes;
  List<dynamic> get apiSuggestions => _apiSuggestions;
  Clothing? get suggestedOutfit => _suggestedOutfit;
  bool get isLoadingApi => _isLoadingApi;

  WardrobeProvider() {
    _loadFromDisk();
    _initShakeDetection(); // Iniciar el Huevo de Pascua
    //fetchSuggestions(); // Carga la API al iniciar
  }

  // Caegar datos de la la Fake Store API
  Future<void> fetchSuggestions() async {
    _isLoadingApi = true;
    notifyListeners();

    try {
      _apiSuggestions = await ApiService().getSuggestions();
      print("SUGERENCIAS: $_apiSuggestions");
    } catch (e) {
      print("Error provider: $e");
      _apiSuggestions = [];
    }

    _isLoadingApi = false;
    notifyListeners();
  }

  void addClothing(Clothing item) {
    _clothes.add(item);
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
      Vibration.vibrate(duration: 50); // Vibración al marcar/desmarcar favorito
    }
    _saveToDisk();
    notifyListeners();
  }

  // Huevo de Pascua: Sacudir para sugerir un outfit aleatorio
  void _initShakeDetection() {
    accelerometerEvents.listen((AccelerometerEvent event) {
      // Si el movimiento es fuerte (sacudida)
      if (event.x.abs() > 15 || event.y.abs() > 15) {
        _randomizeOutfit();
      }
    });
  }

  void _randomizeOutfit() {
    if (_clothes.isNotEmpty) {
      _suggestedOutfit = _clothes[Random().nextInt(_clothes.length)];
      notifyListeners();
    }
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