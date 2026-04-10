class Clothing {
  String id;
  String name;
  String category;
  String image; // Para guardar la ruta del archivo de la foto
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

    // Para cargar de SharedPreferences
  factory Clothing.fromMap(Map<String, dynamic> map) => Clothing(
      id: map['id'],
      name: map['name'],
      category: map['category'],
      image: map['image'],
      isFavorite: map['isFavorite'] ?? false,
     );
  }
