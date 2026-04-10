import 'package:flutter/material.dart';
import '../models/clothing.dart';

class ClothingCard extends StatelessWidget {
  final Clothing item;

  const ClothingCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Icon(Icons.checkroom, color: Colors.blueAccent),
        title: Text(item.name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(item.category),
        trailing: Icon(Icons.favorite, color: item.isFavorite ? Colors.red : Colors.grey),
      ),
    );
  }
}