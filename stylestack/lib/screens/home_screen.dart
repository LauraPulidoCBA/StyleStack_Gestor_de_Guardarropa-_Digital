import 'package:flutter/material.dart';
import '../providers/wardrobe_provider.dart';
import 'package:provider/provider.dart';
import 'add_clothing_screen.dart';
import '../widgets/outfit_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final wardrobe = Provider.of<WardrobeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("StyleStack")),
      body: ListView.builder(
        itemCount: wardrobe.clothes.length,
        itemBuilder: (context, index) {
          final item = wardrobe.clothes[index];

          return ListTile(
            title: Text(item.name),
            subtitle: Text(item.category),
            trailing: IconButton(
              icon: Icon(
                item.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
              onPressed: () {
                wardrobe.toggleFavorite(item);
              },
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddClothingScreen()),
          );
        },
      ),
      bottomNavigationBar: OutfitWidget(),
    );
  }
}
