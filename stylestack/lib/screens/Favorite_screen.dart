import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wardrobe_provider.dart'; 

class Favorite_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Escuchamos el provider
    final wardrobeProvider = context.watch<WardrobeProvider>();
    
    final favoritos = wardrobeProvider.favorites;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4A148C), Color(0xFF1A237E)],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text(
                    'StyleStack',
                    style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Mis Favoritos',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              
              Expanded(
                child: favoritos.isEmpty
                    ? const Center(
                        child: Text(
                          "Aún no tienes favoritos marcados",
                          style: TextStyle(color: Colors.white70),
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 0.85,
                        ),
                        itemCount: favoritos.length,
                        itemBuilder: (context, index) {
                          final item = favoritos[index];
                          return _buildFavoriteCard(context, wardrobeProvider, item);
                        },
                      ),
              ),
              _buildBottomAction(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFavoriteCard(BuildContext context, WardrobeProvider provider, item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(12),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      File(item.image), 
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                item.name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                item.category,
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Column(
              children: [
                
                GestureDetector(
                  onTap: () => provider.deleteClothing(item),
                  child: Icon(Icons.close, size: 20, color: Colors.grey[700]),
                ),
                const SizedBox(height: 15),
                
                GestureDetector(
                  onTap: () => provider.toggleFavorite(item),
                  child: const Icon(Icons.favorite, size: 24, color: Colors.red),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomAction() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: const Text(
        '¡Sacude para sugerir un outfit!',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
        textAlign: TextAlign.center,
      ),
    );
  }
}