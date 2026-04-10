import 'package:flutter/material.dart';
import '../models/clothing.dart';

class ClothingCard extends StatelessWidget {
  final Clothing item;

  const ClothingCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(item.name),
        subtitle: Text(item.category),
        trailing: Icon(Icons.favorite),
      ),
    );
  }
}