import 'package:flutter/material.dart';
import '../providers/wardrobe_provider.dart';
import 'add_clothing_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wardrobe = Provider.of<WardrobeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("StyleStack")),
      body: ListView.builder(
        itemCount: wardrobe.clothes.length,
        itemBuilder: (context, index) {
          final item = wardrobe.clothes[index];

          return ListTile(
            title: Text(item.name),
            subtitle: Text(item.category),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddClothingScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
