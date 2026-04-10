import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wardrobe_provider.dart';

class OutfitWidget extends StatelessWidget {
  const OutfitWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final items = context.watch<WardrobeProvider>().suggestedOutfitItems;

    if (items.isEmpty) {
      return Container(
        height: 70,
        color: Colors.deepPurple,
        child: const Center(
          child: Text(
            "¡Sacude para sugerir un outfit!",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    return Container(
      height: 88,
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "OUTFIT SUGERIDO",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${items.length} ${items.length == 1 ? 'prenda' : 'prendas'}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final item = items[index];
                return Tooltip(
                  message: item.name,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      File(item.image),
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.auto_awesome, color: Colors.amber),
        ],
      ),
    );
  }
}