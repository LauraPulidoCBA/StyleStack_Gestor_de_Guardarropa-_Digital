import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wardrobe_provider.dart';

class OutfitWidget extends StatelessWidget {
    const OutfitWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final suggested = context.watch<WardrobeProvider>().suggestedOutfitItems.isNotEmpty
        ? context.watch<WardrobeProvider>().suggestedOutfitItems.first
        : null;

    if (suggested == null) {
      return Container(
        height: 70,
        color: Colors.deepPurple,
        child: const Center(
          child: Text(
            "¡Sacude para sugerir un outfit!",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      );
    }

    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(File(suggested.image), width: 50, height: 50, fit: BoxFit.cover),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("OUTFIT SUGERIDO",
                  style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
                Text(suggested.name, 
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const Icon(Icons.auto_awesome, color: Colors.amber),
        ],
      ),
    );
  }
}
   