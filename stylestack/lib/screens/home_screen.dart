import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wardrobe_provider.dart';
import '../widgets/clothing_card.dart';
import '../widgets/outfit_widget.dart';
import 'add_clothing_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wardrobe = context.watch<WardrobeProvider>();

    // Evita llamadas infinitas a la API
    if (wardrobe.apiSuggestions.isEmpty && !wardrobe.isLoadingApi) {
      Future.microtask(() => wardrobe.fetchSuggestions());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "StyleStack",
          style: TextStyle(color: Colors.black), 
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black, 
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF4A148C), // morado oscuro
              Color(0xFF0D47A1), // azul oscuro
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SUGERENCIAS
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Sugerencias de Temporada",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            SizedBox(
              height: 160,
              child: wardrobe.isLoadingApi
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: wardrobe.apiSuggestions.length,
                      itemBuilder: (context, index) {
                        final suggestion =
                            wardrobe.apiSuggestions[index];

                        return Container(
                          width: 120,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    suggestion['image'] ?? '',
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) =>
                                        const Icon(Icons.error,
                                            color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                suggestion['title'] ?? 'Sin nombre',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),

            //  MI GUARDARROPA
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Mi Guardarropa",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            Expanded(
              child: wardrobe.clothes.isEmpty
                  ? const Center(
                      child: Text(
                        "Tu guardarropa está vacío.",
                        style: TextStyle(color: Colors.white70),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 100),
                      itemCount: wardrobe.clothes.length,
                      itemBuilder: (context, index) {
                        final item = wardrobe.clothes[index];

                        return Dismissible(
                          key: Key(item.id),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding:
                                const EdgeInsets.only(right: 20.0),
                            child: const Icon(Icons.delete,
                                color: Colors.white),
                          ),
                          onDismissed: (_) =>
                              wardrobe.deleteClothing(item),
                          child: ClothingCard(item: item),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      //  BOTÓN
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          child: const Icon(Icons.add_a_photo, color: Colors.white),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => const AddClothingScreen()),
          ),
        ),
      ),

      //  MINI PLAYER
    );
  }
}