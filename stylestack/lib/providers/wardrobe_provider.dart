import 'package:flutter/material.dart';
import '../models/clothing.dart';

class WardrobeProvider with ChangeNotifier {
  List<Clothing> _clothes = [];

  List<Clothing> get clothes => _clothes;

  void addClothing(Clothing item) {
    _clothes.add(item);
    notifyListeners();
  }

  void deleteClothing(Clothing item) {
    _clothes.remove(item);
    notifyListeners();
  }

  void toggleFavorite(Clothing item) {
    item.isFavorite = !item.isFavorite;
    notifyListeners();
  }
}