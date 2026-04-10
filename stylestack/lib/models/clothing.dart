class Clothing {
  String id;
  String name;
  String category;
  String image;
  bool isFavorite;

  Clothing({
    required this.id,
    required this.name,
    required this.category,
    required this.image,
    this.isFavorite = false,
  });

  // Para guardar en SharedPreferences
  Map<String, dynamic> toMap() => {
      'id': id,
      'name': name,
      'category': category,
      'image': image,
      'isFavorite': isFavorite,
    };

  factory Clothing.fromMap(Map<String, dynamic> map) => Clothing(
      id: map['id'],
      name: map['name'],
      category: map['category'],
      image: map['images'],
      isFavorite: map['isFavorite'] ?? false,
     );
  }