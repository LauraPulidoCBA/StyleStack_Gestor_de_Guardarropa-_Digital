models/clothing.dart


class Clothing {
  String name;
  String category;
  String image;
  bool isFavorite;

  Clothing({
    required this.name,
    required this.category,
    required this.image,
    this.isFavorite = false,
  });
}