import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/clothing.dart';
import '../providers/wardrobe_provider.dart';

class ClothingCard extends StatelessWidget {
  final Clothing item;
  const ClothingCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.file(File(item.image), width: 50, height: 50, fit: BoxFit.cover),
        ),
        title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(item.category),
        trailing: IconButton(
          icon: Icon(
            item.isFavorite ? Icons.favorite : Icons.favorite_border,
            color: item.isFavorite ? Colors.red : null,
          ),
          onPressed: () => context.read<WardrobeProvider>().toggleFavorite(item),
        ),
      ),
    );
  }
}